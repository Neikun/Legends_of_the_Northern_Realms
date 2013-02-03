--[[ 
Spell Plugin for EXSP

Spell Name: Zo Spell
Spell Author: Diarmuid
Script Version: 1.2

Spell Readme:
This spell opens doors and is modeled after the Dungeon Master Zo spell. I've included a particle with rainbow effect similar to the original.

For runes, the Zo rune referenced the negative plane, so in LoG I equated this to the Death rune. Feel free to adjust.

Note that, to avoid this being game-breaking and allowing to freely open locked doors, only doors which have their id end with "zo" will be opened by the spell. This allows the dungeon designer to set which doors respond to this spell.

If you wish to change the spell name to something else (like "Open Door"), just change the uiName in defineSpell and scroll defineObject.

Changelog:
1.2 Updated code for exsp 1.4
1.1 Dropped deprecated onDoorHit hook in exsp 1.3.2

]]

-- ****** Define particle systems and sounds ******

defineParticleSystem{
	name = "zo_spell",
	emitters = {
		{
			emissionRate = 15,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = { 0,0,0 },
			boxMax = { 0,0,0 },
			sprayAngle = {0,360},
			velocity = {0,0},
			objectSpace = true,
			texture = "mod_assets/exsp/spells/exsp_zo_spell.tga",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {0.1,0.3},
			color0 = {1.5,1.5,1.5},
			opacity = 0.1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.125, 0.5},
			gravity = {0,0,0},
			airResistance = 5,
			rotationSpeed = 1,
			blendMode = "Additive",
		},

		-- core
		{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = { 0,0,0 },
			boxMax = { 0,0,0 },
			sprayAngle = {0,360},
			velocity = {0,0},
			objectSpace = true,
			texture = "mod_assets/exsp/spells/exsp_zo_spell.tga",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {0.1,0.3},
			color0 = {1.5,1.5,1.5},
			opacity = 0.8,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.15, 0.6},
			gravity = {0,0,0},
			airResistance = 5,
			rotationSpeed = 1,
			blendMode = "Additive",
		},

		-- glow
		{
			spawnBurst = true,
			emissionRate = 1,
			emissionTime = 0,
			maxParticles = 1,
			boxMin = {0,0,0.0},
			boxMax = {0,0,0.0},
			sprayAngle = {0,30},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {1000000, 1000000},
			colorAnimation = true,
			color0 = {1,0.5,0.5},
			color1 = {0.5,1.,0.5},
			color2 = {0.5,0.5,0.1},
			color3 = {1,1,0.5},
			opacity = 0.1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.4, 0.6},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
			objectSpace = true,
		}
	}
}

defineParticleSystem{
	name = "zo_spell_hit",
	emitters = {
		-- sparks
		{
			emissionRate = 80,
			emissionTime = 0.3,
			maxParticles = 30,
			boxMin = {-0.5, -0.5, -0.5},
			boxMax = { 0.5,  0.5,  0.5},
			sprayAngle = {0,360},
			velocity = {0,0},
			objectSpace = false,
			texture = "mod_assets/exsp/spells/exsp_zo_spell.tga",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {0.2,0.5},
			color0 = {2.5,2.5,2.5},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.3,
			size = {0.3, 1.4},
			gravity = {0,0,0},
			airResistance = 1,
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
			color0 = {1, 1, 1},
			opacity = 0.5,
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
	name = "zo_spell",
	class = "ProjectileSpell",
	particleSystem = "zo_spell",
	hitParticleEffect = "zo_spell_hit",
	lightColor = vec(0.6, 0.6, 0.6),
	lightBrightness = 10,
	lightRange = 4,
	lightHitBrightness = 12,
	lightHitRange = 7,
	castShadow = true,
	launchSound = "silence",
	projectileSound = "blob",
	hitSound = "blob_hit",
	projectileSpeed = 10,
	attackPower = 1,
	damageType = "shock",
	--cameraShake = true,
	tags = { "spell" },
}

-- ****** Define spell & spell scroll ******

defineSpell{
	name = "zo_spell",
	uiName = "Zo Spell",
	skill = "spellcraft",
	level = 10,
	runes = "H",
	manaCost = 20,
	description = "A bolt of magical negative energy which can open a door from a distance.",
	onCast = function(caster,x,y,direction,skill)
		exsp:spellCast("zo_spell", caster)
	end
}

defineObject{
		name = "scroll_zo_spell",
		class = "Item",
		uiName = "Scroll of Zo Spell",
		model = "assets/models/items/scroll_spell.fbx",
		gfxIndex = 113,
		scroll = true,
		spell = "zo_spell",
		weight = 0.3,
		description = [[
			A bolt of magical negative energy which can open a door from a distance.
			Note that certain doors are magically shielded and will resist the spell.
			]]	
	}
	
-- ****** Define script functions ******


fw_addModule("exsp_zo_spell",[[
	function autoexec()
		exsp:defineSpell("zo_spell",{
			-- Basic information
			spawnObject = "zo_spell",
			projectileSpeed = 10,
			damageType = "none",
			
			-- Particle Systems
			particleSystem = "zo_spell",
			hitParticleEffect = "zo_spell_hit",

			-- Light properties
			lightColor = {0.6, 0.6, 0.6},
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
				if hitType == "door" and grimq.strends(entity.id, "zo") then
					entity:open()
				end
			end
			}
		)
	end
]])