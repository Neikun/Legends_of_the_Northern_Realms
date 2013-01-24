--[[ 
Spell Plugin for EXSP

Spell Name: Reach
Spell Author: Diarmuid
Script Version: 1.1

Spell Readme:
This spell activates buttons and levers from a distance.

Changelog:
1.1 Updated code for exsp 1.4

]]

-- ****** Define particle systems and sounds ******

defineParticleSystem{
	name = "reach_spell",
	emitters = {
		-- trail
		{
			--spawnBurst = true,
			emissionRate = 100,
			emissionTime = 0,
			maxParticles = 100,
			sprayAngle = {0,360},
			--velocity = {0.1,0.5},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {0.2, 2.5},
			colorAnimation = false,
			color0 = {1.5, 0.7, 0.5},
			opacity = 0.7,
			fadeIn = 0.01,
			fadeOut = 2.5,
			size = {0.15, 0.3},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
			objectSpace = true,
		},

		-- trail
		{
			--spawnBurst = true,
			emissionRate = 100,
			emissionTime = 0,
			maxParticles = 100,
			sprayAngle = {0,360},
			velocity = {0.1,1},
			texture = "assets/textures/particles/teleporter.tga",
			lifetime = {0.2, 0.4},
			colorAnimation = false,
			color0 = {2, 1.5, 1},
			opacity = 0.4,
			fadeIn = 0.01,
			fadeOut = 0.3,
			size = {0.15, 0.8},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
			objectSpace = true,
		}
	}
}

defineParticleSystem{
	name = "reach_spell_hit",
	emitters = {
		-- sparks
		{
			spawnBurst = true,
			maxParticles = 80,
			boxMin = {-0.1, -0.1, -0.1},
			boxMax = { 0.1,  0.1,  0.1},
			sprayAngle = {0,360},
			velocity = {4,6},
			objectSpace = false,
			texture = "assets/textures/particles/teleporter.tga",
			lifetime = {0.2,0.6},
			color0 = {4.0,3.0,3.0},
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
			maxParticles = 30,
			sprayAngle = {0,360},
			velocity = {0,3},
			objectSpace = true,
			texture = "assets/textures/particles/fog.tga",
			lifetime = {0.4,1.6},
			color0 = {1, 0.5, 0.6},
			opacity = 0.7,
			fadeIn = 0.1,
			fadeOut = 1.3,
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

defineObject{
	name = "reach_spell",
	class = "ProjectileSpell",
	particleSystem = "reach_spell",
	hitParticleEffect = "reach_spell_hit",
	lightColor = vec(0.6, 0.5, 0.4),
	lightBrightness = 10,
	lightRange = 4,
	lightHitBrightness = 12,
	lightHitRange = 7,
	castShadow = true,
	launchSound = "silence",
	projectileSound = "blob",
	hitSound = "blob_hit",
	projectileSpeed = 7.5,
	attackPower = 1,
	damageType = "shock",
	--cameraShake = true,
	tags = { "spell" },
}

-- ****** Define spell & spell scroll ******

defineSpell{
	name = "reach_spell",
	uiName = "Reach",
	skill = "spellcraft",
	level = 10,
	runes = "F",
	manaCost = 15,
	onCast = function(caster,x,y,direction,skill)
		exsp:spellCast("reach_spell", caster)
	end
}

defineObject{
		name = "scroll_reach_spell",
		class = "Item",
		uiName = "Scroll of Reach",
		model = "assets/models/items/scroll_spell.fbx",
		gfxIndex = 113,
		scroll = true,
		spell = "reach_spell",
		weight = 0.3,
		description = "The caster reaches magically ahead to touch a button or a lever.",
	}
	
-- ****** Define script functions ******


fw_addModule("exsp_reach_spell",[[

	function autoexec()

		exsp:defineSpell("reach_spell",{
			-- Basic information
			spawnObject = "reach_spell",
			projectileSpeed = 7.5,
			damageType = "none",
			
			-- Particle Systems
			particleSystem = "reach_spell",
			hitParticleEffect = "reach_spell_hit",

			-- Light properties
			lightColor = {0.7, 0.5, 0.4},
			lightBrightness = 10,
			lightRange = 4,
			lightHitBrightness = 15,
			lightHitRange = 7,
			castShadow = true,
			
			-- Sounds
			launchSound = "generic_spell",
			projectileSound = "blob",
			hitSound = "blob_hit",

			-- Hooks
			onHit = function(self, level, x, y, hitType, subType, entity)
				if subType == "Button" then
					entity:push()
				end
				if subType == "Lever" then
					entity:toggle()
				end
			end
			}
		)		
	end
]])