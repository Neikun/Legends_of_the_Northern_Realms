
-- Water Assets

defineObject{
	name = "sx_flooded",
	class = "LightSource",
	lightPosition = vec(0, 0.4, 0),
	lightRange = 0,
	 lightColor = vec(1, 1, 1),
	brightness = 1,
	castShadow = false,
	model = "mod_assets/models/sx_flooded.fbx",
	placement = "floor",
	particleSystem = "waterflow",
	particleSystemNode = "MainObject",
	replacesFloor = false,
	editorIcon = 136,
}

defineObject{
	name = "sx_flooded_static",
	class = "LightSource",
	lightPosition = vec(0, 0.4, 0),
	lightRange = 0,
	 lightColor = vec(1, 1, 1),
	brightness = 1,
	castShadow = false,
	model = "mod_assets/models/sx_flooded.fbx",
	placement = "floor",
	particleSystem = "waterstatic",
	particleSystemNode = "MainObject",
	replacesFloor = false,
	editorIcon = 136,
}

defineObject{
	name = "sx_flooded_fall",
	class = "LightSource",
	lightPosition = vec(0, 0.4, 0),
	lightRange = 0,
	 lightColor = vec(1, 1, 1),
	brightness = 1,
	castShadow = false,
	model = "mod_assets/models/sx_flooded.fbx",
	placement = "floor",
	particleSystem = "waterfall",
	particleSystemNode = "MainObject",
	replacesFloor = false,
	editorIcon = 136,
}

defineParticleSystem{
 name = "waterflow",
 emitters = {

 {
 emissionRate = 1000,
 emissionTime = 0,
 spawnBurst = false,
 maxParticles =1000,
 boxMin = {-1.3,-1,-1.3},
 boxMax = {1.3,0,1.3},
 objectSpace = true,
 sprayAngle = {0,1},
 velocity = {0,0},
 texture = "assets/textures/particles/glitter_silver.tga",
 lifetime = {100000, 100000},
 colorAnimation = false,
 color0 = {1, 1, 1},
 opacity = 0.7,
 fadeIn = 0.4,
 fadeOut = 2.5,
 size = {0.05, 0.1},
 gravity = {10,0,0},
 airResistance = 1,
 rotationSpeed = 8,
 blendMode = "Additive",
 }
 }
}

defineParticleSystem{
 name = "waterstatic",
 emitters = {

 {
 emissionRate = 1000,
 emissionTime = 0,
 spawnBurst = false,
 maxParticles =300,
 boxMin = {-1.3,-1,-1.3},
 boxMax = {1.3,0,1.3},
 objectSpace = true,
 sprayAngle = {0,1},
 velocity = {0,0},
 texture = "assets/textures/particles/glitter_silver.tga",
 lifetime = {100000, 100000},
 colorAnimation = false,
 color0 = {1, 1, 1},
 opacity = 0.7,
 fadeIn = 0.4,
 fadeOut = 2.5,
 size = {0.05, 0.1},
 gravity = {0,0,0},
 airResistance = 1,
 rotationSpeed = 8,
 blendMode = "Additive",
 }
 }
}

defineParticleSystem{
 name = "waterfall",
 emitters = {

 {
 emissionRate = 3000,
 emissionTime = 0,
 spawnBurst = false,
 maxParticles =5000,
 boxMin = {-1.3,-1,-1.3},
 boxMax = {1.3,5,1.3},
 objectSpace = true,
 sprayAngle = {0,1},
 velocity = {0,0},
 texture = "assets/textures/particles/glitter_silver.tga",
 lifetime = {100000, 100000},
 colorAnimation = false,
 color0 = {1, 1, 1},
 opacity = 0.7,
 fadeIn = 0.4,
 fadeOut = 2.5,
 size = {0.05, 0.1},
 gravity = {0,-20,0},
 airResistance = 1,
 rotationSpeed = 8,
 blendMode = "Additive",
 }
 }
}

defineObject{
	name = "sx_water_spray",
	class = "LightSource",
	lightPosition = vec(0, 0, 0),
	lightRange = 0,
	lightColor = vec(0.25, 0.25, 0.25),
	brightness = 1,
	castShadow = false,
	particleSystem = "waterspray",
	placement = "floor",
	editorIcon = 88,
}

defineParticleSystem{
	name = "waterspray",
	emitters = {
	
		-- waterspay effect
		{
			emissionRate = 1.5,
			emissionTime = 0,
			maxParticles = 100,
			boxMin = {-1, 0.1, -1},
			boxMax = { 1, 0.1,  1},
			sprayAngle = {0,30},
			velocity = {0,0},
			texture = "assets/textures/particles/smoke_01.tga",
			lifetime = {10,20},
			color0 = {1, 1, 1},
			opacity = 0.2,
			fadeIn = 2,
			fadeOut = 4,
			size = {2, 4},
			gravity = {0,1,0},
			airResistance = 0.1,
			rotationSpeed = 0.05,
			blendMode = "Translucent",
			objectSpace = false,
		}
	}
}

--Breakable Walls

defineObject{
	name = "sx_dungeon_breakable_wall",
	class = "Blockage",
	model = "mod_assets/models/sx_dungeon_breakable_wall.fbx",
	brokenModel = "mod_assets/models/sx_dungeon_breakable_wall_broken.fbx",
	placement = "floor",
	health = 30,
	evasion = -1000,
	hitSound = "impact_blade",
	hitEffect = "hit_wood",
	editorIcon = 56,
	onDie = function(self) 
		party:shakeCamera(0.5,0.5)
		playSound("dungeon_breakable_wall")
	end,
}

defineObject{
	name = "sx_dungeon_breakable_wall_hard",
	class = "Blockage",
	model = "mod_assets/models/sx_dungeon_breakable_wall_hard.fbx",
	brokenModel = "mod_assets/models/sx_dungeon_breakable_wall_broken.fbx",
	placement = "floor",
	health = 30,
	evasion = -1000,
	hitSound = "impact_blade",
	hitEffect = "hit_wood",
	editorIcon = 56,
	onDie = function(self) 
		party:shakeCamera(0.5,0.5)
		playSound("dungeon_breakable_wall")
	end,
}

-- Sounds

defineSound{
       name = "dungeon_breakable_wall",
       filename = "mod_assets/sounds/sx_wallbreaking.wav",
       loop = false,
       volume = 1,
       minDistance = 1,
       maxDistance = 6,
}

defineSound{
       name = "sx_stream",
       filename = "mod_assets/sounds/sx_stream.wav",
       loop = true,
       volume = 1,
       minDistance = 1,
       maxDistance = 8,
}

defineSound{
       name = "sx_waterfall",
       filename = "mod_assets/sounds/sx_waterfall.wav",
       loop = true,
       volume = 4,
       minDistance = 2,
       maxDistance = 15,
}
	

-- Materials

defineMaterial{
	name = "sx_water",
	diffuseMap = "mod_assets/textures/sx_water_dif.tga",
	specularMap = "mod_assets/textures/sx_water_spec.tga",
	normalMap = "mod_assets/textures/sx_water_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = true,
	blendMode = "Translucent",
	textureAddressMode = "Wrap",
	glossiness = 1,
	depthBias = 0,
}