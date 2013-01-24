--[[ 
Spell Plugin for EXSP

This file contains all the definitions for the default Legend of Grimrock spells. It should always
be loaded in exsp_init.lua.

Version: 1.4.1

]]

-- ****** Define particle systems and sounds ******

defineParticleSystem{
	name = "fireball_trail",
	emitters = {
		-- smoke
		{
			emissionRate = 30,
			emissionTime = 0,
			maxParticles = 100,
			boxMin = {0.0, 0.0, 0.0},
			boxMax = {0.0, 0.0, 0.0},
			sprayAngle = {0,360},
			velocity = {0.1,0.1},
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {1,1},
			color0 = {0.25, 0.25, 0.25},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.9,
			size = {0.4, 0.6},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 1,
			blendMode = "Translucent",
		},
	}
}

defineParticleSystem{
	name = "fireball_noTrail",
	emitters = {
		-- flames
		{
			emissionRate = 50,
			emissionTime = 0,
			maxParticles = 50,
			boxMin = {-0.0, -0.0, 0.0},
			boxMax = { 0.0, 0.0,  -0.0},
			sprayAngle = {0,360},
			velocity = {0.3, 0.3},
			texture = "assets/textures/particles/torch_flame.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 16,
			lifetime = {0.8, 0.8},
			colorAnimation = true,
			color0 = {2, 2, 2},
			color1 = {1.0, 1.0, 1.0},
			color2 = {1.0, 0.5, 0.25},
			color3 = {1.0, 0.3, 0.1},
			opacity = 1,
			fadeIn = 0.15,
			fadeOut = 0.3,
			size = {0.125, 0.25},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 1,
			blendMode = "Additive",
			objectSpace = true,
		},

		-- flame trail
		{
			emissionRate = 80,
			emissionTime = 0,
			maxParticles = 100,
			boxMin = {0.0, 0.0, 0.0},
			boxMax = {0.0, 0.0, 0.0},
			sprayAngle = {0,360},
			velocity = {0.1, 0.3},
			texture = "assets/textures/particles/torch_flame.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 16,
			lifetime = {0.2, 0.3},
			colorAnimation = true,
			color0 = {2, 2, 2},
			color1 = {1.0, 1.0, 1.0},
			color2 = {1.0, 0.5, 0.25},
			color3 = {1.0, 0.3, 0.1},
			opacity = 1,
			fadeIn = 0.15,
			fadeOut = 0.3,
			size = {0.1, 0.3},
			gravity = {0,0,0},
			airResistance = 1.0,
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
			lifetime = {1000000, 1000000},
			colorAnimation = false,
			color0 = {0.3, 0.13, 0.06},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {1.5, 1.5},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
			objectSpace = true,
		}
	}
}

defineParticleSystem{
	name = "fireball_greater_noTrail",
	emitters = {

		-- flames
		{
			emissionRate = 100,
			emissionTime = 0,
			maxParticles = 100,
			boxMin = {-0.03, -0.03, 0.03},
			boxMax = { 0.03, 0.03,  -0.03},
			sprayAngle = {0,360},
			velocity = {0.5, 0.7},
			texture = "assets/textures/particles/torch_flame.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 16,
			lifetime = {0.8, 0.8},
			colorAnimation = true,
			color0 = {2, 2, 2},
			color1 = {1.0, 1.0, 1.0},
			color2 = {1.0, 0.5, 0.25},
			color3 = {1.0, 0.3, 0.1},
			opacity = 1,
			fadeIn = 0.15,
			fadeOut = 0.3,
			size = {0.25, 0.35},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 1,
			blendMode = "Additive",
			objectSpace = true,
		},

		-- flame trail
		{
			emissionRate = 80,
			emissionTime = 0,
			maxParticles = 100,
			boxMin = {0.0, 0.0, 0.0},
			boxMax = {0.0, 0.0, 0.0},
			sprayAngle = {0,360},
			velocity = {0.1, 0.3},
			texture = "assets/textures/particles/torch_flame.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 16,
			lifetime = {0.2, 0.3},
			colorAnimation = true,
			color0 = {2, 2, 2},
			color1 = {1.0, 1.0, 1.0},
			color2 = {1.0, 0.5, 0.25},
			color3 = {1.0, 0.3, 0.1},
			opacity = 1,
			fadeIn = 0.15,
			fadeOut = 0.3,
			size = {0.2, 0.5},
			gravity = {0,0,0},
			airResistance = 1.0,
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
			lifetime = {1000000, 1000000},
			colorAnimation = false,
			color0 = {0.3, 0.13, 0.06},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {1.5, 1.5},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
			objectSpace = true,
		}
	}
}

defineParticleSystem{
	name = "noParticleSystem",
	emitters = {
	}
}

defineSound{
	name = "silence",
	filename = "assets/samples/magic/blob_01.wav",
	loop = false,
	volume = 0.0,
	minDistance = 1,
	maxDistance = 10,
}

-- ****** Define Spell Objects ******

cloneObject{
	name = "fireball",
	baseObject = "fireball",
	launchSound = "silence",
}

cloneObject{
	name = "fireball_greater",
	baseObject = "fireball_greater",
	launchSound = "silence",
}

cloneObject{
	name = "lightning_bolt",
	baseObject = "lightning_bolt",
	launchSound = "silence",
}

cloneObject{
	name = "lightning_bolt_greater",
	baseObject = "lightning_bolt",
	launchSound = "silence",
}

cloneObject{
	name = "poison_bolt",
	baseObject = "poison_bolt",
	launchSound = "silence",
}

cloneObject{
	name = "poison_bolt_greater",
	baseObject = "poison_bolt_greater",
	launchSound = "silence",
}

cloneObject{
	name = "frostbolt",
	baseObject = "frostbolt",
	launchSound = "silence",
}

cloneObject{
	name = "improved_frostbolt",
	baseObject = "improved_frostbolt",
	launchSound = "silence",
}

for i = 1, 50 do
	cloneObject{
	  name = "exsp_freezeHelper_"..i,
	  baseObject = "frostbolt",
	  launchSound = "silence",
	  particleSystem = "frostbolt",
	  hitParticleEffect = "noParticleSystem",
	  lightColor = vec(0, 0, 0),
	  lightBrightness = 0,
	  lightRange = 0,
	  lightHitBrightness = 0,
	  lightHitRange = 0,
	  launchSound = "silence",
	  projectileSound = "silence",
	  hitSound = "silence",
	  projectileSpeed = 5,
	  attackPower = 1,
	  damageType = "cold",
	  freezeChance = 100,
	  freezeDuration = i,
	  tags = { "spell" },
	}
end

-- ****** Define spells ******

defineSpell{ 
	name = "fireburst",
	uiName = "Fireburst",
	skill = "fire_magic",
	level = 2,
	runes = "A",
	manaCost = 15,
	onCast = function(caster,x,y,direction,skill)
		return exsp:spellCast("fireburst", caster)
	end,
}

defineSpell{
	name = "shock",
	uiName = "Shock",
	skill = "air_magic",
	level = 4,
	runes = "C",
	manaCost = 21,
	onCast = function(caster,x,y,direction,skill)
		return exsp:spellCast("shock", caster)
	end,
}

-- ****** Define script functions ******

fw_addModule("exsp_default_log_spells",[[

exsp:defineSpell("fireburst",{
	-- Basic properties
	spawnObject = "fireburst",
	attackPower = 20,
	damageType = "fire",
	burst = true,
	
	-- Particle Systems
	particleSystem = "fireburst",
	screenEffect = "fireball_screen",
	
	-- Light properties
	lightColor = {0.75, 0.4, 0.25},
	lightBrightness = 40,
	lightRange = 4,
	
	-- Sounds
	sound = "fireburst",
	}
)

exsp:defineSpell("fireball",{
	-- Basic properties
	spawnObject = "fireball",
	projectileSpeed = 7.5,
	attackPower = 30,
	damageType = "fire",
	
	-- Particle Systems
	particleSystem = "fireball",
	hitParticleEffect = "fireball_hit",
	particleSystemNoTrail = "fireball_noTrail",
	particleSystemTrail = "fireball_trail",
	screenEffect = "fireball_screen",
	
	-- Light properties
	lightColor = {1, 0.5, 0.25},
	lightBrightness = 15,
	lightRange = 7,
	lightHitBrightness = 40,
	lightHitRange = 10,
	castShadow = true,
	
	-- Sounds
	launchSound = "fireball_launch",
	projectileSound = "fireball",
	hitSound = "fireball_hit",
	}
)

exsp:defineSpell("fireball_greater",{
	-- Basic properties
	spawnObject = "fireball_greater",
	projectileSpeed = 7.5,
	attackPower = 30,
	damageType = "fire",
	
	-- Particle Systems
	particleSystem = "fireball_greater",
	hitParticleEffect = "fireball_hit_greater",
	particleSystemNoTrail = "fireball_greater_noTrail",
	particleSystemTrail = "fireball_trail",
	screenEffect = "fireball_screen",
	
	-- Light properties
	lightColor = {1, 0.5, 0.25},
	lightBrightness = 15,
	lightRange = 7,
	lightHitBrightness = 40,
	lightHitRange = 10,
	castShadow = true,
	
	-- Sounds
	launchSound = "fireball_launch",
	projectileSound = "fireball",
	hitSound = "fireball_hit",
	}
)

exsp:defineSpell("shock",{
	-- Basic properties
	spawnObject = "shockburst",
	attackPower = 27,
	damageType = "shock",
	burst = true,
	
	-- Particle Systems
	particleSystem = "shockburst",
	
	-- Light properties
	lightColor = {0.25, 0.5, 1},
	lightBrightness = 40,
	lightRange = 4,
	
	-- Sounds
	sound = "shockburst",
	}
)

exsp:defineSpell("lightning_bolt",{
	-- Basic properties
	spawnObject = "lightning_bolt",
	projectileSpeed = 10,
	attackPower = 35,
	damageType = "shock",
	
	-- Particle Systems
	particleSystem = "lightning_bolt",
	hitParticleEffect = "lightning_bolt_hit",
			
	-- Light properties
	lightColor = {0.25, 0.5, 1},
	lightBrightness = 15,
	lightRange = 7,
	lightHitBrightness = 40,
	lightHitRange = 10,
	castShadow = true,
	
	-- Sounds
	launchSound = "lightning_bolt_launch",
	projectileSound = "lightning_bolt",
	hitSound = "lightning_bolt_hit_small",
	}
)

exsp:defineSpell("lightning_bolt_greater",{
	-- Basic properties
	spawnObject = "lightning_bolt_greater",
	projectileSpeed = 10,
	attackPower = 47,
	damageType = "shock",
	
	-- Particle Systems
	particleSystem = "lightning_bolt_greater",
	hitParticleEffect = "lightning_bolt_hit_greater",
			
	-- Light properties
	lightColor = {0.25, 0.5, 1},
	lightBrightness = 15,
	lightRange = 7,
	lightHitBrightness = 40,
	lightHitRange = 10,
	castShadow = true,
	
	-- Sounds
	launchSound = "lightning_bolt_launch",
	projectileSound = "lightning_bolt",
	hitSound = "lightning_bolt_hit_small",
	}
)

exsp:defineSpell("poison_bolt",{
	-- Basic properties
	spawnObject = "poison_bolt",
	projectileSpeed = 7.5,
	attackPower = 20,
	damageType = "poison",
	
	-- Particle Systems
	particleSystem = "poison_bolt",
	hitParticleEffect = "poison_bolt_hit",
	screenEffect = "poison_bolt_screen",
	
	-- Light properties
	lightColor = {0.25, 0.6, 0.2},
	lightBrightness = 4,
	lightRange = 4,
	lightHitBrightness = 4,
	lightHitRange = 5,
	castShadow = false,
	
	-- Sounds
	launchSound = "poison_bolt_launch",
	projectileSound = "poison_bolt",
	hitSound = "poison_bolt_hit",
	}
)

exsp:defineSpell("poison_bolt_greater",{
	-- Basic properties
	spawnObject = "poison_bolt_greater",
	projectileSpeed = 7.5,
	attackPower = 35,
	damageType = "poison",
	
	-- Particle Systems
	particleSystem = "poison_bolt",
	hitParticleEffect = "poison_bolt_hit",
	screenEffect = "poison_bolt_screen",
	
	-- Light properties
	lightColor = {0.25, 0.6, 0.2},
	lightBrightness = 4,
	lightRange = 4,
	lightHitBrightness = 4,
	lightHitRange = 5,
	castShadow = false,
	
	-- Sounds
	launchSound = "poison_bolt_launch",
	projectileSound = "poison_bolt",
	hitSound = "poison_bolt_hit",
	}
)

exsp:defineSpell("frostbolt",{
	-- Basic properties
	spawnObject = "frostbolt",
	projectileSpeed = 7.5,
	attackPower = 10,
	damageType = "cold",
	
	-- Particle Systems
	particleSystem = "frostbolt",
	hitParticleEffect = "frostbolt_hit",
	
	-- Light properties
	lightColor = {0.25, 0.5, 1},
	lightBrightness = 15,
	lightRange = 7,
	lightHitBrightness = 40,
	lightHitRange = 10,
	castShadow = false,
	
	-- Sounds
	launchSound = "frostbolt_launch",
	projectileSound = "frostbolt",
	hitSound = "frostbolt_hit",
	}
)

exsp:defineSpell("improved_frostbolt",{
	-- Basic properties
	spawnObject = "improved_frostbolt",
	projectileSpeed = 7.5,
	attackPower = 15,
	damageType = "cold",
	
	-- Particle Systems
	particleSystem = "frostbolt",
	hitParticleEffect = "frostbolt_hit",
	
	-- Light properties
	lightColor = {0.25, 0.5, 1},
	lightBrightness = 15,
	lightRange = 7,
	lightHitBrightness = 40,
	lightHitRange = 10,
	castShadow = false,
	
	-- Sounds
	launchSound = "frostbolt_launch",
	projectileSound = "frostbolt",
	hitSound = "frostbolt_hit",
	}
)

exsp:defineSpell("blob",{
	projectileSpeed = 7.5,
	spawnObject = "blob",
	damageType = "none",
	
	-- Particle Systems
	particleSystem = "blob",
	hitParticleEffect = "blob_hit",
	vOffset = 1.15,
	
	-- Light properties
	lightColor = {1, 1, 1},
	lightBrightness = 15,
	lightRange = 7,
	lightHitBrightness = 40,
	lightHitRange = 10,
	castShadow = false,
	}
)

exsp:defineSpell("ice_shards",{
	spawnObject = "ice_shards",
	attackPower = 20,
	damageType = "cold",
	}
)

]])