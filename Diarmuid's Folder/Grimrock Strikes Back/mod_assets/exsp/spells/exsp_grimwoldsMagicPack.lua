--[[ 
Spell Plugin for EXSP

Spells Name: Grimwold's Magic Pack
Spells Author: Grimwold (Additional FX and EXSP coding by Diarmuid)
Script Version: 1.0

Spell Readme:

To Use
======
Grimwold: New spells will automatically be available to wizards of the appropriate skill and level. Scrolls for each spell can be added through the editor. Anti-magic Zone objects can be placed using the editor. Add them to any space(s) in the dungeon and the party will be unable to cast spells if they stood in that space.
Diarmuid: You can select which spells to load by setting the variables below to true or false (all spells are loaded by default).

New Spells
==========

Combined Healing - Spellcraft level 16/24 based on caster's level will either heal champion with lowest percentage health or, above level 24, heal all champions.

Push Monster - Air magic level 5. Will cause a monster in front of the party to be teleported one space away if able.

Hold Monster - Earth magic level 5. A monster infront of the party is held and unable to move, turn or attack for a number of seconds based on the casters skill.

Burn Monster - Fire magic level 5. A monster infront of the party is burnt every 2 seconds, with duration and damage based on the caster's skill.

Freeze Monster - Ice magic level 5. A monster infront of the party is frozen. Duration is based on the caster's skill.

Fire Storm - Sample spell from Grimwold's Area of Effect System. Damages all tiles around the party.

Ice Cone - Sample spell from Grimwold's Area of Effect System. Damages monsters in a triangle of spaces in front of the party.

Lightning Storm - Sample spell from Grimwold's Area of Effect System. Damages monsters in a large square around the party.

Poison Burst - Sample spell from Grimwold's Area of Effect System. Damages monsters in the 3 spaces (orthogonally and diagonally) in front of the party.


Grimwold's Credits
==================
All scripts in this pack are written by myself. However there are a few people without whom this pack would not have been possible.

JKos - for explaining the damageTile() function in great detail.
Cromcrom and Akroma222 - for the initial idea of Area Effect spells.
Edsploration - for his idea of a teleport probe.


Diarmuid notes on EXSP adaptation:
==================================
- Healing:
	* Added description to spell scroll.
- Hold Monster:
	* Spell now works with monster groups, holding each individual monster.
	* You can now hold multiple monsters on different tiles independently with their own delays and effects.
	* Spell is now cast as a "BurstSpell" with light, sound & particle effect.
	* Added new sustained FX to Hold Monster to avoid abrupt disappearing/reappearing smoke.
	* Duration has been toned down a bit for balance(duration = skill instead of skill *2 ) and takes into account monster health: duration is reduced by 1s for each 100hp the monster has, stronger monsters will be less affected.
	* Added description to spell scroll.
- Push Monster:
	* Spell now uses exsp.getCollisionAhead to check for a free tile beyond the monster. It's more error-free than the probe (which could push a monster through a door, or trigger a pressure plate by mistake for example).
	* Spell is now cast as a "BurstSpell" with light, sound & particle effect.
	* Monster is now held for 0.2s after being pushed. to allow party to move in the square if desired.
	* If monster is held by Hold Monster spell, the hold FX gets pushed as well.
	* Added description to spell scroll.
- Burn Monster:
	* Spell now works properly with monster groups, as the "group" will continue to burn even if some of the monsters in it die.
	* Spell is now cast as a "BurstSpell" with light, sound & particle effect.
	* Spell power is properly modelled after skill (skill/2).
	* Added description to spell scroll.
- Freeze Monster:
	* Spell is now cast as a "BurstSpell" as Grimwold originally intended it, in line with the rest of the cycle.
	* Spell doesn't do any damage anymore, it just freezes.
	* Duration has been aligned with that of Hold Monster for balance (duration = skill) and takes into account monster health: duration is reduced by 1s for each 100hp the monster has, stronger monsters will be less affected.
	* Monster is now frozen at an exact (1s) duration according to skill, not in increments of 5s.
	* Added description to spell scro	ll.
- Fire Storm
	* Added light to visual effect.
	* Toned down damage for balance (now power = skill*3) and raised skill requirement (20)
	* Radius augments with skill level (base = 1, 2 after level 30, 3 after level 40 and 4 after level 50)
	* Added description to spell scroll.
- Ice Cone
	* The ice_shards effect now doesn't do damage, only the actual spell does.
	* Toned down damage for balance (now power = skill*2, because it has a freeze chance) and raised skill requirement (20)
	* Cone length augments with skill level (base = 2, 3 after level 30, 4 after level 40 and 5 after level 50)
	* Spell has a 25% chance to freeze any monster it hits.
	* Added description to spell scroll.
- Lightning Storm
	* Added light to visual effect.
	* Toned down damage for balance (now power = skill*3) and raised skill requirement (20)
	* Changed chape to "diamond" from exsp.areaOfEffect, to differentiate from Fire Storm.
	* Radius augments with skill level (base = 2, 3 after level 30, 4 after level 40 and 5 after level 50)
	* Added description to spell scroll.
- Poison Burst
	* Toned down damage for balance (now power = skill*2, because it also leaves the poison cloud) and raised skill requirement (20)
	* Burst size augments with skill level (base = 1, 2 after level 30, 3 after level 40 and 4 after level 50)
	* Added description to spell scroll.
- Anti-Magic Zone
	* Spells which fly through an anti-magic zone are now destroyed.
]]


-- Set which elements to load:
-- ===========================

local loadHealingSpell = true

local loadHoldMonsterSpell = true
local loadPushMonsterSpell = true
local loadBurnMonsterSpell = true
local loadFreezeMonsterSpell = true

local loadFireStormSpell = true
local loadIceConeSpell = true
local loadLightningStormSpell = true
local loadPoisonBurstSpell = true

local loadAntiMagicZoneObject = true



-- ******************************
-- HEALING DEFINITIONS
-- ******************************

if loadHealingSpell then

	defineSpell{
		name = "healing",
		uiName = "Healing",
		skill = "spellcraft",
		level = 16,
		runes = "BF",
		manaCost = 20,
		onCast = function(caster, x, y, direction, skill)
			exsp_grimwold_healing.heal(caster, skill)
		end,
	}

	defineObject{
		name = "scroll_healing",
		class = "Item",
		uiName = "Scroll of Healing",
		model = "assets/models/items/scroll_spell.fbx",
		gfxIndex = 113,
		scroll = true,
		spell = "healing",
		weight = 0.3,
		description = [[
			This spell will either heal the champion with the lowest health percentage or, 
			above level 24, heal all champions.
			
			The amount of health restored is dependent on the caster's spellcraft skill.
		]]
	}

	fw_addModule("exsp_grimwold_healing",[[
		function heal(caster, skill)
			local character_to_heal = 5
			local least_health = 10000
			local max_health = 10000
			local percentage_health = 100
			local champName = "No-one"
			if skill < 24 then 
				local heal_amount = math.random(2,4)*skill
				for j=1,4 do
					if party:getChampion(j):getEnabled() and party:getChampion(j):isAlive() then
						if party:getChampion(j):getStat("health") / party:getChampion(j):getStatMax("health") * 100 < percentage_health then
							least_health = party:getChampion(j):getStat("health")
							max_health = party:getChampion(j):getStatMax("health")
							percentage_health = least_health / max_health * 100
							character_to_heal = j
						end
					end
				end
				if (character_to_heal < 5) then
					champName = party:getChampion(character_to_heal):getName()
					party:getChampion(character_to_heal):modifyStat("health", heal_amount)
				end
				-- hudPrint(champName .. " has " .. tostring(least_health) .. " of " .. tostring(max_health))
				hudPrint(champName .. " was healed by " .. caster:getName())
			else
				local heal_amount = math.random(6,8) /4 *skill
				for i=1,4 do
					party:getChampion(i):modifyStat("health", heal_amount)
				end
				hudPrint(caster:getName() .. " healed the party")
			end
			playSound("heal_party")
			party:playScreenEffect("frostburst")
		end
	]])
	
end



-- ******************************
-- HOLD MONSTER DEFINITIONS
-- ******************************

if loadHoldMonsterSpell then

	defineParticleSystem{
		name = "hold_monster_dust",
		emitters = {
			{
				objectSpace = true,
				emissionRate = 5,
				emissionTime = 0,
				maxParticles = 100,
				boxMin = {-1.0, 0.0,-1.0},
				boxMax = { 1.0, 0.0, 1.0},
				sprayAngle = {0,50},
				velocity = {0,0},
				texture = "assets/textures/particles/fog.tga",
				lifetime = {100000,100000},
				color0 = {0.05, 0.05, 0.05},
				opacity = 0.5,
				fadeIn = 1,
				fadeOut = 4,
				size = {0.4, 0.8},
				gravity = {0,0.3,0},
				airResistance = 1,
				rotationSpeed = 0.6,
				blendMode = "Translucent",
			},
			
			{
				objectSpace = true,
				emissionRate = 10,
				emissionTime = 0,
				maxParticles = 200,
				boxMin = {-1.0, 0.0,-1.0},
				boxMax = { 1.0, 0.0, 1.0},
				sprayAngle = {0,50},
				velocity = {0,0},
				texture = "assets/textures/particles/glow.tga",
				lifetime = {100000,100000},
				color0 = {0.8, 0.8, 0.8},
				opacity = 0.7,
				fadeIn = 1,
				fadeOut = 4,
				size = {0.01, 0.05},
				gravity = {0,0.2,0},
				airResistance = 1,
				rotationSpeed = 0.6,
				blendMode = "Translucent",
			}
		}
	}

	defineParticleSystem{
		name = "hold_monster_burst",
		emitters = {
			-- sparks
			{
				spawnBurst = true,
				maxParticles = 200,
				boxMin = {-0.1, -0.1, -0.1},
				boxMax = { 0.1,  0.1,  0.1},
				sprayAngle = {0,360},
				velocity = {4,6},
				objectSpace = false,
				texture = "assets/textures/particles/teleporter.tga",
				lifetime = {0.2,0.8},
				color0 = {0.05,0.05,0.05},
				opacity = 0.2,
				fadeIn = 0.1,
				fadeOut = 0.3,
				size = {0.05, 0.3},
				gravity = {0,-6,0},
				airResistance = 1,
				rotationSpeed = 2,
				blendMode = "Additive",
			},

			-- fog
			{
				spawnBurst = true,
				maxParticles = 50,
				sprayAngle = {0,360},
				velocity = {0,3},
				objectSpace = true,
				texture = "assets/textures/particles/fog.tga",
				lifetime = {0.4,0.6},
				color0 = {0.05, 0.05, 0.05},
				opacity = 0.3,
				fadeIn = 0.1,
				fadeOut = 0.3,
				size = {1, 2},
				gravity = {0,0,0},
				airResistance = 0.5,
				rotationSpeed = 1,
				blendMode = "Additive",
			},

			-- glow
			{
				spawnBurst = true,
				emissionRate = 1,
				emissionTime = 0,
				maxParticles = 1,
				boxMin = {0,0,-0.1},
				boxMax = {0,0,-0.1},
				sprayAngle = {0,30},
				velocity = {0,0},
				texture = "assets/textures/particles/glow.tga",
				lifetime = {0.5, 0.5},
				colorAnimation = false,
				color0 = {1, 1, 1},
				opacity = 0.4,
				fadeIn = 0.01,
				fadeOut = 0.5,
				size = {1, 1},
				gravity = {0,0,0},
				airResistance = 1,
				rotationSpeed = 2,
				blendMode = "Additive",
			}
		}
	}

	defineObject{
		name = "hold_monster",
		class = "BurstSpell",
		particleSystem = "hold_monster_burst",
		lightColor = vec(0.8, 0.8, 0.8),
		lightBrightness = 30,
		lightRange = 4,
		sound = "generic_spell",
		attackPower = 1,
		damageType = "fire",
		tags = { "spell" },
	}

	defineSpell{
		name = "hold_monster",
		uiName = "Hold Monster",
		skill = "earth_magic",
		level = 5,
		runes = "FG",
		manaCost = 30,
		onCast = function(caster, x, y, direction, skill)
			exsp:spellCast("hold_monster", caster, {skill = skill})
		end,
	}

	defineObject{
		name = "scroll_hold_monster",
		class = "Item",
		uiName = "Scroll of Hold Monster",
		model = "assets/models/items/scroll_spell.fbx",
		gfxIndex = 113,
		scroll = true,
		spell = "hold_monster",
		weight = 0.3,
		description = [[
			A monster infront of the party is held and unable to move, 
			turn or attack for a number of seconds based on the casters skill.
			
			Stronger monsters will be less affected by the spell.
			]],
	}

	fw_addModule("exsp_grimwold_holdMonster",[[
		holdMonsterFxIds = {}
		
		function autoexec()
			exsp:defineSpell("hold_monster",{
				spawnObject = "hold_monster",
				damageType = "none",
				burst = true,
				onMonsterHit = function(self, monster1, monster2, monster3, monster4)
					
					local duration = self.skill / 1.5 - math.floor(monster1:getHealth()/100)
					
					-- Hold monster(s)
					local monsters = {monster1, monster2, monster3, monster4}
					for _,monster in ipairs(monsters) do
						monster:hold(duration)
					end
					
					-- Create dust FX
					local fxId = exsp:playFx("hold_monster_dust", self.level, self.x, self.y)
					
					-- Set onUnhold hook to destroy FX when monster is unheld
					holdMonsterFxIds[monster1.id] = fxId
					monster1:onUnhold(
						function(self)
							local fxId = exsp_grimwold_holdMonster.holdMonsterFxIds[self.id] 
							if findEntity(fxId) ~= nil then
								findEntity(fxId):destroy()
							end
						end
					)

				end
				}
			)

			exsp:defineFx("hold_monster_dust",{
				particleSystem = "hold_monster_dust",
				color = {1.0, 1.0, 1.0},
				brightness = 5,
				range = 3,
				castShadow = true,
				time = 1000,
				translation = {0,0.2,0}
				}
			)
		end
	]])
	
end



-- ******************************
-- PUSH MONSTER DEFINITIONS
-- ******************************

if loadPushMonsterSpell then

	defineParticleSystem{
		name = "push_monster_burst",
		emitters = {
			-- fog
			{
				spawnBurst = true,
				maxParticles = 50,
				sprayAngle = {0,360},
				velocity = {0,3},
				objectSpace = true,
				texture = "assets/textures/particles/fog.tga",
				lifetime = {0.4,1.0},
				color0 = {0.8, 0.9, 1.8},
				opacity = 0.3,
				fadeIn = 0.1,
				fadeOut = 2.9,
				size = {1, 2},
				gravity = {0,0,0},
				airResistance = 1,
				rotationSpeed = 1,
				blendMode = "Additive",
			},

			-- glow
			{
				spawnBurst = true,
				emissionRate = 1,
				emissionTime = 0,
				maxParticles = 1,
				boxMin = {0,0,-0.1},
				boxMax = {0,0,-0.1},
				sprayAngle = {0,30},
				velocity = {0,0},
				texture = "assets/textures/particles/glow.tga",
				lifetime = {0.5, 0.5},
				colorAnimation = false,
				color0 = {0.8, 0.9, 1.8},
				opacity = 0.4,
				fadeIn = 0.01,
				fadeOut = 0.5,
				size = {1, 1},
				gravity = {0,0,0},
				airResistance = 1,
				rotationSpeed = 2,
				blendMode = "Additive",
			}
		}
	}

	defineObject{
		name = "push_monster",
		class = "BurstSpell",
		particleSystem = "push_monster_burst",
		lightColor = vec(0.8, 0.8, 0.8),
		lightBrightness = 30,
		lightRange = 4,
		sound = "fireball_launch",
		attackPower = 1,
		damageType = "fire",
		--cameraShake = true,
		tags = { "spell" },
	}

	defineSpell{
		name = "push_monster",
		uiName = "Push Monster",
		skill = "air_magic",
		level = 5,
		runes = "CF",
		manaCost = 20,
		onCast = function(caster, x, y, direction, skill)
			exsp:spellCast("push_monster", caster)
		end,
	}

	defineObject{
		name = "scroll_push_monster",
		class = "Item",
		uiName = "Scroll of Push Monster",
		model = "assets/models/items/scroll_spell.fbx",
		gfxIndex = 113,
		scroll = true,
		spell = "push_monster",
		weight = 0.3,
		description = [[
			This spell will cause a monster in front of the party to be 
			teleported back one space away if able.
			]]
	}

	fw_addModule("exsp_grimwold_pushMonster",[[
		function autoexec()
			exsp:defineSpell("push_monster",{
				spawnObject = "push_monster",
				damageType = "none",
				burst = true,
				onMonsterHit = function(self, monster)
					
					local dx, dy = getForward(self.facing)

					if not(self:getCollisionAhead()) then
						monster:move(monster.level, monster.x+dx, monster.y+dy, monster.facing)
						monster:hold(0.2)
					end

					-- The following code checks if monster is being held by a Hold Monster spell to push the FX along with the monster
					if exsp_grimwold_holdMonster and monster:isHeld() 
							and exsp_grimwold_holdMonster.holdMonsterFxIds[monster.id] ~= nil then
						findEntity(exsp_grimwold_holdMonster.holdMonsterFxIds[monster.id]):translate(dx*3, 0, -dy*3)
					end
				end
				}
			)
		end
	]])	
		
end



-- ******************************
-- BURN MONSTER DEFINITIONS
-- ******************************

if loadBurnMonsterSpell then

	defineSpell{
		name = "burn_monster",
		uiName = "Burn Monster",
		skill = "fire_magic",
		level = 5,
		runes = "AGH",
		manaCost = 30,
		onCast = function(caster, x, y, direction, skill)
			exsp:spellCast("burn_monster", caster, {power = math.ceil(skill/2), skill = skill})
		end,
	}

	defineObject{
		name = "scroll_burn_monster",
		class = "Item",
		uiName = "Scroll of Burn Monster",
		model = "assets/models/items/scroll_spell.fbx",
		gfxIndex = 113,
		scroll = true,
		spell = "burn_monster",
		weight = 0.3,
		description = [[
			A monster infront of the party is burnt every 2 seconds, 
			for a duration and damage based on the caster's Fire Magic skill.
		]]
	}

	fw_addModule("exsp_grimwold_burnMonster",[[
		function autoexec()
			exsp:cloneSpell("burn_monster",{
				baseSpell = "fireburst",
				onMonsterHit = function(self, monster1, monster2, monster3, monster4)
					
					local duration = self.skill + 1
					
					-- Pack a table of monsters to send to the residual effect function
					local monsters = {monster1, monster2, monster3, monster4}

					-- Set up the residual burn effect, at a 2s interval for duration/2 times
					self:residualEffect(2, math.ceil(duration/2),
						function(self, spell, monsters)
							-- Find location of last alive monster from the (possible) group
							local level, x, y
							if monsters then
								for _,monster in ipairs(monsters) do
									if findEntity(monster.id) then
										level, x, y = monster.level, monster.x, monster.y
									end
								end
								-- If there's one, burn it! spellDamage() automatically applies the damage type, ordinal, and the power that was originally set when spellCast() was called.
								if level ~= nil then
									spell:damage(level, x, y)
								end
							else
								spell:cancelResidualEffect(self.id)
							end
						end,
						{self, monsters}
					)

				end
				}
			)
		end
	]])	
		
end



-- ******************************
-- FREEZE MONSTER DEFINITIONS
-- ******************************

if loadFreezeMonsterSpell then

	defineParticleSystem{
		name = "freeze_monster_burst",
		emitters = {
			-- sparks
			{
				spawnBurst = true,
				maxParticles = 200,
				boxMin = {-0.1, -0.1, -0.1},
				boxMax = { 0.1,  0.1,  0.1},
				sprayAngle = {0,360},
				velocity = {4,6},
				objectSpace = false,
				texture = "assets/textures/particles/teleporter.tga",
				lifetime = {0.2,0.8},
				color0 = {0.05,0.05,0.05},
				opacity = 0.3,
				fadeIn = 0.1,
				fadeOut = 0.3,
				size = {0.05, 0.3},
				gravity = {0,-6,0},
				airResistance = 1,
				rotationSpeed = 2,
				blendMode = "Additive",
			},

			-- fog
			{
				spawnBurst = true,
				maxParticles = 50,
				sprayAngle = {0,360},
				velocity = {0,3},
				objectSpace = true,
				texture = "assets/textures/particles/fog.tga",
				lifetime = {0.4,0.6},
				color0 = {0.05, 0.05, 0.05},
				opacity = 0.5,
				fadeIn = 0.1,
				fadeOut = 0.3,
				size = {1, 2},
				gravity = {0,0,0},
				airResistance = 0.5,
				rotationSpeed = 1,
				blendMode = "Additive",
			},

			-- glow
			{
				spawnBurst = true,
				emissionRate = 1,
				emissionTime = 0,
				maxParticles = 1,
				boxMin = {0,0,-0.1},
				boxMax = {0,0,-0.1},
				sprayAngle = {0,30},
				velocity = {0,0},
				texture = "assets/textures/particles/glow.tga",
				lifetime = {0.5, 0.5},
				colorAnimation = false,
				color0 = {1, 1, 1},
				opacity = 0.4,
				fadeIn = 0.01,
				fadeOut = 0.5,
				size = {1, 1},
				gravity = {0,0,0},
				airResistance = 1,
				rotationSpeed = 2,
				blendMode = "Additive",
			}
		}
	}
	
	defineObject{
		name = "freeze_monster_burst",
		class = "BurstSpell",
		particleSystem = "freeze_monster_burst",
		lightColor = vec(0.25, 0.5, 1),
		lightBrightness = 40,
		lightRange = 4,
		sound = "frostburst",
		attackPower = 1,
		damageType = "cold",
		tags = { "spell" },
	}
	
	defineSpell{
		name = "freeze_monster",
		uiName = "Freeze Monster",
		skill = "ice_magic",
		level = 5,
		runes = "FI",
		manaCost = 40,
		onCast = function(caster, x, y, direction, skill)
			exsp:spellCast("freeze_monster", caster, {skill = skill})
		end,
	}

	defineObject{
		name = "scroll_freeze_monster",
		class = "Item",
		uiName = "Scroll of Freeze Monster",
		model = "assets/models/items/scroll_spell.fbx",
		gfxIndex = 113,
		scroll = true,
		spell = "freeze_monster",
		weight = 0.3,
		description = [[
			This spell will freeze a monster infront of the party. 
			Duration is based on the caster's Ice Magic skill.
			
			Stronger monsters will be less affected by the spell.
			]]
	}

	fw_addModule("exsp_grimwold_freezeMonster",[[
		function autoexec()
			exsp:defineSpell("freeze_monster",{
				spawnObject = "freeze_monster_burst",
				damageType = "none",
				burst = true,
				onMonsterHit = function(self, monster)
					local duration = self.skill / 1.5 - math.floor(monster:getHealth()/100)
					monster:freeze(duration)
				end
				}
			)
		end
	]])	
		
end


-- ******************************
-- FIRE STORM DEFINITIONS
-- ******************************

if loadFireStormSpell then

	defineParticleSystem{
		name = "firestorm",
			emitters = {

			-- flames
			{
			spawnBurst = true,
			maxParticles = 30,
			sprayAngle = {0,360},
			velocity = {3,5},
			objectSpace = true,
			texture = "assets/textures/particles/torch_flame.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 16,
			lifetime = {0.4,0.6},
			color0 = {1, 0.5, 0.25},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.3,
			size = {0.5, 1.5},
			gravity = {0,-15,0},
			airResistance = 0.5,
			rotationSpeed = 0,
			blendMode = "Additive",
			},

			-- glow
			{
			spawnBurst = true,
			emissionRate = 1,
			emissionTime = 0,
			maxParticles = 1,
			boxMin = {0,0,-0.1},
			boxMax = {0,0,-0.1},
			sprayAngle = {0,30},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {0.5, 0.5},
			colorAnimation = false,
			color0 = {1.500000, 0.495000, 0.090000},
			opacity = 1,
			fadeIn = 0.01,
			fadeOut = 0.5,
			size = {4, 4},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
			}
		}
	}

	defineSpell{
		name = "fire_storm",
		uiName = "Fire Storm",
		skill = "fire_magic",
		level = 20,
		runes = "AFH",
		manaCost = 35,
		onCast = function(caster,x,y,direction,skill)
			return exsp:spellCast("fire_storm", caster, {power = skill*2, skill = skill})
		end,
	}
	
	defineObject{
		name = "scroll_fire_storm",
		class = "Item",
		uiName = "Scroll of Fire Storm",
		model = "assets/models/items/scroll_spell.fbx",
		gfxIndex = 113,
		scroll = true,
		spell = "fire_storm",
		weight = 0.3,
		description = [[
			A fiery storm that damages all tiles around the party.
			
			The damage and radius are based on the caster's Fire Magic skill:
			20-29: 3x3 area
			30-39: 5x5 area
			40-49: 7x7 area
			50+: 9x9 area
			]]
	}

	fw_addModule("exsp_grimwold_fireStorm",[[
		function autoexec()
			exsp:defineSpell("fire_storm",{
				damageType = "fire",
				burst = true,
				onCast = function(self)
					local skill = self.skill
					local radius = 1
					if skill >= 50 then
						radius = 4
					elseif skill >= 40 then
						radius = 3
					elseif skill >= 30 then
						radius = 2
					end
					for i in exsp.areaOfEffect(party.x, party.y, "square", radius) do
						self:damage(party.level, i.x, i.y)
						exsp:playFx("firestorm", party.level, i.x, i.y)
					end
					playSound("fireburst")
				end
				}
			)
			
			exsp:defineFx("firestorm",{
				particleSystem = "firestorm",
				color = {1.5, 0.4, 0.1},
				brightness = 30,
				range = 5,
				castShadow = true,
				time = 1,
				translation = {0,1.35,0}
				}
			)
		end
	]])
	
end



-- ******************************
-- ICE CONE DEFINITIONS
-- ******************************

if loadIceConeSpell then
	
	defineObject{
	   name = "one_ice_shard",
	   class = "IceShards",
	   attackPower = 1,
	   chainCounter = 1,
	   --cameraShake = true,
	   tags = { "spell" },
	}
	
	defineSpell{
		name = "ice_cone",
		uiName = "Ice Cone",
		skill = "ice_magic",
		level = 20,
		runes = "FHI",
		manaCost = 35,
		onCast = function(caster,x,y,direction,skill)
			exsp:spellCast("ice_cone", caster, {power = skill*2, skill = skill})
		end,
	}
	
	defineObject{
		name = "scroll_ice_cone",
		class = "Item",
		uiName = "Scroll of Ice Cone",
		model = "assets/models/items/scroll_spell.fbx",
		gfxIndex = 113,
		scroll = true,
		spell = "ice_cone",
		weight = 0.3,
		description = [[
			A cone of icy shards that damages enemies ahead, potentially
			
			The damage and cone length are based on the caster's Ice Magic skill:
			20-29: 2 tiles ahead
			30-39: 3 tiles ahead
			40-49: 4 tiles ahead
			50+: 5 tiles ahead
			]]
	}

	fw_addModule("exsp_grimwold_iceCone",[[
		function autoexec()
			exsp:defineSpell("ice_cone",{
				damageType = "cold",
				burst = true,
				onCast = function(self)
					local skill = self.skill
					local length = 2
					if skill >= 50 then
						length = 5
					elseif skill >= 40 then
						length = 4
					elseif skill >= 30 then
						length = 3
					end
					for i in exsp.areaOfEffect(party.x, party.y, "cone", length, true, party.facing) do
						local monsters = {}
						for j in entitiesAt(party.level, i.x, i.y) do
							if j.class == "Monster" then
								local monster = extend:entity(j)
								monster:makeInvulnerable()
								table.insert(monsters, monster)
							end
						end
						spawn("one_ice_shard", party.level, i.x, i.y, 0)
						if monsters[1] then
							exsp.delay(0.1,
								function(self, spell, x, y, monsters)
									for _,monster in ipairs(monsters) do
										if monster then
											monster:unmakeInvulnerable()
										end
									end
									spell:damage(party.level, x, y)
									if math.random(0,100) < 25 then
										if monsters[1] then
											monsters[1]:freeze(spell.skill/3)
										end
									end
								end,
								{self, i.x, i.y, monsters}
							)
						end
					end
					playSound("ice_shard")
				end
				}
			)
		end
	]])

end



-- ******************************
-- LIGHTNING STORM DEFINITIONS
-- ******************************

if loadLightningStormSpell then

	defineSpell{
		name = "lightning_storm",
		uiName = "Lightning Storm",
		skill = "air_magic",
		level = 20,
		runes = "CFH",
		manaCost = 35,
		onCast = function(caster,x,y,direction,skill)
			return exsp:spellCast("lightning_storm", caster, {power = skill*3, skill = skill})
		end,
	}
	
	defineObject{
		name = "scroll_lightning_storm",
		class = "Item",
		uiName = "Scroll of Lightning Storm",
		model = "assets/models/items/scroll_spell.fbx",
		gfxIndex = 113,
		scroll = true,
		spell = "lightning_storm",
		weight = 0.3,
		description = [[
			A lightning storm that damages all tiles around the party.

			The damage and radius are based on the caster's Air Magic skill:
			20-29: 3x3 diamond shape
			30-39: 5x5 diamond shape
			40-49: 7x7 diamond shape
			50+: 9x9 diamond shape
			]]
	}

	fw_addModule("exsp_grimwold_lightningStorm",[[
		function autoexec()
			exsp:defineSpell("lightning_storm",{
				damageType = "shock",
				burst = true,
				onCast = function(self)
					local skill = self.skill
					local radius = 2
					if skill >= 50 then
						radius = 5
					elseif skill >= 40 then
						radius = 4
					elseif skill >= 30 then
						radius = 3
					end
					for i in exsp.areaOfEffect(party.x, party.y, "diamond", radius) do
						self:damage(party.level, i.x, i.y)
						exsp:playFx("lightningstorm", party.level, i.x, i.y)
					end
					playSound("shockburst")
				end
				}
			)
			
			exsp:defineFx("lightningstorm",{
				particleSystem = "shockburst",
				color = {0.25, 0.5, 1},
				brightness = 40,
				range = 6,
				castShadow = true,
				time = 1,
				translation = {0,1.35,0}
				}
			)
		end
	]])
	
end



-- ******************************
-- POISON BURST DEFINITIONS
-- ******************************

if loadPoisonBurstSpell then

	cloneObject{
		name = "poison_burst_cloud",
		baseObject = "poison_cloud",
		attackPower = 10,
		tags = { "spell" },
	}
	
	defineSpell{
		name = "poison_burst",
		uiName = "Poision Burst",
		skill = "earth_magic",
		level = 20,
		runes = "FGH",
		manaCost = 35,
		onCast = function(caster,x,y,direction,skill)
			return exsp:spellCast("poison_burst", caster, {power = skill*2, skill = skill})
		end,
	}
	
	defineObject{
		name = "scroll_poison_burst",
		class = "Item",
		uiName = "Scroll of Poison Burst",
		model = "assets/models/items/scroll_spell.fbx",
		gfxIndex = 113,
		scroll = true,
		spell = "poison_burst",
		weight = 0.3,
		description = [[
			A poisonous cloud is sprayed in a wide cone in front of the party.
			
			The damage and cone length are based on the caster's Ice Magic skill:
			20-29: 1 tiles ahead
			30-39: 2 tiles ahead
			40-49: 3 tiles ahead
			50+: 4 tiles ahead
			]]
	}

	fw_addModule("exsp_grimwold_poisonBurst",[[
		function autoexec()
			exsp:defineSpell("poison_burst",{
				damageType = "poison",
				burst = true,
				onCast = function(self)
					local skill = self.skill
					local radius = 1
					if skill >= 50 then
						radius = 4
					elseif skill >= 40 then
						radius = 3
					elseif skill >= 30 then
						radius = 2
					end
					for i in exsp.areaOfEffect(party.x, party.y, "cone_wide", radius, true, party.facing) do
						self:damage(party.level, i.x, i.y)
						spawn("poison_burst_cloud", party.level, i.x, i.y, 0)
					end
					playSound("poison_cloud")
				end
				}
			)
		end
	]])
	
end










-- ******************************
-- ANTI-MAGIC ZONE DEFINITIONS
-- ******************************

if loadAntiMagicZoneObject then

	defineParticleSystem{
		name = "antimagic_fizzle",
		emitters = {
			-- smoke
			{
				
				emissionRate = 15,
				emissionTime = 0.3,
				maxParticles = 100,
				boxMin = {0.0, 0.0, 0.0},
				boxMax = {0.0, 0.0, 0.0},
				sprayAngle = {0,100},
				velocity = {0.1, 0.5},
				texture = "assets/textures/particles/smoke_01.tga",
				lifetime = {0.5,1.5},
				color0 = {0.25, 0.20, 0.17},
				opacity = 0.5,
				fadeIn = 0.3,
				fadeOut = 0.9,
				size = {2, 3},
				gravity = {0,0,0},
				airResistance = 0.1,
				rotationSpeed = 0.5,
				blendMode = "Translucent",
			},

			-- flames
			{
				spawnBurst = true,
				maxParticles = 40,
				sprayAngle = {0,360},
				velocity = {0,1.5},
				objectSpace = true,
				texture = "assets/textures/particles/fog.tga",
				frameRate = 35,
				frameSize = 64,
				frameCount = 16,
				lifetime = {0.4,0.6},
				color0 = {0.02, 0.02, 0.02},
				opacity = 0.3,
				fadeIn = 0.1,
				fadeOut = 0.3,
				size = {0.5, 1.5},
				gravity = {0,0,0},
				airResistance = 0.5,
				rotationSpeed = 2,
				blendMode = "Additive",
			},
		}
	}

	cloneObject{
	   name = "antimagic_zone",
	   baseObject = "pressure_plate_hidden",
	   editorIcon = 96,
	}
	
	fw_addModule("exsp_grimwold_antimagiczone",[[
		function autoexec()
			fw.addHooks("party", "antiMagicZone",{
				onCastSpell  = function(caster,spell)
					return exsp_grimwold_antimagiczone.spellCheck(caster,spell)
				end,
				},
				1
			)
			
			exsp:addSpellHooks("allSpells",{
				onPass = function(self)
					-- check if spell passes in an anti-magic zone
					local level, x, y = self:getPosition()
					for i in entitiesAt(level, x, y) do
						if i.name == "antimagic_zone" then
							self:destroy()
							exsp:playFx("antimagic_fizzle", level, x, y)
							return false
						end
					end
				end
				}
			)
			
			exsp:defineFx("antimagic_fizzle",{
				particleSystem = "antimagic_fizzle",
				color = {0.1, 0.1, 0.1},
				brightness = 10,
				range = 4,
				castShadow = true,
				time = 2,
				translation = {0,1.35,0}
				}
			)
		end
		
		function spellCheck(caster,spell)
			for i in entitiesAt(party.level,party.x,party.y) do
				if i.name == "antimagic_zone" then
					hudPrint(caster:getName() .. "'s spell fizzles because of the surrounding anti-magic energies")
					return false
				end
			end
			return true
		end
	]])	

end




