fw_addModule("exsp_monsters",[[
-- ****************************
-- MONSTER METHODS
-- ****************************

function registerExspMethods()
	methods = {
		hold = exsp_monsters._hold,
		unhold = exsp_monsters._unhold,
		isHeld = exsp_monsters._isHeld,
		onUnhold = exsp_monsters._onUnhold,
		freeze = exsp_monsters._freeze,
		unfreeze = exsp_monsters._unfreeze,
		isFrozen = exsp_monsters._isFrozen,
		onUnfreeze = exsp_monsters._onUnfreeze,
		makeInvulnerable = exsp_monsters._makeInvulnerable,
		unmakeInvulnerable = exsp_monsters._unmakeInvulnerable,
		isInvulnerable = exsp_monsters._isInvulnerable,
		onUnmakeInvulnerable = exsp_monsters._onUmakeInvulnerable,
		move = exsp_monsters._move,
		addMonsterHooks = exsp_monsters.addMonsterHooks,
		executeMonsterHooks = exsp_monsters.executeMonsterHooks,
	}
	extend:registerMethods("Monster", methods)
end

function _hold(self, duration)
	
	if not(self) or (duration and duration < 1) then
		return false
	end
	
	-- Set hold monster variable, incrementing values if function is called on the same monster while held
	if self.held == nil then
		self.held = 1
	else
		self.held = self.held + 1
	end
	
	if duration then
		-- Call unHolding function ina duration
		exsp.delay(duration,
			function(self, monster, originalValue)
				if monster and monster.held == originalValue then
					monster:unhold()
				end
			end,
			{self, self.held}
		)
	end
end

function _unhold(self)
	if self then	
		self.held = nil
		self:executeMonsterHooks("onUnhold")
	end
end

function _isHeld(self)
	if self and self.held then 
		return true 
	else
		return false
	end
end

function _onUnhold(self, funct)
	self:addMonsterHooks({onUnhold = funct})
end

function _freeze(self, duration)
	if not(self) or duration < 1 then
		return false
	end
	
	duration = math.ceil(duration)
	if duration > 60 then
		duration = 60
	end

	local freezeIds = {}
	for i = 1, 4 do
		freezeIds[i] = exsp.randomId("freezeMonster")
		spawn("exsp_freezeHelper_"..duration, self.level, self.x, self.y, (self.facing+i)%4, freezeIds[i])
	end

	local monsters = exsp.getMonsterGroup(self.level, self.x, self.y)
	
	for i,monster in ipairs(monsters) do
		monster = extend:entity(monster)
		local dh = exsp.damageHandler
		dh.onDamageFilter[monster.id] = "freezeMonster"
		monster.frozen = true
		exsp.delay(duration+0.3,
			function(self, monster)
				if monster then
					monster:unfreeze()
				end
			end,
			{monster}
		)
	end
	
	exsp.delay(0.2,
		function(self, freezeIds, monsters)
			for i = 1, 4 do
				if findEntity(freezeIds[i]) then
					findEntity(freezeIds[i]):destroy()
				end
			end
			for _,monster in ipairs(monsters) do
				local dh = exsp.damageHandler
				if monster then
					dh.onDamageFilter[monster.id] = nil
				end
			end
		end,
		{freezeIds, monsters}
	)
end

function _unfreeze(self)
	if self then	
		self.frozen = nil
		self:executeMonsterHooks("onUnfreeze")
	end
end

function _isFrozen(self)
	if not(self) or not(self.frozen) then 
		return false 
	else
		return true
	end
end

function _onUnfreeze(self, funct)
	self:addMonsterHooks({onUnfreeze = funct})
end

function _makeInvulnerable(self)
		
	if not(self) or (duration and duration < 1) then
		return false
	end
	
	-- Set hold monster variable, incrementing values if function is called on the same monster while held
	if self.invulnerable == nil then
		self.invulnerable = 1
	else
		self.invulnerable = self.invulnerable + 1
	end
	
	if duration then
		-- Call unHolding function in holdTime
		exsp.delay(duration,
			function(self, monster, originalValue)
				if monster and monster.invulnerable == originalValue then
					self:unmakeInvulnerable()
				end
			end,
			{self, self.invulnerable}
		)
	end
end

function _unmakeInvulnerable(self)
	if self then
		self.invulnerable = nil
		self:executeMonsterHooks("onUnmakeInvulnerable")
	end
end

function _isInvulnerable(self)
	if not(self) or not(self.invulnerable) then 
		return false 
	else
		return true
	end
end

function _onUnmakeInvulnerable(self, funct)
	self:addMonsterHooks({onUnmakeInvulnerable = funct})
end

function _move(self, level, x, y, facing)
	local teleporterId = exsp.randomId("moveMonster")
	spawn("teleporter", self.level, self.x, self.y, self.facing, teleporterId)
		:setTeleportTarget(x, y, facing, level)
		:setTriggeredByParty(false)
		:setTriggeredByMonster(true)
		:setTriggeredByItem(false)
		:setChangeFacing(true)
		:setInvisible(true)
		:setSilent(true)
		:setHideLight(true)
		:setScreenFlash(false)
	exsp.delay(0.1,
		function(self, teleporterId)
			if findEntity(teleporterId) ~= nil then
				findEntity(teleporterId):destroy()
			end
		end,
		{teleporterId}
	)
end

function addMonsterHooks(self, hooks)
	self.monsterHooks = self.monsterHooks or {}
	for k, v in pairs(hooks) do
		self.monsterHooks[k] = self.monsterHooks[k] or {}
		table.insert(self.monsterHooks[k], v)
		if exsp.debugDefinitions then
			print("Monster hook "..k.." added to "..self.id)
		end
	end
end

function executeMonsterHooks(self, hook)
	if exsp.debugHooks then
		print("Hook: "..hook.." ("..self.id..")")
	end
	if not(self.monsterHooks) then
		return false
	end
	if self.monsterHooks[hook] then
		for _,hookFunction in ipairs(self.monsterHooks[hook]) do
			hookFunction(self)
		end
	end
	self.monsterHooks[hook] = nil
end

function autoexec()
	registerExspMethods()
	fw.addHooks("monsters", "exsp", {
		onMove = function(monster)
			if extend:entity(monster):isHeld() then return false end
		end,
		onTurn = function(monster)
			if extend:entity(monster):isHeld() then return false end
		end,
		onAttack = function(monster)
			if extend:entity(monster):isHeld() then return false end
		end,
		},
		1
	)
end
]])