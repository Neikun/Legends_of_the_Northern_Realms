-- ***********************************************************************************
--                        Define main crystal object
-- ***********************************************************************************

cloneObject{
	name = "healing_crystal_green",
	baseObject = "script_entity",
	editorIcon = 60,
}

-- ***********************************************************************************
--                     Define crystal projectile objects
-- ***********************************************************************************

-- Main crystal, activated
defineObject{
	name = "_healing_crystal_green_main",
	class = "Item",
	model = "mod_assets/models/healing_crystal_green_main.fbx",
	gfxIndex = 1,
	uiName = "_healing_crystal_green_main",
	weight = 0.1,
	projectileRotationSpeed = 0.5,
	projectileRotationY = 1,
	fragile = true,
}

-- Main crystal, activated - shader additive version
defineObject{
	name = "_healing_crystal_green_main_additive",
	class = "Item",
	model = "mod_assets/models/healing_crystal_green_main_additive.fbx",
	gfxIndex = 1,
	uiName = "_healing_crystal_green_main",
	weight = 0.1,
	projectileRotationSpeed = -0.2,
	projectileRotationY = 1,
	fragile = true,
}

-- Main crystal, deactivated
defineObject{
	name = "_healing_crystal_green_main_deactivated",
	class = "Item",
	model = "mod_assets/models/healing_crystal_green_main.fbx",
	gfxIndex = 1,
	uiName = "_healing_crystal_green_main",
	weight = 0.1,
	projectileRotationSpeed = 0.1,
	projectileRotationY = 1,
	fragile = true,
}

-- Small crystals, activated
defineObject{
	name = "_healing_crystal_green_small",
	class = "Item",
	model = "mod_assets/models/healing_crystal_green_small.fbx",
	gfxIndex = 1,
	uiName = "_healing_crystal_green_main",
	weight = 0.1,
	projectileRotationSpeed = -0.6,
	projectileRotationY = 1,
	fragile = true,
}

-- Small crystals, deactivated
defineObject{
	name = "_healing_crystal_green_small_deactivated",
	class = "Item",
	model = "mod_assets/models/healing_crystal_green_small.fbx",
	gfxIndex = 1,
	uiName = "_healing_crystal_green_main",
	weight = 0.1,
	projectileRotationSpeed = -0.15,
	projectileRotationY = 1,
	fragile = true,
}

-- ***********************************************************************************
--                           Define crystal lightsources
-- ***********************************************************************************

-- Activated state lightsources
defineObject{
	name = "_healing_crystal_green_light",
	class = "LightSource",
	lightPosition = vec(1, 1.5, 1),
	lightRange = 10,
	lightColor = vec(0.5, 1, 0.5),
	brightness = 6,
	castShadow = false,
	flicker = false,
	placement = "floor",
	editorIcon = 88,
}

-- Dectivated state lightsources
defineObject{
	name = "_healing_crystal_green_light_deactivated",
	class = "LightSource",
	lightPosition = vec(1, 1.5, 1),
	lightRange = 5,
	lightColor = vec(0.5, 1, 0.5),
	brightness = 1,
	castShadow = false,
	flicker = false,
	placement = "floor",
	editorIcon = 88,
}
-- Particle system lightsource
defineObject{
	name = "_healing_crystal_green_particleSystem",
	class = "LightSource",
	particleSystem = "crystal_green",
	lightPosition = vec(0, 0, 0),
	lightRange = 0,
	lightColor = vec(1, 1, 1),
	brightness = 0,
	castShadow = false,
	flicker = false,
	placement = "floor",
	editorIcon = 88,
}

-- ***********************************************************************************
--                       Define crystal helper objects
-- ***********************************************************************************

defineObject{
	name = "_healing_crystal_altar",
	class = "Altar",
	model =  "mod_assets/models/sx_blocker.fbx",
	anchorPos = vec(0, 0, 0),
	targetPos = vec(0, 0, 0),
	targetSize = vec(1.5, 3, 1.5),
	placement = "floor",
	editorIcon = 52,
}

cloneObject{
	name = "_healing_crystal_fake_item",
	baseObject = "heavy_shield",
	model =  "mod_assets/models/healing_crystal_fake_item.fbx",	
}

-- ***********************************************************************************
--                      Define crystal particleSystems
-- ***********************************************************************************

defineParticleSystem{
	name = "crystal_green",
	emitters = {
		-- fog
		{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = {-0.5, 0.0,-0.5},
			boxMax = { 0.5, 2.5, 0.5},
			sprayAngle = {0,360},
			velocity = {0.1,0.2},
			objectSpace = true,
			texture = "assets/textures/particles/fog.tga",
			lifetime = {3,3},
			color0 = {0.14, 0.803922, 0.352941},
			opacity = 1,
			fadeIn = 2.2,
			fadeOut = 2.2,
			size = {1.5, 1.5},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 0.3,
			blendMode = "Additive",
		},

		-- stars
		{
			emissionRate = 200,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = {-0.6, 0.3,-0.6},
			boxMax = { 0.6, 2.5, 0.6},
			sprayAngle = {0,360},
			velocity = {0.2,0.2},
			objectSpace = true,
			texture = "assets/textures/particles/teleporter.tga",
			lifetime = {1,1},
			color0 = {1.0,4.0,1.0},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.05, 0.13},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 2,
			blendMode = "Additive",
		}
	}
}

-- ***********************************************************************************
--                          Define crystal materials
-- ***********************************************************************************

defineMaterial{
	name = "healing_crystal_green",
	diffuseMap = "mod_assets/textures/nightfall_soul_green.tga",
	specularMap = "assets/textures/env/healing_crystal_spec.tga",
	normalMap = "assets/textures/env/healing_crystal_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 50,
	depthBias = 0,
}

defineMaterial{
	name = "healing_crystal_green_additive",
	diffuseMap = "mod_assets/textures/nightfall_soul_green_additive.tga",
	specularMap = "assets/textures/env/healing_crystal_spec.tga",
	normalMap = "assets/textures/env/healing_crystal_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = true,
	blendMode = "Additive",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,
}

defineMaterial{
	name = "sx_invisible",
	diffuseMap = "assets/textures/common/black.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = true,
	blendMode = "Additive",
	textureAddressMode = "Wrap",
	glossiness = 5,
	depthBias = 0,
}

