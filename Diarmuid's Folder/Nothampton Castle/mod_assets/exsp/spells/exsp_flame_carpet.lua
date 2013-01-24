--[[ 
Spell Plugin for EXSP

Spell Name: Flame Carpet
Spell Author: Diarmuid
Script Version: 1.0

Spell Readme:
I saw many requests for a "fire" version of Ice Shards, so here it is!
"Flames rise from the ground 4 tiles ahead, burning your enemies."
]]

defineParticleSystem{
	name = "flame_carpet_ball",
	emitters = {
		-- fog
		{
			spawnBurst = true,
			maxParticles = 50,
			sprayAngle = {0,360},
			velocity = {0,3},
			objectSpace = true,
			texture = "assets/textures/particles/fog.tga",
			lifetime = {0.4,0.6},
			color0 = {1, 0.4, 0.1},
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
	name = "flame_carpet",
	emitters = {
		-- smoke
		{
		emissionRate = 10,
		emissionTime = 0,
		maxParticles = 100,
		boxMin = {-1, -2, -1},
		boxMax = {1, -1, 1},
		sprayAngle = {0,30},
		velocity = {0.1,0.5},
		texture = "assets/textures/particles/smoke_01.tga",
		lifetime = {1,1.75},
		color0 = {0.15, 0.15, 0.15},
		opacity = 0.1,
		fadeIn = 0.5,
		fadeOut = 1,
		size = {1.0, 1.5},
		gravity = {0,0,0},
		airResistance = 0.1,
		rotationSpeed = 0.6,
		blendMode = "Translucent",
		},

		-- flames
		{
		spawnBurst = true,
		emissionRate = 1000,
		emissionTime = 0,
		maxParticles = 3000,
		boxMin = {-1, -2, -1},
		boxMax = {1, -1.5, 1},
		sprayAngle = {0,10},
		velocity = {0.2, 1},
		texture = "assets/textures/particles/torch_flame.tga",
		frameRate = 15,
		frameSize = 64,
		frameCount = 16,
		lifetime = {0.25, 2.0},
		colorAnimation = true,
		color0 = {2, 2, 2},
		color1 = {1.0, 1.0, 1.0},
		color2 = {1.0, 0.5, 0.25},
		color3 = {1.0, 0.3, 0.1},
		opacity = 1,
		fadeIn = 0.15,
		fadeOut = 0.5,
		size = {0.15, 0.5},
		gravity = {0,-0.1,0},
		airResistance = 1.0,
		rotationSpeed = 0.6,
		blendMode = "Additive",
		depthBias = -0.002,
		},


	}
}

defineObject{
	name = "flame_carpet",
	class = "ProjectileSpell",
	particleSystem = "flame_carpet_ball",
	hitParticleEffect = "noParticleSystem",
	lightColor = vec(1.0, 0.4, 0.1),
	lightBrightness = 10,
	lightRange = 4,
	lightHitBrightness = 10,
	lightHitRange = 4,
	castShadow = true,
	launchSound = "silence",
	projectileSound = "fireball",
	hitSound = "torch_burning",
	projectileSpeed = 15,
	attackPower = 20,
	damageType = "fire",
	--cameraShake = true,
	tags = { "spell" },
}

defineSpell{
	name = "flame_carpet",
	uiName = "Flame Carpet",
	skill = "fire_magic",
	level = 12,
	runes = "AG",
	manaCost = 20,
	onCast = function(caster,x,y,direction,skill)
		exsp:spellCast("flame_carpet", caster)
	end
}

defineObject{
	name = "scroll_flame_carpet",
	class = "Item",
	uiName = "Scroll of Flame Carpet",
	model = "assets/models/items/scroll_spell.fbx",
	gfxIndex = 113,
	scroll = true,
	spell = "flame_carpet",
	weight = 0.3,
	description = "Flames rise from the ground 4 tiles ahead, burning your enemies."
}
	
fw_addModule("exsp_flame_carpet",[[
	function autoexec()
		exsp:defineSpell("flame_carpet",{
			-- Basic information
			spawnObject = "flame_carpet",
			projectileSpeed = 15,
			attackPower = 20,
			damageType = "fire",
			piercing = true,
			maxDistance = 4,
			
			-- Particle Systems
			particleSystem = "flame_carpet_ball",
			hitParticleEffect = "noParticleSystem",

			-- Light properties
			lightColor = {1.0, 0.4, 0.1},
			lightBrightness = 10,
			lightRange = 4,
			lightHitBrightness = 10,
			lightHitRange = 4,
			castShadow = true,
			
			-- Sounds
			launchSound = "fireball_launch",
			projectileSound = "fireball",
			hitSound = "fireball_hit",

			-- Hooks
			onPass = function(self)
				exsp:playFx("flame_carpet", self.level, self.x, self.y)
			end,
			onHit = function(self, level, x, y)
				exsp:playFx("flame_carpet", level, x, y)
			end
			}
		)

		exsp:defineFx("flame_carpet", {
			particleSystem = "flame_carpet",
			color = {1.0, 0.4, 0.1},
			brightness = 10,
			range = 4,
			castShadow = true,
			time = 2,
			translation = {0,1.2,0}
			}
		)
	end
]])