--[[ 
Spell Plugin for EXSP

Spell Name: Energy Beam
Spell Author: Diarmuid (Based on an idea by hyteria)
Script Version: 1.0

Spell Readme:
The caster channels his magical energy in a deadly electrical beam.

The beam will burn any monster in a range of six squares, and will sustain
for as long as the caster has energy available. At higher skill levels, the
spell will deal more damage, but also drain the caster's energy faster.

If the caster moves, turns, attempts to use an item, attempts to attack or
receives damage, he will lose concentration and the spell will be interrupted.
]]

-- ****** Define particle systems and sounds ******
defineParticleSystem{
	name = "energy_beam_N",
	emitters = {
		{
			emissionRate = 200,
			emissionTime = 0,
			maxParticles = 4000,
			boxMin = { -0.1,0.1,18 },
			boxMax = { 0.1,-0.1, -1 },
			sprayAngle = {0,360},
			velocity = {0,0},
			objectSpace = true,
			texture = "assets/textures/particles/lightning01.tga",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {0.1,0.3},
			color0 = {1.5,1.5,1.5},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.1, 0.2},
			gravity = {0,0,0},
			airResistance = 5,
			rotationSpeed = 1,
			blendMode = "Additive",
		},

		-- glow
		{
			spawnBurst = true,
			emissionRate = 400,
			emissionTime = 0,
			maxParticles = 4000,
			boxMin = { -0.01,0.01,18 },
			boxMax = { 0.01,-0.01,-1 },
			sprayAngle = {0,30},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {1000000, 1000000},
			colorAnimation = false,
			color0 = {0.25,0.32,0.5},
			opacity = 0.2,
			fadeIn = 0.1,
			fadeOut = 0.5,
			size = {0.1, 0.1},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
			objectSpace = true,
		}
	}
}

defineParticleSystem{
	name = "energy_beam_E",
	emitters = {
		{
			emissionRate = 200,
			emissionTime = 0,
			maxParticles = 4000,
			boxMin = { 18,0.1,-0.1 },
			boxMax = { -1,-0.1,0.1 },
			sprayAngle = {0,360},
			velocity = {0,0},
			objectSpace = true,
			texture = "assets/textures/particles/lightning01.tga",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {0.1,0.3},
			color0 = {1.5,1.5,1.5},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.1, 0.2},
			gravity = {0,0,0},
			airResistance = 5,
			rotationSpeed = 1,
			blendMode = "Additive",
		},

		-- glow
		{
			spawnBurst = true,
			emissionRate = 400,
			emissionTime = 0,
			maxParticles = 3000,
			boxMin = { 18,0.01,-0.01 },
			boxMax = { -1,-0.01,0.01 },
			sprayAngle = {0,30},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {1000000, 1000000},
			colorAnimation = false,
			color0 = {0.25,0.32,0.5},
			opacity = 0.2,
			fadeIn = 0.1,
			fadeOut = 0.5,
			size = {0.1, 0.1},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
			objectSpace = true,
		}
	}
}

defineParticleSystem{
	name = "energy_beam_S",
	emitters = {
		{
			emissionRate = 200,
			emissionTime = 0,
			maxParticles = 4000,
			boxMin = { -0.1,0.1, 1 },
			boxMax = { 0.1,-0.1,-18 },
			sprayAngle = {0,360},
			velocity = {0,0},
			objectSpace = true,
			texture = "assets/textures/particles/lightning01.tga",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {0.1,0.3},
			color0 = {1.5,1.5,1.5},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.1, 0.2},
			gravity = {0,0,0},
			airResistance = 5,
			rotationSpeed = 1,
			blendMode = "Additive",
		},

		-- glow
		{
			spawnBurst = true,
			emissionRate = 400,
			emissionTime = 0,
			maxParticles = 3000,
			boxMin = { -0.01,0.01, 1 },
			boxMax = { 0.01,-0.01,-18 },
			sprayAngle = {0,30},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {1000000, 1000000},
			colorAnimation = false,
			color0 = {0.25,0.32,0.5},
			opacity = 0.2,
			fadeIn = 0.1,
			fadeOut = 0.5,
			size = {0.1, 0.1},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
			objectSpace = true,
		}
	}
}

defineParticleSystem{
	name = "energy_beam_W",
	emitters = {
		{
			emissionRate = 200,
			emissionTime = 0,
			maxParticles = 4000,
			boxMin = { 1,0.1,-0.1 },
			boxMax = { -18,-0.1,0.1 },
			sprayAngle = {0,360},
			velocity = {0,0},
			objectSpace = true,
			texture = "assets/textures/particles/lightning01.tga",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {0.1,0.3},
			color0 = {1.5,1.5,1.5},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.1, 0.2},
			gravity = {0,0,0},
			airResistance = 5,
			rotationSpeed = 1,
			blendMode = "Additive",
		},

		-- glow
		{
			spawnBurst = true,
			emissionRate = 400,
			emissionTime = 0,
			maxParticles = 3000,
			boxMin = { 1,0.01,-0.01 },
			boxMax = { -18,-0.01,0.01 },
			sprayAngle = {0,30},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {1000000, 1000000},
			colorAnimation = false,
			color0 = {0.25,0.32,0.5},
			opacity = 0.2,
			fadeIn = 0.1,
			fadeOut = 0.5,
			size = {0.1, 0.1},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
			objectSpace = true,
		}
	}
}

defineParticleSystem{
	name = "energy_beam_hit",
	emitters = {
		-- sparks
		{
			spawnBurst = true,
			maxParticles = 100,
			boxMin = {-0.1, -0.1, -0.1},
			boxMax = { 0.1,  0.1,  0.1},
			sprayAngle = {0,360},
			velocity = {4,6},
			objectSpace = false,
			texture = "assets/textures/particles/teleporter.tga",
			lifetime = {0.2,1.0},
			color0 = {6.0,6.0,3.4},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.3,
			size = {0.05, 0.15},
			gravity = {0,-6,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
		},
	}
}
-- ****** Define spell object ******

defineObject{
	name = "energy_beam",
	class = "BurstSpell",
	particleSystem = "noParticleSystem",
	lightColor = vec(0.25, 0.5, 1),
	lightBrightness = 40,
	lightRange = 4,
	sound = "shockburst",
	attackPower = 5,
	damageType = "shock",
	--cameraShake = true,
	tags = { "spell" },
}

-- ****** Define spell & spell scroll ******

defineSpell{
	name = "energy_beam",
	uiName = "Energy Beam",
	skill = "air_magic",
	level = 10,
	runes = "ACD",
	manaCost = 2,
	onCast = function(caster,x,y,direction,skill)
		exsp:spellCast("energy_beam", caster, {power = math.floor(10+(skill-10)/4)})
	end
}

defineObject{
		name = "scroll_energy_beam",
		class = "Item",
		uiName = "Scroll of Energy Beam",
		model = "assets/models/items/scroll_spell.fbx",
		gfxIndex = 113,
		scroll = true,
		spell = "energy_beam",
		weight = 0.3,
		description = [[
			The caster channels his magical energy in a deadly electrical beam.
			
			The beam will burn any monster in a range of six squares, and will sustain
			for as long as the caster has energy available. At higher skill levels, the
			spell will deal more damage, but also drain the caster's energy faster.
			
			If the caster moves, turns, attempts to use an item, attempts to attack or
			receives damage, he will lose concentration and the spell will be interrupted.
			]],
	}
	
-- ****** Define script functions ******

fw_addModule("exsp_energy_beam",[[
	function autoexec()

		exsp:defineSpell("energy_beam",{
			-- Basic information
			spawnObject = "energy_beam",
			damageType = "shock",
			attackPower = 5,
			burst = true,
						
			-- Particle Systems
			particleSystem = "noParticleSystem",
			hitParticleEffect = "noParticleSystem",

			-- Light properties
			lightColor = {0.25, 0.5, 1},
			lightBrightness = 40,
			lightRange = 4,
			
			-- Sounds
			sound = "silence",

			-- Hooks
			onCast = function(self)
			
				-- Create beam Fx
				local fxId = exsp:playFx("energy_beam", self.level, self.x, self.y, self.facing)
				
				-- Set beam state to true
				exsp_energy_beam.setBeamState(self._ordinal, true)
				
				-- Initialize and start beam timer
				local beamTimer = timers:create(exsp.randomTimerId("energy_beam.timer"))
				beamTimer:setTimerInterval(0.5)
				beamTimer:addCallback(
					function(self, spell, fxId)
						if exsp_energy_beam.beamState[spell._ordinal] then
							
							-- Play sound Fx
							playSound("shockburst")
							
							-- Drain mana
							local caster = grimq.getChampionFromOrdinal(spell._ordinal)
							local energy = caster:getStat("energy")
							if energy > 0 then
								if energy < spell.power then
									caster:modifyStat("energy", -energy)
								else
									caster:modifyStat("energy", -spell.power)
								end
							end
							
							-- Apply spell damage ahead until a wall is hit, maximum 6 tiles
							local dx,dy = getForward(spell.facing)
							local i = 0
							while not(isWall(spell.level, spell.x+dx*i, spell.y+dy*i)) and i < 7 do
								spell:damage(spell.level, spell.x+dx*i, spell.y+dy*i)
								i = i + 1
							end
							
							-- Create sparks Fx if a wall is hit
							if i < 7 then
								exsp:playFx("energy_beam_hit", spell.level, spell.x+dx*(i-1), spell.y+dy*(i-1), spell.facing)
							end
							
							-- If no more energy, stop beam by setting state to false
							if caster:getStat("energy") < 1 then
								exsp_energy_beam.setBeamState(spell._ordinal, false)
							end

						else
							findEntity(fxId):destroy()
							self:deactivate()
							self:destroy()
						end
					end,
					{self, fxId}
				)
				beamTimer:activate()
			end
			}
		)	

		-- Define beam Fx, with 4 different particleSystems, one for each direction
		exsp:defineFx("energy_beam", {
			particleSystem = {"energy_beam_N", "energy_beam_E", "energy_beam_S", "energy_beam_W"},
			color = {0.25, 0.5, 1},
			brightness = 40,
			range = 4,
			castShadow = true,
			time = 10000,
			translation = {0,1.3,0},
			}
		)
		
		-- Define sparks Fx, with 4 different translations, one for each direction, to make sure effect is on wall
		exsp:defineFx("energy_beam_hit", {
			particleSystem = "energy_beam_hit",
			color = {1.0, 1.0, 1.0},
			brightness = 30,
			range = 4,
			castShadow = true,
			time = 1,
			translation = {{0,1.3,1},{1,1.3,0},{0,1.3,-1},{-1,1.3,0}}
			}
		)
		
		-- Add hooks to the party to check for actions and stop the beam if the caster does anything		
		fw.addHooks("party","exsp_energy_beam",{
			onMove = function()
				for i = 1,4 do
					exsp_energy_beam.setBeamState(i, false)
				end
			end,
			onTurn = function()
				for i = 1,4 do
					exsp_energy_beam.setBeamState(i, false)
				end
			end,
			onCastSpell = function(champion)
				exsp_energy_beam.setBeamState(champion:getOrdinal(), false)
			end,
			onUseItem = function(champion)
				exsp_energy_beam.setBeamState(champion:getOrdinal(), false)
			end,
			onAttack = function(champion)
				exsp_energy_beam.setBeamState(champion:getOrdinal(), false)
			end,
			onDamage = function(champion)
				exsp_energy_beam.setBeamState(champion:getOrdinal(), false)
			end
			},
			1
		)
	end
	
	-- Beam control variables and functions
	beamState = {}
	
	function setBeamState(ordinal, state)
		beamState[ordinal] = state
	end
]])

