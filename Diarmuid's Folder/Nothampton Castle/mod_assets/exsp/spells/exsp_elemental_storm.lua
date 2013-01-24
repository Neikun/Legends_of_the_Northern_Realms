--[[ 
Spell Plugin for EXSP

Spell Name: Elemental Storm
Spell Author: Diarmuid
Script Version: 1.1

Spell Readme:
This spell launches at random a lightning bolt, a fireball, a poison bolt or a frostbolt, then cycles randomly each tile among them.

The spells explode with a different areaOfEffect depending on which state the spell was in at impact:
Fire: Square shape, 40% damage in 3x3 radius, 25% damage in 5x5 radius
Shock: Diagonal shape, 66% damage in 3x3 radius, 33% damage in 5x5 radius
Ice: Cross, 66% damage in 3x3 radius, 33% damage in 5x5 radius
Poison: Diamond, 50% damage in 3x3 radius, 33% damage in 5x5 radius

The spell includes custom particle effects for AoE explosions.

There is also a Greater Elemental Storm version available, which launches 2 Elemental Storms at the same time.

Changelog:
1.1 Updated definitions for exsp 1.4

]]

-- ****** Define particle systems and sounds ******

defineParticleSystem{
	name = "fireball_hit_5x5",
	emitters = {
		-- smoke
		{
			emissionRate = 30,
			emissionTime = 0.3,
			maxParticles = 100,
			boxMin = {-5.0, 0.0, -5.0},
			boxMax = {5.0, 0.0, 5.0},
			sprayAngle = {0,100},
			velocity = {0.1, 0.5},
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {1,2.6},
			color0 = {0.25, 0.20, 0.17},
			opacity = 1,
			fadeIn = 0.3,
			fadeOut = 1.2,
			size = {2, 3},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 0.5,
			blendMode = "Translucent",
		},

		-- flames
		{
			spawnBurst = true,
			maxParticles = 300,
			sprayAngle = {0,360},
			boxMin = {-3.0, -0.4, -3.0},
			boxMax = {3.0, 0.4, 3.0},
			velocity = {0,3},
			objectSpace = true,
			texture = "assets/textures/particles/torch_flame.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 16,
			lifetime = {0.4,0.8},
			color0 = {1, 0.5, 0.25},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.3,
			size = {0.5, 1.5},
			gravity = {0,0,0},
			airResistance = 0.5,
			rotationSpeed = 2,
			blendMode = "Additive",
		},
		
		-- outer flames
		{
			spawnBurst = true,
			maxParticles = 50,
			sprayAngle = {0,360},
			boxMin = {-5.0, -0.1, -5.0},
			boxMax = {5.0, 0.1, 5.0},
			velocity = {0,3},
			objectSpace = true,
			texture = "assets/textures/particles/torch_flame.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 16,
			lifetime = {0.7,1.2},
			color0 = {1, 0.5, 0.25},
			opacity = 0.8,
			fadeIn = 0.1,
			fadeOut = 0.8,
			size = {0.8, 1.2},
			gravity = {0,0,0},
			airResistance = 0.5,
			rotationSpeed = 2,
			blendMode = "Additive",
		},
		
		-- fog
		{
			spawnBurst = true,
			maxParticles = 400,
			sprayAngle = {0,360},
			velocity = {0.2,0.9},
			boxMin = {-5.0, -0.4, -5.0},
			boxMax = {5.0, 0.4, 5.0},
			objectSpace = true,
			texture = "assets/textures/particles/fog.tga",
			lifetime = {0.1,0.7},
			color0 = {2.6, 1.1, 0.4},
			opacity = 0.4,
			fadeIn = 0.05,
			fadeOut = 0.3,
			size = {0.3, 0.8},
			gravity = {0,0,0},
			airResistance = 0.5,
			rotationSpeed = 1,
			blendMode = "Translucent",
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

defineParticleSystem{
	name = "lightning_bolt_hit_5x5",
	emitters = {
		-- sparks
		{
			emissionRate = 80,
			emissionTime = 0.3,
			maxParticles = 50,
			boxMin = {-0.75, -0.75, -0.75},
			boxMax = { 0.75,  0.75,  0.75},
			sprayAngle = {0,360},
			velocity = {0,0},
			objectSpace = false,
			texture = "assets/textures/particles/lightning01.tga",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {0.2,0.4},
			color0 = {2.5,2.5,2.5},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.3,
			size = {0.2, 2.5},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 0,
			blendMode = "Additive",
		},
		
		-- sparks C1
		{
			emissionRate = 60,
			emissionTime = 0.3,
			maxParticles = 50,
			boxMin = {-4.75, -0.75, -4.75},
			boxMax = {-3.25,  0.75, -3.25},
			sprayAngle = {0,360},
			velocity = {0,0},
			objectSpace = false,
			texture = "assets/textures/particles/lightning01.tga",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {0.2,0.7},
			color0 = {2.5,2.5,2.5},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.6,
			size = {0.2, 2.5},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 0,
			blendMode = "Additive",
		},
		
		-- sparks C2
		{
			emissionRate = 60,
			emissionTime = 0.3,
			maxParticles = 50,
			boxMin = {-4.75, -0.75, 3.25},
			boxMax = {-3.25,  0.75, 4.75},
			sprayAngle = {0,360},
			velocity = {0,0},
			objectSpace = false,
			texture = "assets/textures/particles/lightning01.tga",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {0.2,0.7},
			color0 = {2.5,2.5,2.5},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.6,
			size = {0.2, 2.5},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 0,
			blendMode = "Additive",
		},
		
		-- sparks C3
		{
			emissionRate = 60,
			emissionTime = 0.3,
			maxParticles = 50,
			boxMin = {3.25, -0.75, -4.75},
			boxMax = {4.75,  0.75, -3.25},
			sprayAngle = {0,360},
			velocity = {0,0},
			objectSpace = false,
			texture = "assets/textures/particles/lightning01.tga",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {0.2,0.7},
			color0 = {2.5,2.5,2.5},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.6,
			size = {0.2, 2.5},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 0,
			blendMode = "Additive",
		},
		
		-- sparks C4
		{
			emissionRate = 60,
			emissionTime = 0.3,
			maxParticles = 50,
			boxMin = {3.25, -0.75, 3.25},
			boxMax = {4.75,  0.75, 4.75},
			sprayAngle = {0,360},
			velocity = {0,0},
			objectSpace = false,
			texture = "assets/textures/particles/lightning01.tga",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {0.2,0.7},
			color0 = {2.5,2.5,2.5},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.6,
			size = {0.2, 2.5},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 0,
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
			color0 = {0.25, 0.5, 1},
			opacity = 0.7,
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
			opacity = 1,
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

defineParticleSystem{
	name = "poison_bolt_hit_5x5",
	emitters = {
		-- fog
		{
			spawnBurst = true,
			maxParticles = 500,
			sprayAngle = {0,360},
			velocity = {0.2,0.9},
			boxMin = {-5.0, -0.4, -5.0},
			boxMax = {5.0, 0.4, 5.0},
			objectSpace = true,
			texture = "assets/textures/particles/fog.tga",
			lifetime = {0.2,1.7},
			color0 = {0.18, 0.4, 0.1},
			opacity = 0.4,
			fadeIn = 0.05,
			fadeOut = 1.0,
			size = {0.3, 0.7},
			gravity = {0,0,0},
			airResistance = 0.5,
			rotationSpeed = 1,
			blendMode = "Translucent",
		},

		-- fog 2
		{
			spawnBurst = true,
			maxParticles = 20,
			sprayAngle = {0,360},
			velocity = {0.2,0.9},
			objectSpace = true,
			texture = "assets/textures/particles/poison_cloud.tga",
			lifetime = {0.2,0.7},
			color0 = {1, 1, 1},
			opacity = 0.7,
			fadeIn = 0.05,
			fadeOut = 0.3,
			size = {0.3, 0.7},
			gravity = {0,0,0},
			airResistance = 0.5,
			rotationSpeed = 1,
			blendMode = "Translucent",
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
			color0 = {0.25, 1, 0.2},
			opacity = 0.7,
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

defineParticleSystem{
	name = "frostbolt_hit_5x5",
	emitters = {
		-- sparks
		{
			spawnBurst = true,
			maxParticles = 200,
			boxMin = {-5.1, -0.1, -0.1},
			boxMax = { 5.1,  0.1,  0.1},
			sprayAngle = {0,360},
			velocity = {4,6},
			objectSpace = false,
			texture = "assets/textures/particles/teleporter.tga",
			lifetime = {0.2,0.8},
			color0 = {4.0,4.0,4.0},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.3,
			size = {0.05, 0.3},
			gravity = {0,-6,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
		},

				-- sparks
		{
			spawnBurst = true,
			maxParticles = 200,
			boxMin = {-0.1, -0.1, -5.1},
			boxMax = { 0.1,  0.1,  5.1},
			sprayAngle = {0,360},
			velocity = {4,6},
			objectSpace = false,
			texture = "assets/textures/particles/teleporter.tga",
			lifetime = {0.2,0.8},
			color0 = {4.0,4.0,4.0},
			opacity = 1,
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
			boxMin = {-6.1, -0.1, -0.1},
			boxMax = { 6.1,  0.1,  0.1},
			sprayAngle = {0,360},
			velocity = {0,3},
			objectSpace = true,
			texture = "assets/textures/particles/fog.tga",
			lifetime = {0.4,1.6},
			color0 = {0.25, 0.5, 1},
			opacity = 0.7,
			fadeIn = 0.1,
			fadeOut = 0.8,
			size = {1, 2},
			gravity = {0,0,0},
			airResistance = 0.5,
			rotationSpeed = 1,
			blendMode = "Additive",
		},
		
				-- fog
		{
			spawnBurst = true,
			maxParticles = 50,
			boxMin = {-0.1, -0.1, -6.1},
			boxMax = { 0.1,  0.1,  6.1},
			sprayAngle = {0,360},
			velocity = {0,3},
			objectSpace = true,
			texture = "assets/textures/particles/fog.tga",
			lifetime = {0.4,1.6},
			color0 = {0.25, 0.5, 1},
			opacity = 0.7,
			fadeIn = 0.1,
			fadeOut = 0.8,
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
			opacity = 1,
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

-- ****** Define Object ******

cloneObject{
	name = "es_fireball",
	baseObject = "fireball_greater",
	hitParticleEffect = "fireball_hit_5x5",
	lightHitBrightness = 50,
	lightHitRange = 15,
}

cloneObject{
	name = "es_lightning_bolt",
	baseObject = "lightning_bolt_greater",
	projectileSpeed = 7.5,
	hitParticleEffect = "lightning_bolt_hit_5x5",
	lightHitBrightness = 50,
	lightHitRange = 15,
}

cloneObject{
	name = "es_poison_bolt",
	baseObject = "poison_bolt_greater",
	hitParticleEffect = "poison_bolt_hit_5x5",
	lightHitBrightness = 50,
	lightHitRange = 15,
}

cloneObject{
	name = "es_frostbolt",
	baseObject = "improved_frostbolt",
	hitParticleEffect = "frostbolt_hit_5x5",
	lightHitBrightness = 50,
	lightHitRange = 15,
}

-- ****** Define spell & spell scroll ******

defineSpell{
	name = "elemental_storm",
	uiName = "Elemental Storm",
	skill = "spellcraft",
	level = 0,
	runes = "ACGI",
	manaCost = 60,
	description = "An elemental storm of magical energy, hurled at your opponents.",
	onCast = function(caster,x,y,direction,skill)
		local skillLevel = 15
		if caster:getSkillLevel("air_magic") < skillLevel or caster:getSkillLevel("fire_magic") < skillLevel
			or caster:getSkillLevel("ice_magic") < skillLevel or caster:getSkillLevel("earth_magic") < skillLevel then
			hudPrint(caster:getName().."'s spell fizzles.")
			return false
		end
		exsp:spellCast("elemental_storm", caster, {power = 60})
	end
}

defineObject{
	name = "scroll_elemental_storm",
	class = "Item",
	uiName = "Scroll of Elemental Storm",
	model = "assets/models/items/scroll_spell.fbx",
	gfxIndex = 113,
	scroll = true,
	spell = "elemental_storm",
	description = [[
		Required Skills: Air Magic 15, Fire Magic 15, Earth Magic 15, Ice Magic 15
		
		This spell launches at random a lightning bolt, a fireball, a poison bolt or
		a frostbolt, then cycles randomly each tile among them.

		The spells explode with a different areaOfEffect depending
		on which state the spell was in at impact:
		Fire: Square shape, 40% damage in 3x3 radius, 25% damage in 5x5 radius
		Shock: Diagonal shape, 66% damage in 3x3 radius, 33% damage in 5x5 radius
		Ice: Cross, 66% damage in 3x3 radius, 33% damage in 5x5 radius
		Poison: Diamond, 50% damage in 3x3 radius, 33% damage in 5x5 radius
		]],
	weight = 0.3,
}

defineSpell{
	name = "elemental_storm_greater",
	uiName = "Elemental Storm Greater",
	skill = "air_magic",
	level = 25,
	runes = "ACEGI",
	manaCost = 90,
	description = "An greater elemental storm of magical energy, hurled at your opponents.",
	onCast = function(caster,x,y,direction,skill)
		local skillLevel = 25
		if caster:getSkillLevel("air_magic") < skillLevel or caster:getSkillLevel("fire_magic") < skillLevel
			or caster:getSkillLevel("ice_magic") < skillLevel or caster:getSkillLevel("earth_magic") < skillLevel then
			hudPrint(caster:getName().."'s spell fizzles.")
			return false
		end
		exsp:spellCast("elemental_storm", caster, {power = 90})
		exsp:spellCast("elemental_storm", caster, {power = 90})
	end
}

defineObject{
	name = "scroll_elemental_storm_greater",
	class = "Item",
	uiName = "Scroll of Greater Elemental Storm",
	model = "assets/models/items/scroll_spell.fbx",
	gfxIndex = 113,
	scroll = true,
	spell = "elemental_storm",
	description = [[
		Required Skills: Air Magic 25, Fire Magic 25, Earth Magic 25, Ice Magic 25
		
		This spell launches twice at random a lightning bolt, a fireball, a poison bolt or
		a frostbolt, then cycles randomly each tile among them.

		The spells explode with a different areaOfEffect depending
		on which state the spell was in at impact:
		Fire: Square shape, 40% damage in 3x3 radius, 25% damage in 5x5 radius
		Shock: Diagonal shape, 66% damage in 3x3 radius, 33% damage in 5x5 radius
		Ice: Cross, 66% damage in 3x3 radius, 33% damage in 5x5 radius
		Poison: Diamond, 50% damage in 3x3 radius, 33% damage in 5x5 radius
		]],
	weight = 0.3,
}
	
-- ****** Define script functions ******

fw_addModule("exsp_elemental_storm",[[
function autoexec()

		-- Define the main Elemental Storm spells. As they are not meant to be cast, no need to define anything but the onCast hook.

		exsp:defineSpell("elemental_storm",{
			baseSpell = "lightning_bolt",
			onCast = function(self)
			
				-- Return one of the four states at random. Note that when returning a spell name from onCast like this,
				-- only the spell is substituted. The power and ordinal are kept from the original spellCast function.
				
				num = math.random()
				if num < 0.25 then
					return "elemental_storm_fire"
				elseif num < 0.5 then
					return "elemental_storm_shock"
				elseif num < 0.75 then
					return "elemental_storm_poison"
				else
					return "elemental_storm_cold"
				end
			end
			}
		)

		-- Define the fire state, a clone of fireball

		exsp:cloneSpell("elemental_storm_fire",{
			baseSpell = "fireball_greater",
			spawnObject = "es_fireball",
			onPass = function(self)
				local level, x, y = self:getPosition()
				local facing = self.facing
				local power = self.power
				local ordinal = self.ordinal
				local distance = self.distance
				num = math.random()
				if num < 0.33 then
					self:destroy()
					exsp:spellSpawn("elemental_storm_shock", level, x, y, facing, {power = power, ordinal = ordinal, noLaunch = true, distance =  distance})
					return false
				elseif num < 0.66 then
					self:destroy()
					exsp:spellSpawn("elemental_storm_poison", level, x, y, facing, {power = power, ordinal = ordinal, noLaunch = true, distance =  distance})
					return false
				else
					self:destroy()
					exsp:spellSpawn("elemental_storm_cold", level, x, y, facing, {power = power, ordinal = ordinal, noLaunch = true, distance =  distance})
					return false
				end
			end,
			onHit = function(self, level, x, y)
				local power = self.power
				for i in exsp.areaOfEffect(x, y, "square", 1) do
					self:damage(level, i.x, i.y, math.ceil(power/2.5))
				end
				for i in exsp.areaOfEffect(x, y, "square", 2, false) do
					self:damage(level, i.x, i.y, math.ceil(power/4))
				end
			end	
			}
		)

		-- Define the shock state, a clone of lightning_bolt

		exsp:cloneSpell("elemental_storm_shock",{
			baseSpell = "lightning_bolt_greater",
			spawnObject = "es_lightning_bolt",
			onPass = function(self)
				local level, x, y = self:getPosition()
				local facing = self.facing
				local power = self.power
				local ordinal = self.ordinal
				local distance = self.distance
				num = math.random()
				if num < 0.33 then
					self:destroy()
					exsp:spellSpawn("elemental_storm_fire", level, x, y, facing, {power = power, ordinal = ordinal, noLaunch = true, distance =  distance})
					return false
				elseif num < 0.66 then
					self:destroy()
					exsp:spellSpawn("elemental_storm_poison", level, x, y, facing, {power = power, ordinal = ordinal, noLaunch = true, distance =  distance})
					return false
				else
					self:destroy()
					exsp:spellSpawn("elemental_storm_cold", level, x, y, facing, {power = power, ordinal = ordinal, noLaunch = true, distance =  distance})
					return false
				end
			end,
			onHit = function(self, level, x, y)
				local power = self.power
				for i in exsp.areaOfEffect(x, y, "diagonal", 1) do
					self:damage(level, i.x, i.y, math.ceil(power/1.5))
				end
				for i in exsp.areaOfEffect(x, y, "diagonal", 2, false) do
					self:damage(level, i.x, i.y, math.ceil(power/3))
				end
			end	
			}
		)

		-- Define the poison state, a clone of poison_bolt

		exsp:cloneSpell("elemental_storm_poison",{
			baseSpell = "poison_bolt_greater",
			spawnObject = "es_poison_bolt",
			onPass = function(self)
				local level, x, y = self:getPosition()
				local facing = self.facing
				local power = self.power
				local ordinal = self.ordinal
				local distance = self.distance
				num = math.random()
				if num < 0.33 then
					self:destroy()
					exsp:spellSpawn("elemental_storm_fire", level, x, y, facing, {power = power, ordinal = ordinal, noLaunch = true, distance =  distance})
					return false
				elseif num < 0.66 then
					self:destroy()
					exsp:spellSpawn("elemental_storm_shock", level, x, y, facing, {power = power, ordinal = ordinal, noLaunch = true, distance =  distance})
					return false
				else
					self:destroy()
					exsp:spellSpawn("elemental_storm_cold", level, x, y, facing, {power = power, ordinal = ordinal, noLaunch = true, distance =  distance})
					return false
				end
			end,
			onHit = function(self, level, x, y)
				local power = self.power
				for i in exsp.areaOfEffect(x, y, "diamond", 1) do
					self:damage(level, i.x, i.y, math.ceil(power/2))
				end
				for i in exsp.areaOfEffect(x, y, "diamond", 2, false) do
					self:damage(level, i.x, i.y, math.ceil(power/3))
				end
			end	
			}
		)

		-- Define the cold state, a clone of frostbolt

		exsp:cloneSpell("elemental_storm_cold",{
			baseSpell = "improved_frostbolt",
			spawnObject = "es_frostbolt",
			onPass = function(self)
				local level, x, y = self:getPosition()
				local facing = self.facing
				local power = self.power
				local ordinal = self.ordinal
				local distance = self.distance
				num = math.random()
				if num < 0.33 then
					self:destroy()
					exsp:spellSpawn("elemental_storm_fire", level, x, y, facing, {power = power, ordinal = ordinal, noLaunch = true, distance =  distance})
					return false
				elseif num < 0.66 then
					self:destroy()
					exsp:spellSpawn("elemental_storm_shock", level, x, y, facing, {power = power, ordinal = ordinal, noLaunch = true, distance =  distance})
					return false
				else
					self:destroy()
					exsp:spellSpawn("elemental_storm_poison", level, x, y, facing, {power = power, ordinal = ordinal, noLaunch = true, distance =  distance})
					return false
				end
			end,
			onHit = function(self, level, x, y)
				local power = self.power
				for i in exsp.areaOfEffect(x, y, "cross", 1) do
					self:damage(level, i.x, i.y, math.ceil(power/1.5))
				end
				for i in exsp.areaOfEffect(x, y, "cross", 2, false) do
					self:damage(level, i.x, i.y, math.ceil(power/3))
				end
			end	
			}
		)

	end

]])

