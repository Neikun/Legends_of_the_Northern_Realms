-- *************************
--  EXSP MAIN MODULE, V1.4.1
-- *************************

-- DEFINE EXSP OBJECTS
-- ===================

cloneObject{
	name = "spell_spinner_90",
	baseObject = "teleporter",
}

cloneObject{
	name = "spell_spinner_180",
	baseObject = "teleporter",
}

cloneObject{
	name = "spell_spinner_270",
	baseObject = "teleporter",
}

cloneObject{
	name = "spell_spinner_direction",
	baseObject = "teleporter",
}

cloneObject{
	name = "spell_spinner_teleport",
	baseObject = "teleporter",
}

cloneObject{
	name = "party",
	baseObject = "party",
	onDrawGui = function()
		exsp.hooksTimer()
		extend.objectDetector()
	end
}

-- LOAD EXSP SCRIPT
-- ================

fw_addModule("exsp",[[
-- EXSP script entity, version 1.4.1

sd = {}
spellDefs = {}
hooksTimerTable = {}
monsterDefs = {}
fxDefs = {}
damageHandler = {}
damageHandler.onDamageFilter = {}
damageHandler.monsterGroup = {}
damageHandler.monsterGroupCtr = {}
damageHandler.monsterGroupTable = {}
damageHandler.monsterReplaceAttack = false
partyMove = nil
holdMonsterTable = {}
freezeMonsterTable = {}
immunizeMonsterTable = {}
monsterHooks = {}
hookNames = {"onCast", "onPass", "onMonsterHit", "onDoorHit", "onPartyHit", "onHit"}
defaultSpells = {"fireburst", "fireball", "fireball_greater", "shockburst", "lightning_bolt", "lightning_bolt_greater", "poison_bolt", "poison_bolt_greater", "ice_shards", "frostburst", "frostbolt", "improved_frostbolt"}
exspCtr = 0
exspCtrLimit = 2000

debugDefinitions = false
debugProperties = false
debugSpells = false
debugHooks = false



-- ****************************
-- SPELL SPAWN FUNCTIONS
-- ****************************

function spellSpawn(self, name, arg2, arg3, arg4, arg5, arg6)
	if type(arg2) == "string" or type(arg2) == "table" then
		self:spellSpawnFromSpawner(name, arg2, arg3, arg4)
	else
		self:spellSpawnFromNil(name, arg2, arg3, arg4, arg5, arg6)
	end
end

function spellSpawnFromSpawner(self, name, spawner, facing, properties)
	if type(spawner) == "string" then
		spawner = findEntity(spawner)
	elseif type(spawner) ~= "table" then
		return false
	end
	if not(spawner) then
		return false
	end
	
	facing = facing or spawner.facing
	
	local spell = self:createSpellObject(name, spawner.level, spawner.x, spawner.y, facing)
	spell.spawner = spawner.id
	spell._spawnerClass = spawner.class
	spell._type = "spawned"
	spell:addProperties(properties)
	
	if spell._spawnerClass == "Monster" or spell._spawnerClass == "Party" then
		spell._spawnAhead = true
	end
	
	spell:launchModule()	
end

function spellSpawnFromNil(self, name, level, x, y, facing, properties)
	local spell = self:createSpellObject(name, level, x, y, facing)
	spell._type = "spawned"
	spell:addProperties(properties)
	if properties.spawnAhead then
		spell._spawnAhead = true
	end
	if spell._ordinal then
		spell.spawner = "party"
		spell._spawnerClass = "Party"
	end
	spell:launchModule()	
end

function spellCast(self, name, caster, properties)
	local spell = self:createSpellObject(name, party.level, party.x, party.y, party.facing)
	spell._ordinal = caster:getOrdinal()
	spell:addCasterSkills(caster)
	spell.spawner = "party"
	spell._type = "cast"
	spell._spawnerClass = "Party"
	spell._spawnAhead = true
	spell:addProperties(properties)
	spell:launchModule()
end

function spellDetect(self, name, caster)
	local spell = self:createSpellObject(name, party.level, party.x, party.y, party.facing)
	spell.spawner = "party"
	spell._ordinal = caster:getOrdinal()
	spell._type = "detected"
	spell._spawnerClass = "Party"
	spell:addCasterSkills(caster)
	return spell:launchModule()
end

function launchModule(self)
	
	if self.level ~= party.level then
		self:destroySpellObject()
		return false
	end

	-- onCast hook
	if self._spawnerClass == "Monster" or self._spawnerClass == "Party" then
		local hookReturn = self:onCastHook()
		if hookReturn == false then
			return false
		elseif hookReturn then
			local newSpell = exsp:createSpellObject(hookReturn, self.level, self.x, self.y, self.facing)
			newSpell:addProperties(self)
			if self._type == "detected" then
				newSpell._type = "cast"
			end
			newSpell._spawnAhead = true
			self = newSpell
		end
	end
	
	
	if self._burst or not(self._spawnAhead) then
		if self._type == "detected" and self.spawner == "party" then
			exsp.delay(0.05,
				function(self, spell)
					local level, x, y = spell:getPosition()
					local detectedSpell = exsp.findSpell(level,x,y)
					if not(detectedSpell) and exsp.partyMove then
						local mx, my = 0, 0
						if not(exsp:getCollisionAhead(level, x, y, exsp.partyMove)) then
							mx, my = getForward(exsp.partyMove)
						end
						detectedSpell = exsp.findSpell(level,x+mx,y+my)
					end
					if not(detectedSpell) then
						return false
					end
					
					local newSpell = exsp:createSpellObject(detectedSpell.name, detectedSpell.level, detectedSpell.x, detectedSpell.y, detectedSpell.facing, detectedSpell.id)
					newSpell:addProperties(spell)
					spell:destroySpellObject()
					newSpell:exspCore()
				end,
				{self}
			)
		else
			self:exspCore()
		end
	else
		local fxId = self:playLaunchFx()
		local hitType = self:getCollisionAhead()
		local delayTime = 3
		if hitType == "door" or hitType == "wall" then
			delayTime = 0
		end
		exsp.delay(1/self._projectileSpeed*delayTime+0.1,
			function(self, fxId, spell)
				if findEntity(fxId) then
					findEntity(fxId):destroy()
				end
				spell:exspCore()
			end,
			{fxId, self}
		)
	end

	if self._type ~= "detected" then
		return false
	end
end

-- ****************************
-- EXSP CORE MODULE
-- ****************************

function exspCore(self)

	self.distance = self.distance or 0
	local dx, dy = getForward(self.facing)
	
	if self.name == "ice_shards" then

		self.x = self.x + dx
		self.y = self.y + dy
		self._type = "iceShards"
				
		local iceShardsDetectedMonsters = {}
		for i = 0,3 do
			local hitType, subType, entity = exsp:getCollisionAhead(self.level, self.x+dx*(i-1), self.y+dy*(i-1), self.facing)
			if hitType == "monster" then
				local monsterDetected = false
				local dh = exsp.damageHandler
				for j, w in ipairs(entity) do
					for k,v in ipairs(iceShardsDetectedMonsters) do
						if w.id == v then
							monsterDetected = true
						end
					end
				end
				if not(monsterDetected) then
					dh.monsterGroupTable[self.id] = {}
					for i,v in ipairs(entity) do      
						table.insert(dh.monsterGroupTable[self.id], v.id)
						table.insert(iceShardsDetectedMonsters, v.id)
						dh.onDamageFilter[v.id] = self.id
					end
					exsp.delay(0.25*(i+1),
						function(self, spell, hitType, subType, monsterGroupTable)
							spell:onHitHook(hitType, subType, monsterGroupTable, "iceShards_"..i)
						end,
						{self, hitType, subType, dh.monsterGroupTable[self.id]}
					)
				end
			end
			if hitType == "party" then
				dh.onDamageFilter["party"] = self.id
				exsp.delay(0.25*(i+1),
					function(self, spell)
						spell:onHitHook("party", nil, party, "iceShards_"..i)
					end,
					{self}
				)
			end
		end
		if self.spawner ~= "party" then
			spawn(self._spawnObject, self.level, self.x, self.y, self.facing, self.id)
		end
		if debugSpells then
			print("Spell spawned: "..self.id)
		end
		return false
	end
	
	if self._spawnAhead then
		self.x = self.x + dx
		self.y = self.y + dy
	end
	
	self._hookTimerCounter1 = 0
	
	-- debug code
	if debugSpells then
		print("self "..self._type..": "..self.id)
	end	
	
	if self._spawnAhead and self._maxDistance and (self.distance + 1) > self._maxDistance then
		self:destroySpellObject()
		return false
	end	

	-- Initial hook detection for spells spawned one tile ahead
	local onHitDetectedAhead = false
	local hitType, subType, entity
	if self._spawnAhead then
		hitType, subType, entity = exsp:getCollisionAhead(self.level, self.x-dx, self.y-dy, self.facing)
		if hitType then
			onHitDetectedAhead = true
		end
		if hitType == "monster" or hitType == "party" then
			local dh = exsp.damageHandler
			if hitType == "monster" then
				dh.monsterGroupTable[self.id] = {}
				dh.monsterGroup[self.id] = #entity
				dh.monsterGroupCtr[self.id] = 0
				for _,v in ipairs(entity) do
					table.insert(dh.monsterGroupTable[self.id], v.id)
					dh.onDamageFilter[v.id] = self.id
				end
				exsp.delay(0.1,
					function(self, spell, hitType, subType, monsterGroupTable)
						if not(spell._onHitCalled) then
							spell:destroy()
							spell:destroySpellObject()
							spell:onHitHook(hitType, subType, monsterGroupTable, "exspCore")
						end
					end,
					{self, hitType, subType, dh.monsterGroupTable[self.id]}
				)
			else
				dh.onDamageFilter["party"] = self.id
			end
		elseif hitType == "door" or hitType == "wall" then
			if entity then
				self:onHitHook(hitType, subType, entity.id, "exspCorePreHit")
			else
				self:onHitHook(hitType, subType, nil, "exspCorePreHit")
			end
			self._preHit = true
			self:playHitFx()
			return false
		end
	end

	-- Spawn spell
	if self._spawnObject and self._type ~= "detected" then
		if not(self._spawnAhead) and not(self._burst) and not(self.noLaunch) and not(self._spinned) then
			playSoundAt(self._launchSound, self.level, self.x, self.y)
		end
		self:spawnSpellEntity()
	end
	
	-- Burst spell onHit
	if self._burst then
		if hitType then
			if entity then
				self:onHitHook(hitType, subType, entity.id, "exspCore")
			else
				self:onHitHook(hitType, subType, nil, "exspCore")
			end
		end
		self:destroySpellObject()
		return false
	end
		
	-- First onPassHook for spells spawned one square ahead
	if self._spawnAhead and not(self._burst) and not(onHitDetectedAhead) then
		self.distance = self.distance + 1
		if debugProperties and self[debugProperties] then
			print("Spell "..self.id..", "..debugProperties.." = "..self[debugProperties])
		end
		
		-- onPass hook
		local hookReturn
		hookReturn = self:onPassHook()
		if hookReturn == false then 
			self:destroySpellObject()
			return false 
		end
		
		-- maxDistance check
		if self._maxDistance and self.distance + 1 > self._maxDistance then
			self:destroy()
			self:destroySpellObject()
			return false
		end
	end
	
	-- Spinner check
	if not(self._spinned) then
		if self:isOnSpinner() then
			self:activateSpinner()
			return false
		end
	end
	self._spinned = nil			
	
	-- Set core spell timer
	local spellTimer = timers:create("exspTimer."..self.id)
	spellTimer:addCallback(
		function(self,spell)
			if findEntity(spell.id) then
				spell.distance = spell.distance + 1
				spell.x = findEntity(spell.id).x
				spell.y = findEntity(spell.id).y
				
				if exsp.debugProperties and spell[exsp.debugProperties] then
					print("Spell "..spell.id..", "..exsp.debugProperties.." = "..spell[exsp.debugProperties])
				end
								
				-- onPass Hook
				local hookReturn
				hookReturn = spell:onPassHook()
				if hookReturn == false then 
					return false 
				end
				
				-- maxDistance check
				if spell._maxDistance and spell.distance + 1 > spell._maxDistance then
					spell:destroy()
					return false
				end
				
				-- Spinner check
				if spell:isOnSpinner() then
					spell:activateSpinner()
					return false
				end
									
			else
				spell:destroySpellObject()
				self:deactivate()
				self:destroy()
			end
		end,
		{self}
	)
	spellTimer:setTimerInterval(1/self._projectileSpeed*3)
	spellTimer:setTickLimit(50,true)
	spellTimer:activate()
	
	table.insert(exsp.hooksTimerTable, self)
end
	
function hooksTimer()
	for i,spell in ipairs(exsp.hooksTimerTable) do
		if not(spell._stopTracking) then
			-- Check for monsters or party on the spell's tile or ahead and render immune to damage for hook execution
			local hitType, subType, entity 
			hitType, entity = spell:getCollisionOnTile()
			if not(hitType) then
				hitType, subType, entity = spell:getCollisionAhead()
			end
			
			if findEntity(spell.id) then
			
				if not(spell._onHitCalled) then
					if hitType == "monster" or hitType == "party" then
						local dh = exsp.damageHandler
						spell._hookTimerCounter1 = 0
						if hitType == "monster" then
							local mGroupTable = {}
							dh.monsterGroupTable[self.id] = {}
							dh.monsterGroup[spell.id] = #entity
							dh.monsterGroupCtr[spell.id] = 0
							for _,v in ipairs(entity) do
								table.insert(mGroupTable, v.id)
								dh.onDamageFilter[v.id] = spell.id
							end
							dh.monsterGroupTable[spell.id] = mGroupTable
						else
							dh.onDamageFilter["party"] = spell.id
						end
					else
						spell._hookTimerCounter1 = spell._hookTimerCounter1 + 1
						local dh = exsp.damageHandler
						if dh.monsterGroupTable[spell.id] and spell._hookTimerCounter1 > 5 then
							for _,v in ipairs(dh.monsterGroupTable[spell.id]) do
								dh.onDamageFilter[v] = nil
							end
							dh.monsterGroup[spell.id] = nil
							dh.monsterGroupCtr[spell.id] = nil
							dh.monsterGroupTable[spell.id] = nil
						end
					end
				end
			
			elseif spell then
			
				-- Call onHit hook if it hasn't been called from onDamage hooks
				if spell._hookTimerCounter2 == nil then
					spell._hookTimerCounter2 = 0
				end
				spell._hookTimerCounter2 = spell._hookTimerCounter2 + 1
				if spell._hookTimerCounter2 == 2 then
					local dh = exsp.damageHandler
					if not(spell._spinned) and not(spell._destroyed) and not(spell._onHitCalled) then
						if hitType == "monster" then
							spell:onHitHook(hitType, subType, dh.monsterGroupTable[spell.id], "exspCore")
						elseif hitType then
							if entity then
								spell:onHitHook(hitType, subType, entity.id, "exspCore")
							else
								spell:onHitHook(hitType, subType, nil, "exspCore")
							end
						else
							spell:onHitHook("wall", nil, nil, "exspCore")
						end
					end
					spell._stopTracking = true
				end
			end
		end
	end
end

-- ****************************
-- SPELL SPINNER FUNCTIONS
-- ****************************

function activateSpinner(self)
	local level, x, y = self:getPosition()
	local spinner = grimq.fromIterator(entitiesAt(level, x, y))
		:where(function(v) return grimq.strstarts(v.name,"spell_spinner") == true and v:isActivated() == true; end)
		:take(1)
		:toArray()
	
	if spinner[1] then
		local facing = self.facing
		if spinner[1].name == "spell_spinner_90" then
			facing = (facing + 1)%4
		elseif spinner[1].name == "spell_spinner_180" then
			facing = (facing + 2)%4
		elseif spinner[1].name == "spell_spinner_270" then
			facing = (facing + 3)%4
		elseif spinner[1].name == "spell_spinner_direction" then
			if self.facing == spinner[1].facing then
				return false
			else
				facing = spinner[1].facing
			end
		elseif spinner[1].name == "spell_spinner_teleport" then
			level, x, y, facing = exsp.getSpellSpinnerTarget(spinner[1].id)
			if facing ~= spinner[1].facing then
				facing = self.facing
			end
		end
		
		self:destroy()
		local newSpell = exsp:createSpellObject(self.name, level, x, y, facing)
		newSpell:addProperties(self)
		self:destroySpellObject()
		newSpell._type = "respawned"
		newSpell._spinned = true
		newSpell:exspCore()
	end
end

function isOnSpinner(self)
	local level, x, y = self:getPosition()
	local spinner = grimq.fromIterator(entitiesAt(level, x, y))
			:where(function(v) return grimq.strstarts(v.name,"spell_spinner") == true; end)
			:take(1)
			:toArray()
	if spinner[1] then
		return true
	else
		return false
	end
end

function getSpellSpinnerTarget(id)
	local target = findEntity(id.."_target")
	if target then
		return target.level, target.x, target.y, target.facing
	else
		return nil, nil, nil, nil
	end	
end

function setSpellSpinnerTarget(self, id, level, x, y, facing, invisible, changeFacing)
	invisible = invisible or false
	if changeFacing == false then
		facing = (findEntity(id).facing + 2)%4
	end
	local target = findEntity(id.."_target")
	if target then
		target:destroy()
	end
	spawn("spell_spinner_teleport", level, x, y, facing, id.."_target")
		:setTriggeredByParty(false)
		:setTriggeredByMonster(false)
		:setTriggeredByItem(false)
		:setTeleportTarget(x, y, facing, level)
		:setInvisible(invisible)
		:activate()
end

-- ****************************
-- EFFECTS FUNCTIONS
-- ****************************

function playLaunchFx(self)

	local level, x, y = self:getPosition()
	local facing = self.facing
	
	-- Play launch sound
	if self._launchSound then
		playSoundAt(self._launchSound, level, x, y)
	end
	
	return self:playSpellProjectileFx(level, x, y, facing, 1, false)	
end

function playSpellProjectileFx(self, level, x, y, facing, distance, destroyFx)
	
	if type(self) == "string" then
		local name = self
		self = {}
		for k, v in pairs(exsp.spellDefs[name]) do
			self["_"..k] = v
		end
	end
	
	-- Set particle system FX
	local fxId = exsp.randomId("launchAnimationFx")
	local vOffset = self._vOffset or 1.35
	spawn("fx", level, x, y, facing, fxId)
	if self._particleSystemNoTrail then
		findEntity(fxId):setParticleSystem(self._particleSystemNoTrail)
		spawn("fx", level, x, y, facing, fxId..".trail")
			:setParticleSystem(self._particleSystemTrail)
			:translate(0,vOffset,0)
	else
		findEntity(fxId):setParticleSystem(self._particleSystem)
	end
	
	local red, green, blue = unpack(self._lightColor)
	local time = 10000
	findEntity(fxId):setLight(red, green, blue, self._lightBrightness, self._lightRange, time, self._castShadow)
	findEntity(fxId):translate(0,vOffset,0)
		
	-- Animate FX with timer
	local dx, dy = getForward(facing)
	local interval = self._projectileSpeed/20
	
	dx = dx * interval
	dy = dy * interval

	local fxTimer = timers:create(exsp.randomTimerId("fxTimer"))
	fxTimer:setTimerInterval(0.05)
	fxTimer:addCallback(
		function(self, fxId, dx, dy)
			if findEntity(fxId) then
				findEntity(fxId):translate(dx,0,-dy)
			end
			if findEntity(fxId..".trail") then
				findEntity(fxId..".trail"):translate(dx,0,-dy)
			end
		end,
		{fxId, dx, dy}
	)
	fxTimer:setTickLimit(math.ceil((20/(self._projectileSpeed/3))*distance),true)
	fxTimer.fxId = fxId
	fxTimer.destroyFx = destroyFx
	fxTimer.onDeactivate = function(self)
			if self.destroyFx then
				exsp.delay(0.2, 
					function(self, fxId)
						if findEntity(fxId) then
							findEntity(fxId):destroy()
						end
						if findEntity(fxId..".trail") then
							--findEntity(fxId..".trail"):destroy()
						end
					end,
					{self.fxId}
				)					
			end
		end
	fxTimer:activate()
	
	return fxId
end

function playHitFx(self, sound)
	if self.name == "ice_shards" then
		return false
	end
	local level, x, y = self:getPosition()
	if self._preHit then
		local dx, dy = getForward(self.facing)
		x = x - dx
		y = y - dy
	end
	
	-- Play hit sound if sound is true
	if sound == nil then 
		sound = true 
	end
	if sound then
		playSoundAt(self._hitSound, level, x, y)
	end
	
	-- Spawn FX
	local red, green, blue = unpack(self._lightColor)
	spawn("fx", level, x, y, 0, exsp.randomId("hitFx"))
		:setParticleSystem(self._hitParticleEffect)
		:setLight(red, green, blue, self._lightHitBrightness, self._lightHitRange, 0.5, self._castShadow)
		:translate(0,1.35,0)
end

function defineFx(self, name, properties)
	if not(self.fxDefs[name]) then 
		self.fxDefs[name] = {} 
	else
		return false
	end
	
	-- populate Table
	for k,v in pairs(properties) do
		self.fxDefs[name][k] = v
	end
	
	if debugDefinitions then
		print("FX defined: "..name)
	end
end

function playFx(self, name, level, x, y, facing, properties)

	-- retreive fx definition
	local fx = {}
	for k, v in pairs(self.fxDefs[name]) do
		fx[k] = v
	end
	if properties then
		for k, v in pairs(properties) do
			fx[k] = v
		end
	end
	local red, green, blue = unpack(fx.color)
		
	local particleSystem
	local tx, ty, tz 
	if not(facing) then
		particleSystem = fx.particleSystem
		tx, ty, tz = unpack(fx.translation)
	else
		if type(fx.particleSystem) == "table" then
			particleSystem = fx.particleSystem[facing+1]
		else
			particleSystem = fx.particleSystem
		end
		if #fx.translation > 3 then
			tx, ty, tz = unpack(fx.translation[facing+1])
		else
			tx, ty, tz = unpack(fx.translation)
		end
	end
	
	-- spawn fx
	fxId = exsp.randomId("playFx")
	spawn("fx", level, x, y, 0, fxId)
		:setParticleSystem(particleSystem)
		:setLight(red, green, blue, fx.brightness, fx.range, fx.time, fx.castShadow)
		:translate(tx, ty, tz)
	
	return fxId
end

-- ****************************
-- HOOKS FUNCTIONS
-- ****************************

function onCastHook(self)
	if debugHooks then
		print("Hook: onCast ("..self.name..","..self.id..")")
	end
	local caster
	if self.spawner == "party" then
		caster = grimq.getChampionFromOrdinal(self._ordinal)
	else
		caster = findEntity(self.spawner)
	end
	if self._onCast then
		local hookReturn
		for _,hookFunction in ipairs(self._onCast) do
			hookReturn = hookFunction(self)
			if hookReturn ~= nil then	
				return hookReturn
			end
		end
	end
end

function onPassHook(self)
	if debugHooks then
		print("Hook: onPass ("..self.id..")")
	end
	if self._onPass then
		local hookReturn
		for _,hookFunction in ipairs(self._onPass) do
			hookReturn = hookFunction(self)
			if hookReturn ~= nil then
				return hookReturn
			end
		end
	end
end

function onHitHook(self, hitType, subType, hitId, source)

	if hitType == "monster" and not(hitId) then
		return false
	end
	
	-- Set onHit
	self._onHitCalled = true
	
	-- Retrieve position
	local level, x, y = self:getPosition()
	local facing = self.facing
	local dx, dy = getForward(facing)
	
	-- Adjust position and distance if spell is Ice Shards
	if grimq.strstarts(source, "iceShards") then
		local iceShardsDistance = string.sub(source, -1, -1)
		x = x + dx * iceShardsDistance
		y = y + dy * iceShardsDistance
		self.distance = iceShardsDistance + 1
	end
	
	-- Adjust position if hit detected before spawn
	if source == "exspCorePreHit" then
		x = x-dx
		y = y-dy
	end
	
	-- Adjust position if an object was hit
	if hitType == "object" then
		x = x+dx
		y = y+dy
	end
	
	-- Debug code
	if debugHooks then
		local debugStr1 = self.id..", "..level..", "..x..", "..y..", "..exsp.stringOrNil(hitType)..", "..exsp.stringOrNil(subType)..", "
		local debugStr2
		if type(hitId) == "table" then
			debugStr2 = exsp.stringOrNil(hitId[1])..", "..exsp.stringOrNil(hitId[2])..", "..exsp.stringOrNil(hitId[3])..", "..exsp.stringOrNil(hitId[4])..")"
		else
			debugStr2 = exsp.stringOrNil(hitId)..")"
		end
		print("Hook: onHit ("..debugStr1..debugStr2)
	end
		
	-- Clean onDamage filters
	local dh = exsp.damageHandler
	if hitType == "monster" then
		for _,v in ipairs(hitId) do
			dh.onDamageFilter[v] = nil
		end
	elseif hitType == "party" then
		dh.onDamageFilter["party"] = nil
		dh.monsterReplaceAttack = false
	end
	
	-- Convert ids to entities
	local entity1, entity2, entity3, entity4
	if type(hitId) == "table" then
		entity1 = extend:entity(findEntity(exsp.stringOrNil(hitId[1])))
		entity2 = extend:entity(findEntity(exsp.stringOrNil(hitId[2])))
		entity3 = extend:entity(findEntity(exsp.stringOrNil(hitId[3])))
		entity4 = extend:entity(findEntity(exsp.stringOrNil(hitId[4])))
	else
		entity1 = extend:entity(findEntity(exsp.stringOrNil(hitId)))
	end
	
	-- Piercing spells code
	if self._piercing and (self._maxDistance == nil or (self.distance + 1) <= self._maxDistance) then
		if hitType == "monster" or hitType == "party" then
			-- Call exspCore with a delay and call launch animation
			local fxId = self:playLaunchFx()	
			exsp.delay(1/self._projectileSpeed*3+0.1,
				function(self, fxId, spell, level, x, y)
					if findEntity(fxId) then
						findEntity(fxId):destroy()
					end
					local newSpell = exsp:createSpellObject(spell.name, level, x, y, spell.facing)
					newSpell:addProperties(spell)
					spell:destroySpellObject()
					newSpell._type = "respawned"
					newSpell._spawnAhead = true
					newSpell.distance = newSpell.distance + 1
					newSpell:exspCore()
				end,
				{fxId, self, level, x, y}
			)
		end
	end
	
	-- Hooks execution
	local hookReturn
	if self._onHit then
		for _,hookFunction in ipairs(self._onHit) do
			hookReturn = hookFunction(self, level, x, y, hitType, subType, entity1, entity2, entity3, entity4)
			if hookReturn ~= nil then
				if hookReturn and (hitType == "monster" or hitType == "party") then
					self:damage(level, x, y)
				end
				return hookReturn
			end
		end
	end
	
	if hitType == "monster" and self._onMonsterHit then
		for _,hookFunction in ipairs(self._onMonsterHit) do
			hookReturn = hookFunction(self, entity1, entity2, entity3, entity4)
			if hookReturn ~= nil then
				if hookReturn then
					self:damage(level, x, y)
				end
				return hookReturn
			end
		end
	end
	
	if hitType == "party" and self._onPartyHit then
		for _,hookFunction in ipairs(self._onPartyHit) do
			hookReturn = hookFunction(self)
			if hookReturn ~= nil then
				if hookReturn then
					self:damage(level, x, y)
				end
				return hookReturn
			end
		end
	end
	
	if hitType == "door" and self._onDoorHit then
		for _,hookFunction in ipairs(self._onDoorHit) do
			hookReturn = hookFunction(self, entity)
			if hookReturn ~= nil then
				return hookReturn
			end
		end
	end	
	
	-- Damage dealing phase, if no hooks returned any value
	if hitType == "monster" or hitType == "party" then
		self:damage(level, x, y)
	end
end

-- ****************************
-- SPELL OBJECT FUNCTIONS
-- ****************************

function createSpellObject(self, name, level, x, y, facing, id)
	name = name or "spell"
	id = id or self.randomSdId(name)
	self.sd[id] = {}
	local spell = self.sd[id]
	spell.name = name
	spell.id = id
	spell.level = level
	spell.x = x
	spell.y = y
	spell.facing = facing
	exsp.addMethods(spell)
	exsp.addDefinitions(spell)
	return spell
end

function destroySpellObject(self)
	exsp.delay(5,
		function(self, spell)
			if spell and not(spell._stopClean) then
				spell = nil
			end
		end,
		{self}
	)		
end

function addMethods(spell)
	local methods = {
		destroy = exsp._destroy,
		explode = exsp._explode,
		damage = exsp._damage,
		changeDirection = exsp._changeDirection,
		residualEffect = exsp._residualEffect,
		cancelResidualEffect = exsp._cancelResidualEffect,
		destroySpellObject = exsp.destroySpellObject,
		getPosition = exsp.getPosition,
		getCollisionAhead = exsp.getCollisionAhead,
		getCollisionOnTile = exsp.getCollisionOnTile,
		addProperties = exsp.addProperties,
		addCasterSkills = exsp.addCasterSkills,
		launchModule = exsp.launchModule,
		spawnSpellEntity = exsp.spawnSpellEntity,
		exspCore = exsp.exspCore,
		onCastHook = exsp.onCastHook,
		onPassHook = exsp.onPassHook,
		onHitHook = exsp.onHitHook,
		playLaunchFx = exsp.playLaunchFx,
		playSpellProjectileFx = exsp.playSpellProjectileFx,
		playHitFx = exsp.playHitFx,
		isOnSpinner = exsp.isOnSpinner,
		activateSpinner = exsp.activateSpinner,
		getFlags = exsp.getFlags,
	}
	
	for k, v in pairs(methods) do
		spell[k] = v
	end
end

function addDefinitions(spell)
	for k, v in pairs(exsp.spellDefs[spell.name]) do
		if spell["_"..k] == nil then
			spell["_"..k] = v
		end
	end
end

function addProperties(self, properties)
	local doNotAdd = {"_spawnAhead", "_onHitCalled", "_hookTimerCounter1", "_hookTimerCounter2", "_destroyed", "_onHitCalled", "_stopTracking", "_stopClean"}
	if properties then
		for k,v in pairs(properties) do
			if self[k] == nil and not(tableHasValue(doNotAdd, k)) then
				self[k] = v
			end
		end
	end
end

function addCasterSkills(self, caster)
	self.caster = {}
	self.caster.fire_magic = caster:getSkillLevel("fire_magic")
	self.caster.air_magic = caster:getSkillLevel("air_magic")
	self.caster.earth_magic = caster:getSkillLevel("earth_magic")
	self.caster.ice_magic = caster:getSkillLevel("ice_magic")
	self.caster.spellcraft = caster:getSkillLevel("spellcraft")
	self.caster.staves = caster:getSkillLevel("staves")
end

function spawnSpellEntity(self)
	if self.power then
		spawn(self._spawnObject, self.level, self.x, self.y, self.facing, self.id):setAttackPower(self.power)
	else
		spawn(self._spawnObject, self.level, self.x, self.y, self.facing, self.id)
	end
end

function getPosition(self)
	if not(findEntity(self.id)) then
		if not(self) then
			return nil, nil, nil
		else
			return self.level, self.x, self.y
		end
	else
		return findEntity(self.id).level, findEntity(self.id).x, findEntity(self.id).y
	end
end

function getFlags(self)
	local flag = 0
	if self._damageType == "physical" then 
		flag = 1
	end
	if self._ordinal then
		return (2 ^ (self._ordinal+1))+flag
	else
		return flag
	end
end

function getCollisionOnTile(self)
	
	level, x, y = self:getPosition()
	if not(level) then
		return nil, nil
	end

	local monsters = {}
	
	-- Check for entities on current tile
	for i in entitiesAt(level, x, y) do
		if i.class == "Monster" then
			table.insert(monsters, i)
		end
		if self.distance > 0 and i.class == "Party" then
			return "party", i
		end
	end

	if #monsters > 0 then
		return "monster", monsters
	else
		return nil, nil
	end
end

function getCollisionAhead(self, level, x, y, facing)
	
	if self.id ~= "exsp" then
		if not(self) then
			return nil, nil, nil
		end
		facing = level or self.facing
		level, x, y = self:getPosition()
	end
	if not(level) then
		return nil, nil, nil
	end

	local dx, dy = getForward(facing)
	local monsters = {}
	
	-- Check for entities on current tile
	for i in entitiesAt(level, x, y) do
		if grimq.isDoor(i) and i:isClosed() and i.facing == facing then
			return "door", nil, i
		end
		if (i.class == "Alcove" or i.class == "Button" or i.class == "Decoration" 
			or i.class == "Lever" or i.class == "Lock" or i.class == "Receptor" 
			or i.class == "TorchHolder" or i.class == "WallText") and i.facing == facing and isWall(level, x+dx, y+dy) then
			return "wall", i.class, i
		end
	end
	
	-- Check for entities on next tile
	for i in entitiesAt(level, x+dx, y+dy) do
		if grimq.isDoor(i) and i:isClosed() and (i.facing+2)%4 == facing then
			return "door", nil, i
		end
		if i.class == "Monster" then
			table.insert(monsters, i)
		end
		if i.class == "Party" then
			return "party", nil, i
		end
		if i.class == "Blockage" or i.class == "Crystal" then
			return "object", i.class, i
		end
	end

	if isWall(level, x+dx, y+dy) then
		return "wall", nil, nil
	end
	if #monsters > 0 then
		return "monster", nil, monsters
	else
		return nil, nil, nil
	end
end

-- ****************************
-- SPELL METHODS
-- ****************************

function _destroy(self)
	if findEntity(self.id) then
		findEntity(self.id):destroy()
	end
	self._destroyed = true
	if debugSpells then
		print("Spell destroyed: "..self.id)
	end
end

function _explode(self, sound)
	if findEntity(self.id) then
		findEntity(self.id):destroy()
	end
	self:damage(level, x, y)
	self:playHitFx(sound)
	if debugSpells then
		print("Spell exploded: "..self.id)
	end
end

function _damage(self, level, x, y, power)
	if level == nil then
		level, x, y = self:getPosition()
	end

	local flags = self:getFlags()

	power = power or self.power or self._attackPower
	
	if self._damageType ~= "none" then
		damageTile(level, x, y, 0, flags, self._damageType, power)
	end
	
	if debugSpells then
		if self._ordinal then
			local champion = grimq.getChampionFromOrdinal(self._ordinal)
			print("Tile "..level..", "..x..", "..y.." damaged by "..champion:getName())
		else
			print("Tile "..level..", "..x..", "..y.." damaged")
		end
	end
	
end

function _changeDirection(self, facing)
	--if facing ~= self.facing then
		local level, x, y = self:getPosition()
		self:destroy()
		local newSpell = exsp:createSpellObject(self.name, level, x, y, facing)
		newSpell:addProperties(self)
		self:destroySpellObject()
		newSpell._spinned = true
		newSpell:exspCore()
	--end
end

function _residualEffect(self, delay, repetitions, funct, args)
	self._stopClean = true
	
	local delayId = exsp.randomTimerId("residualEffect")
	local delayTimer = timers:create(delayId)
	delayTimer:setTimerInterval(delay)
	delayTimer:addCallback(funct,args)
	delayTimer:setTickLimit(repetitions,true)
	delayTimer:activate()
	delayTimer.spell = self
	delayTimer.onDeactivate = function(self)
			self.spell:cancelResidualEffect(self.id)
		end
	if not(self._residualEffects) then self._residualEffects = {} end
	self._residualEffects[delayId] = true
	return delayId
end

function _cancelResidualEffect(self, delayId)
	local delayTimer = timers:find(delayId)
	--delayTimer:destroy()
	if self._residualEffects[delayId] then	
		self._residualEffects[delayId] = nil
	end
	if exsp.tableIsEmpty(self._residualEffects) then
		self._stopClean = nil
		self:destroySpellObject()
	end
end

-- ****************************
-- DEFINITION FUNCTIONS
-- ****************************

function defineSpell(self, name, properties)
	if not(self.spellDefs[name]) then 
		self.spellDefs[name] = {} 
	else
		print("Spell "..name.." is already defined!")
		return false
	end
	local definitions = self.spellDefs[name]
	-- populate Table
	for k,v in pairs(properties) do
		if tableHasValue(self.hookNames, k) then
			if not(definitions[k]) then
				definitions[k] = {}
			end
			table.insert(definitions[k], v)
		else
			definitions[k] = v
		end
	end
	if exsp.debugDefinitions then
		print("Spell defined: "..name)
	end
end

function cloneSpell(self, name, properties)
	local baseProperties = self.spellDefs[properties.baseSpell]
	properties.baseSpell = nil
	self.spellDefs[name] = self.spellDefs[name] or {} 
	local definitions = self.spellDefs[name]
	
	-- populate Table
	for k,v in pairs(baseProperties) do
		if not(properties[k]) then
			properties[k] = v
		end
	end

	-- clone hooks
	for k,v in pairs(properties) do
		if tableHasValue(exsp.hookNames, k) then
			if not(definitions[k]) then
				definitions[k] = {}
			end
			table.insert(definitions[k], v)
		else
			definitions[k] = v
		end
	end	
	
	if exsp.debugDefinitions then
		print("Spell cloned: "..name.." from "..properties.baseSpell)
	end	
end

function addSpellHooks(self, name, hooks)
	if name == "allSpells" then
		exsp.delay(0.5,
			function(self, hooks)
				for k,_ in pairs(exsp.spellDefs) do
					exsp:addSpellHooks(k, hooks)
				end
			end,
			{hooks}
		)
		return false
	end
	local definitions = self.spellDefs[name]
	if not(definitions) then 
		print("addSpellHooks: Spell "..name.." is not defined.")
		return false
	end
	for k, v in pairs(hooks) do
		definitions[k] = definitions[k] or {}
		table.insert(definitions[k], v)
		if exsp.debugDefinitions then
			print("Hook "..k.." added to "..name)
		end
	end
end

function defineRangedAttack(self, name, attackPower, attackPowerIncrement, rangedAttack)
	if not(self.monsterDefs[name]) then
		self.monsterDefs[name] = {}
		local definitions = self.monsterDefs[name]
		definitions.rangedAttack = {}
		if type(rangedAttack) == "table" then
			definitions.rangedAttack = rangedAttack
		else
			definitions.rangedAttack = {100, rangedAttack}
		end
		definitions.attackPower = attackPower
		definitions.attackPowerIncrement = attackPowerIncrement
		
		fw.addHooks(name, "exsp_monsters", {
			onRangedAttack = function(self)
				local mLevel = self:getLevel()
				local name = self.name
				local definitions = exsp.monsterDefs[name]
				
				-- unpack rangedAttack table
				local chance = {0}
				local name = {}
				for i = 1,#definitions.rangedAttack-1,2 do
					if i > 1 then
						table.insert(chance, definitions.rangedAttack[i]+chance[(i+1)/2])
					else
						table.insert(chance, definitions.rangedAttack[i])
					end
					table.insert(name, definitions.rangedAttack[i+1])
				end
				local attackPower = definitions.attackPower
				local attackPowerIncrement = definitions.attackPowerIncrement
				
				-- cast spells
				local num = math.random()*100
				for i = 2, #chance do
					if num >= chance[i-1] and num < chance[i] then
						exsp:spellSpawn(name[i-1], self.id, self.facing, {power = attackPower+(mLevel-1)*attackPowerIncrement})
					end
				end
				
				return false
			end
			}
		)
		if exsp.debugDefinitions then
			print("Monster ranged attack defined: "..name)
		end
	else
		print("Monster "..name.." is already defined!")
		return false	
	end
end

function defineAttack(self, name, attackPower, attackPowerIncrement, frontAttack, sideAttack, replaceAttack)
	if not(self.monsterDefs[name]) then
		self.monsterDefs[name] = {}
		local definitions = self.monsterDefs[name]
		definitions.attack = {}
		if type(frontAttack) == "table" then
			definitions.frontAttack = frontAttack
		else
			definitions.frontAttack = {100, frontAttack}
		end
		if type(sideAttack) == "table" then
			definitions.sideAttack = sideAttack
		else
			definitions.sideAttack = {100, sideAttack}
		end
		definitions.attackPower = attackPower
		definitions.attackPowerIncrement = attackPowerIncrement
		definitions.replaceAttack = replaceAttack
		
		fw.addHooks(name, "exsp_monsters", {
			onAttack = function(self, attackType)
				local mLevel = self:getLevel()
				local name = self.name
				local definitions = exsp.monsterDefs[name]
				
				if attackType == "attack" then
					-- unpack frontAttack table
					local chance = {0}
					local name = {}
					for i = 1,#definitions.frontAttack-1,2 do
						if i > 1 then
							table.insert(chance, definitions.frontAttack[i]+chance[(i+1)/2])
						else
							table.insert(chance, definitions.frontAttack[i])
						end
						table.insert(name, definitions.frontAttack[i+1])
					end
					local attackPower = definitions.attackPower
					local attackPowerIncrement = definitions.attackPowerIncrement
					
					-- cast spells
					local num = math.random()*100
					for i = 2, #chance do
						if num >= chance[i-1] and num < chance[i] then
							exsp:spellSpawn(name[i-1], self.id, self.facing, {power = attackPower+(mLevel-1)*attackPowerIncrement})
						end
					end
				else
					-- unpack sideAttack table
					local chance = {0}
					local name = {}
					for i = 1,#definitions.sideAttack-1,2 do
						if i > 1 then
							table.insert(chance, definitions.sideAttack[i]+chance[(i+1)/2])
						else
							table.insert(chance, definitions.sideAttack[i])
						end
						table.insert(name, definitions.sideAttack[i+1])
					end
					local attackPower = definitions.attackPower
					local attackPowerIncrement = definitions.attackPowerIncrement
					
					local facingTurn = 0
					if attackType == "turnAttackRight" then
						facingTurn = 1
					else
						facingTurn = -1
					end
					
					-- cast spells
					local num = math.random()*100
					for i = 2, #chance do
						if num >= chance[i-1] and num < chance[i] then
							exsp:spellSpawn(name[i-1], self.id, (self.facing+facingTurn)%4, {power = attackPower+(mLevel-1)*attackPowerIncrement})
						end
					end
				end
				
				if definitions.replaceAttack then
					local dh = exsp.damageHandler
					dh.monsterReplaceAttack = true
				end

			end
			}
		)
		if debugDefinitions then
			print("Monster attack defined: "..name)
		end
	else
		print("Monster "..name.." is already defined!")
		return false	
	end
end

function defineDefaultMonsters()
	exsp:defineRangedAttack("goromorg", 40, 0, { 45, "lightning_bolt_greater", 25, "ice_shards", 20, "fireball_greater", 10, "poison_bolt" })
	exsp:defineRangedAttack("wyvern", 23, 5, "lightning_bolt")
	exsp:defineRangedAttack("herder_small", 10, 5, "poison_bolt")
	exsp:defineRangedAttack("uggardian", 30, 5, "fireball")
end

-- ****************************
-- HELPER FUNCTIONS
-- ****************************

function allSpellsAt(level, x, y)
	local pSpells = grimq.fromIterator(entitiesAt(level, x, y))
				:where(function(v) return (v.class == "ProjectileSpell"); end)
				:toIterator()
	return pSpells
end

function findSpell(level, x, y)
	for i in exsp.allSpellsAt(level, x, y) do
		if not(exsp.sd[i.id]) then
			return i
		end
	end
	return nil
end

function areaOfEffect(x, y, shape, r, area, facing)
	local rTable = {}
	if area == nil then
		area = true
	end
	facing = facing or 0

	if shape == "square" then
		for ix = x-r, x+r do
			for iy = y-r, y+r do
				if ix >= 0 and ix < 32 and iy >= 0 and iy < 32 then
					if not(area) and (ix < x-r+1 or ix > x+r-1 or iy < y-r+1 or iy > y+r-1) then
						table.insert(rTable, {x = ix, y = iy})
					elseif area then
						table.insert(rTable, {x = ix, y = iy})
					end
				end	
			end
		end
	end
	if shape == "cross" then
		for ix = x-r, x+r do
			for iy = y-r, y+r do
				if ix >= 0 and ix < 32 and iy >= 0 and iy < 32 then
					if (ix == x and iy ~= y) or (ix ~= x and iy == y) then
						if not(area) and (ix < x-r+1 or ix > x+r-1 or iy < y-r+1 or iy > y+r-1) then
							table.insert(rTable, {x = ix, y = iy})
						elseif area then
							table.insert(rTable, {x = ix, y = iy})
						end
					end
				end	
			end
		end
	end	
	if shape == "diagonal" then
		for ix = x-r, x+r do
			for iy = y-r, y+r do
				if ix >= 0 and ix < 32 and iy >= 0 and iy < 32 then
					if x-ix == y-iy or x-ix == -(y-iy) then
						if not(area) and (ix < x-r+1 or ix > x+r-1 or iy < y-r+1 or iy > y+r-1) then
							table.insert(rTable, {x = ix, y = iy})
						elseif area then
							table.insert(rTable, {x = ix, y = iy})
						end
					end
				end	
			end
		end
	end
	if shape == "diamond" then
		for ix = x-r, x+r do
			for iy = y-r, y+r do
				if ix >= 0 and ix < 32 and iy >= 0 and iy < 32 then
					if math.abs(x-ix)+math.abs(y-iy) <= r then
						if not(area) and math.abs(x-ix)+math.abs(y-iy) > r-1 then
							table.insert(rTable, {x = ix, y = iy})
						elseif area then
							table.insert(rTable, {x = ix, y = iy})
						end
					end
				end	
			end
		end
	end	
	if shape == "cone" then
		dx, dy = getForward(facing)
		for il = 1, r do
			for iw = -il+1, il-1 do
				local ix = x + il*dx + iw*dy
				local iy = y + il*dy + iw*dx
				if ix >= 0 and ix < 32 and iy >= 0 and iy < 32 then
					if not(area) and (iw == -il+1 or iw == il-1) then
						table.insert(rTable, {x = ix, y = iy})
					elseif area then
						table.insert(rTable, {x = ix, y = iy})
					end
				end
			end
		end
	end	
	if shape == "cone_narrow" then
		dx, dy = getForward(facing)
		for il = 1, r do
			for iw = math.ceil((-il+1)/2), math.floor((il-1)/2) do
				local ix = x + il*dx + iw*dy
				local iy = y + il*dy + iw*dx
				if ix >= 0 and ix < 32 and iy >= 0 and iy < 32 then
					if not(area) and (iw == -il+1 or iw == il-1) then
						table.insert(rTable, {x = ix, y = iy})
					elseif area then
						table.insert(rTable, {x = ix, y = iy})
					end
				end
			end
		end
	end
	if shape == "cone_wide" then
		dx, dy = getForward(facing)
		for il = 1, r do
			for iw = -il, il do
				local ix = x + il*dx + iw*dy
				local iy = y + il*dy + iw*dx
				if ix >= 0 and ix < 32 and iy >= 0 and iy < 32 then
					if not(area) and (iw == -il+1 or iw == il-1) then
						table.insert(rTable, {x = ix, y = iy})
					elseif area then
						table.insert(rTable, {x = ix, y = iy})
					end
				end
			end
		end
	end	
	rTable = grimq.fromArray(rTable)
		:where(function (v) return not(v.x == x and v.y == y); end)
		:toIterator()
	return rTable
end

function tableHasValue(t,searchvalue)
	--code by JKos, copied over from the framework help.lua to be available at init time.
	for _,v in ipairs(t) do
	  if v == searchvalue then
		return true
	  end
	end
	return false
end

function autoCtr()
	exsp.exspCtr = (exsp.exspCtr + 1) % exsp.exspCtrLimit
	return exsp.exspCtr
end

function delay(delay, funct, args)
	local delayId = exsp.randomTimerId("delay")
	local delayTimer = timers:create(delayId)
	delayTimer:setTimerInterval(delay)
	delayTimer:addCallback(funct,args)
	delayTimer:setTickLimit(1,true)
	delayTimer:activate()
	return delayId
end

function cancelDelay(delayId)
	local delayTimer = timers:find(delayId)
	delayTimer:deactivate()
	delayTimer:destroy()
end

function stringOrNil(str)
	if str == nil then
		return "nil"
	else
		return str
	end
end

function randomId(prefix)
	local numId = math.random(10000,99999)
	while findEntity(prefix.."."..numId) do
		numId = math.random(10000,99999)
	end
	return prefix.."."..numId
end

function randomTimerId(prefix)
	local numId = math.random(10000,99999)
	while timers:find(prefix.."."..numId) do
		numId = math.random(10000,99999)
	end
	return prefix.."."..numId
end

function randomSdId(prefix)
	local numId = math.random(10000,99999)
	while exsp.sd[prefix.."."..numId] do
		numId = math.random(10000,99999)
	end
	return prefix.."."..numId
end

function getMonsterGroup(level, x, y)
   local monstersTable = {}
   for i in entitiesAt(level,x,y) do
	  if i.class == "Monster" then
		 table.insert(monstersTable, i)
	  end   
   end
   return monstersTable
end

function entitiesToIds(t)
	local rt = {}
	for _,v in ipairs(t) do
		table.insert(rt, v.id)
	end
	return rt
end

function idsToEntities(t)
	local rt = {}
	for _,v in ipairs(t) do
		table.insert(rt, findEntity(v))
	end
	return rt
end

function tableIsEmpty(self)
	for _, _ in pairs(self) do
		return false
	end
	return true
end

-- ****************************
-- PROXY FUNCTIONS
-- ****************************

function setPartyMove(value)
	partyMove = value
end

-- ****************************
-- DETECTOR
-- ****************************

function startDetector()
	levels = getMaxLevels()
	for i = 1, levels do
		spawn("timer", i, 0, 0, 0, "exspTimer_"..i)
			:setTimerInterval(0.05)
			:addConnector("activate", "exsp", "exspDetector")
			:activate()
	end
end

function exspDetector(sourceTimer)
	if sourceTimer.level == party.level then
		-- Spell Detector
		for i in allEntities(party.level) do
			if (i.class == "ProjectileSpell" or i.class == "Blob") and not(exsp.sd[i.id]) and exsp.spellDefs[i.name] then
				local level, x, y, facing = i.level, i.x, i.y, i.facing
				if not(x == party.x and y == party.y) then
					local spell = exsp:createSpellObject(i.name, level, x, y, facing, i.id)
					for i in entitiesAt(level, x, y) do
						if i.class == "Spawner" then
							spell.spawner = i.id
						end
					end
					if spell.name ~= "blob" then
						playSoundAt(spell._launchSound, level, x, y)
					end
					spell._type = "detected"
					spell:exspCore()
				end
			end
		end
	end
end

-- ****************************
-- INITIALIZATION
-- ****************************

autohook = 
{
	party = 
	{
		onCastSpell = function(caster, name)
			if help.tableHasValue(exsp.defaultSpells, name) then
				if not(exsp.spellDefs[name].burst) and name ~= "ice_shards" then
					playSound(exsp.spellDefs[name].launchSound)
				end
				return exsp:spellDetect(name, caster)
			end
		end,
		
		onDamage = function(champion, damage, damageType)
			local dh = exsp.damageHandler
			if dh.onDamageFilter["party"] ~= nil or dh.monsterReplaceAttack then
				if dh.onDamageFilter["party"] == nil then
					return false
				end
				local id = dh.onDamageFilter["party"]
				local spell = exsp.sd[id]
				if spell ~= nil and spell.name ~= "ice_shards" then
					local champions = {}
					for i=1,4 do
						if party:getChampion(i):isAlive() then
							champions[i] = party:getChampion(i)
						end
					end
					if champion:getOrdinal() == #champions then
						if dh.monsterReplaceAttack then
							exsp.delay(0.08,
								function(self, spell)
									spell:onHitHook("party", nil, party, "party")
								end,
								{spell}
							)
						else
							spell:onHitHook("party", nil, party, "party")
						end
					end
				end
				return false
			end	
		end,
		
		onMove = function(self, dir)
			exsp.setPartyMove(dir)
			exsp.delay(0.6,
				function()
					exsp.setPartyMove(nil)
				end,
				{}
			)
		end
	},
	
	monsters = 
	{
		onDamage = function(self, damage, damageType)
			local dh = exsp.damageHandler
			if dh.onDamageFilter[self.id] then
				if dh.onDamageFilter[self.id] ~= "freezeMonster" then
					local id = dh.onDamageFilter[self.id]
					local spell = exsp.sd[id]
					if spell.name ~= "ice_shards" then
						dh.monsterGroupCtr[spell.id] = dh.monsterGroupCtr[spell.id] + 1
						if dh.monsterGroupCtr[spell.id] == dh.monsterGroup[spell.id] then
							spell:onHitHook("monster", nil, dh.monsterGroupTable[spell.id], "monster")
						end
					end
				end
				return false
			elseif extend:entity(self):isInvulnerable() then
				return false
			end
		end,
	}
}

function autoexec()
	defineDefaultMonsters()
	startDetector()
end
]])