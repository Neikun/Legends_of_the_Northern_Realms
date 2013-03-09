-- ***************************************************************************************
--                                       Define Materials
-- ***************************************************************************************

defineMaterial{
   name = "dx_skysphere_blue",
   diffuseMap = "mod_assets/dx_sky_system/dx_skysphere_blue.tga",
   specularMap = "assets/textures/common/black.tga",
   doubleSided = false,
   lighting = false,
   alphaTest = false,
   blendMode = "Additive",
   textureAddressMode = "Clamp",
   glossiness = 0,
   depthBias = 2,
}

defineMaterial{
   name = "dx_skysphere_grey",
   diffuseMap = "mod_assets/dx_sky_system/dx_skysphere_grey.tga",
   specularMap = "assets/textures/common/black.tga",
   doubleSided = false,
   lighting = false,
   alphaTest = false,
   blendMode = "Additive",
   textureAddressMode = "Clamp",
   glossiness = 0,
   depthBias = 2,
}

defineMaterial{
   name = "dx_clouds_01",
   diffuseMap = "mod_assets/dx_sky_system/dx_clouds_01.tga",
   specularMap = "assets/textures/common/black.tga",
   doubleSided = false,
   lighting = false,
   alphaTest = false,
   blendMode = "Additive",
   textureAddressMode = "Clamp",
   glossiness = 0,
   depthBias = 0.02,
}

defineMaterial{
   name = "dx_clouds_02",
   diffuseMap = "mod_assets/dx_sky_system/dx_clouds_02.tga",
   specularMap = "assets/textures/common/black.tga",
   doubleSided = false,
   lighting = false,
   alphaTest = false,
   blendMode = "Additive",
   textureAddressMode = "Clamp",
   glossiness = 0,
   depthBias = 0.01,
}

defineMaterial{
   name = "dx_clouds_grey",
   diffuseMap = "mod_assets/dx_sky_system/dx_clouds_grey.tga",
   specularMap = "assets/textures/common/black.tga",
   doubleSided = false,
   lighting = false,
   alphaTest = false,
   blendMode = "Additive",
   textureAddressMode = "Clamp",
   glossiness = 0,
   depthBias = 0.01,
}

defineMaterial{
   name = "dx_clouds_dark",
   diffuseMap = "mod_assets/dx_sky_system/dx_clouds_dark.tga",
   specularMap = "assets/textures/common/black.tga",
   doubleSided = false,
   lighting = false,
   alphaTest = false,
   blendMode = "Additive",
   textureAddressMode = "Clamp",
   glossiness = 0,
   depthBias = 0.01,
}
   
defineMaterial{
   name = "dx_skyblocker_black",
   diffuseMap = "assets/textures/common/black.tga",
   specularMap = "assets/textures/common/black.tga",
   doubleSided = true,
   lighting = false,
   alphaTest = false,
   blendMode = "Opaque",
   textureAddressMode = "Clamp",
   glossiness = 10,
   depthBias = 1,
}
   

defineMaterial{
	name = "dx_invisible",
	diffuseMap = "assets/textures/common/black.tga",
	doubleSided = false,
	lighting = false,
	alphaTest = true,
	blendMode = "Additive",
	textureAddressMode = "Wrap",
	glossiness = 0,
	depthBias = 0,
}
     
-- ***************************************************************************************
--                                       Define Objects
-- ***************************************************************************************
	 
defineObject{
   name = "dx_skysphere_blue",
   class = "Item",
   model = "mod_assets/dx_sky_system/dx_skysphere_blue.fbx",
   gfxIndex = 1,
   uiName = "SkySphere",
   castShadow = false,
   weight = 0.1,
   projectileRotationSpeed = 0,
}

defineObject{
   name = "dx_skysphere_grey",
   class = "Item",
   model = "mod_assets/dx_sky_system/dx_skysphere_grey.fbx",
   gfxIndex = 1,
   uiName = "SkySphere",
   castShadow = false,
   weight = 0.1,
   projectileRotationSpeed = 0,
}

defineObject{
   name = "dx_clouds_01",
   class = "Item",
   model = "mod_assets/dx_sky_system/dx_clouds_01.fbx",
   gfxIndex = 1,
   uiName = "SkySphere",
   castShadow = false,
   weight = 0.1,
   projectileRotationSpeed = 0.005,
   projectileRotationY = 1,
}

defineObject{
   name = "dx_clouds_grey",
   class = "Item",
   model = "mod_assets/dx_sky_system/dx_clouds_grey.fbx",
   gfxIndex = 1,
   uiName = "SkySphere",
   castShadow = false,
   weight = 0.1,
   projectileRotationSpeed = 0.005,
   projectileRotationY = 1,
}

defineObject{
   name = "dx_clouds_dark",
   class = "Item",
   model = "mod_assets/dx_sky_system/dx_clouds_dark.fbx",
   gfxIndex = 1,
   uiName = "SkySphere",
   castShadow = false,
   weight = 0.1,
   projectileRotationSpeed = 0.005,
   projectileRotationY = 1,
}

defineObject{
	name = "dx_skyblocker",
	class = "Decoration",
	model = "mod_assets/dx_sky_system/dx_skyblocker_black.fbx",
	placement = "wall",
	editorIcon = 120,
}

-- ***************************************************************************************
--                                       Define Particle Systems
-- ***************************************************************************************

   
defineParticleSystem{
	name = "dx_stars",
	emitters = {
		{
			spawnBurst = true,
			objectSpace = true,
			emissionRate = 400,
			emissionTime = 0,
			maxParticles = 400,
			boxMin = {-7.5, 0.0, -7.5},
			boxMax = { 7.5, 7.0, 7.5},
			sprayAngle = {0,0},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {100000,100000},
			color0 = {0.8,0.8,0.8},
			opacity = 1.0,
			fadeIn = 1,
			fadeOut = 4,
			size = {0.02, 0.05},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 0,
			blendMode = "Additive",
			depthBias = 0.02,
		},
		{
			spawnBurst = true,
			objectSpace = true,
			emissionRate = 30,
			emissionTime = 0,
			maxParticles = 30,
			boxMin = {-7.5, 0.0, -7.5},
			boxMax = { 7.5, 3.0, 7.5},
			sprayAngle = {0,0},
			velocity = {0,0},
			texture = "mod_assets/dx_sky_system/star_white.tga",
			lifetime = {100000,100000},
			color0 = {1,1,1},
			opacity = 1.0,
			fadeIn = 1,
			fadeOut = 4,
			size = {0.03, 0.08},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 0.4,
			blendMode = "Additive",
			depthBias = 0.02,
		},
		{
			spawnBurst = true,
			objectSpace = true,
			emissionRate = 30,
			emissionTime = 0,
			maxParticles = 30,
			boxMin = {-7.5, 0.0, -7.5},
			boxMax = { 7.5, 3.0, 7.5},
			sprayAngle = {0,0},
			velocity = {0,0},
			texture = "mod_assets/dx_sky_system/star_blue.tga",
			lifetime = {100000,100000},
			color0 = {0.3,0.3,1},
			opacity = 1.0,
			fadeIn = 1,
			fadeOut = 4,
			size = {0.03, 0.08},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 0.3,
			blendMode = "Additive",
			depthBias = 0.03,
		},
		{
			spawnBurst = true,
			objectSpace = true,
			emissionRate = 30,
			emissionTime = 0,
			maxParticles = 30,
			boxMin = {-7.5, 0.0, -7.5},
			boxMax = { 7.5, 3.0, 7.5},
			sprayAngle = {0,0},
			velocity = {0,0},
			texture = "mod_assets/dx_sky_system/star_pink.tga",
			lifetime = {100000,100000},
			color0 = {0.7,0,0.7},
			opacity = 1.0,
			fadeIn = 1,
			fadeOut = 4,
			size = {0.05, 0.08},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 0.5,
			blendMode = "Additive",
			depthBias = 0.03,
			
		},
	}
}

defineParticleSystem{
	name = "dx_dark_stars",
	emitters = {
		{
			spawnBurst = true,
			objectSpace = true,
			emissionRate = 400,
			emissionTime = 0,
			maxParticles = 400,
			boxMin = {-7.5, 0.0, -7.5},
			boxMax = { 7.5, 7.0, 7.5},
			sprayAngle = {0,0},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {100000,100000},
			color0 = {0.3,0.3,0.3},
			opacity = 1.0,
			fadeIn = 1,
			fadeOut = 4,
			size = {0.02, 0.05},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 0,
			blendMode = "Additive",
			depthBias = 0.02,
		},
	}
}
   
defineParticleSystem{
	name = "dx_sun",
	emitters = {
		{
			objectSpace = true,
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 10,
			boxMin = {0,0,0},
			boxMax = {0,0,0},
			sprayAngle = {0,0},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {100000,100000},
			color0 = {3,3,2},
			opacity = 0.7,
			fadeIn = 1,
			fadeOut = 4,
			size = {1.5, 1.5},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 0,
			blendMode = "Additive",
			depthBias = 0.01
		},

		{
			objectSpace = true,
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 10,
			boxMin = {0,0,0},
			boxMax = {0,0,0},
			sprayAngle = {0,0},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {100000,100000},
			color0 = {3,3,1},
			opacity = 0.05,
			fadeIn = 1,
			fadeOut = 4,
			size = {4.5, 4.5},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 0,
			blendMode = "Additive",
			depthBias = 0.01
		},
	}
}

defineParticleSystem{
	name = "dx_sun_clouds",
	emitters = {
		{
			objectSpace = true,
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 10,
			boxMin = {0,0,0},
			boxMax = {0,0,0},
			sprayAngle = {0,0},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {100000,100000},
			color0 = {3,3,2},
			opacity = 0.3,
			fadeIn = 1,
			fadeOut = 4,
			size = {1.5, 1.5},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 0,
			blendMode = "Additive",
			depthBias = 0.01
		},

		{
			objectSpace = true,
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 10,
			boxMin = {0,0,0},
			boxMax = {0,0,0},
			sprayAngle = {0,0},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {100000,100000},
			color0 = {3,3,1},
			opacity = 0.05,
			fadeIn = 1,
			fadeOut = 4,
			size = {5.5, 5.5},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 0,
			blendMode = "Additive",
			depthBias = 0.01
		},
	}
}

defineParticleSystem{
	name = "dx_rain",
	emitters = {
		-- rain
		{
		emissionRate = 150,
		emissionTime = 0,
		spawnBurst = false,
		maxParticles = 500,
		boxMin = {-1.3,5,-1.3},
		boxMax = {1.3,5,1.3},
		objectSpace = true,
		sprayAngle = {0,10},
		velocity = {0,0},
		texture = "assets/textures/particles/glitter_silver.tga",
		lifetime = {1000000, 1000000},
		colorAnimation = false,
		color0 = {1, 1, 1},
		opacity = 0.25,
		fadeIn = 0.4,
		fadeOut = 4.0,
		size = {0.05, 0.1},
		gravity = {0,-5,0},
		airResistance = 2,
		rotationSpeed = 1,
		blendMode = "Additive",
		},
		
		-- fog
		{
		emissionRate = 10,
		emissionTime = 0,
		spawnBurst = false,
		maxParticles = 20,
		boxMin = {-1.3,0,-1.3},
		boxMax = {1.3,5,1.3},
		objectSpace = true,
		sprayAngle = {0,10},
		velocity = {0,0},
		texture = "assets/textures/particles/fog.tga",
		lifetime = {1000000, 1000000},
		colorAnimation = false,
		color0 = {1, 1, 1},
		opacity = 0.02,
		fadeIn = 0.4,
		fadeOut = 4.0,
		size = {7, 7},
		gravity = {0,-1,0},
		airResistance = 2,
		rotationSpeed = 1,
		blendMode = "Additive",
		}
	}
}

defineParticleSystem{
	name = "dx_rain_2",
	emitters = {
		-- flames
		{
			emissionRate = 50,
			emissionTime = 0,
			maxParticles = 100,
			boxMin = {-0.03, -0.03, 0.03},
			boxMax = { 0.03, 0.03,  -0.03},
			sprayAngle = {0,10},
			velocity = {0.2, 1},
			texture = "mod_assets/dx_sky_system/dx_rain.tga",
			frameRate = 35,
			frameSize = 64,
			frameCount = 16,
			lifetime = {0.25, 0.85},
			colorAnimation = true,
			color0 = {2, 2, 2},
			color1 = {1.0, 1.0, 1.0},
			color2 = {1.0, 0.5, 0.25},
			color3 = {1.0, 0.3, 0.1},
			opacity = 1,
			fadeIn = 0.15,
			fadeOut = 0.3,
			size = {1, 1},
			gravity = {0,0,0},
			airResistance = 1.0,
			rotationSpeed = 1,
			blendMode = "Additive",
			depthBias = -0.002,
		},
	}
}

defineParticleSystem{
	name = "dx_none",
	emitters = {
	}
}

-- ***************************************************************************************
--                                     Test scrolls
-- ***************************************************************************************

defineObject{
	name = "scroll_day",
	class = "Item",
	uiName = "Scroll of Day Ambiance",
	model = "assets/models/items/scroll.fbx",
	gfxIndex = 112,
	scroll = true,
	weight = 0.3,
	onUseItem = function()
		skyScript.setAmbiance("day")
	end,
}

defineObject{
	name = "scroll_rainy_day",
	class = "Item",
	uiName = "Scroll of Rainy Day Ambiance",
	model = "assets/models/items/scroll.fbx",
	gfxIndex = 112,
	scroll = true,
	weight = 0.3,
	onUseItem = function()
		skyScript.setAmbiance("rainy_day")
	end,
}

defineObject{
	name = "scroll_night",
	class = "Item",
	uiName = "Scroll of Night Ambiance",
	model = "assets/models/items/scroll.fbx",
	gfxIndex = 112,
	scroll = true,
	weight = 0.3,
	onUseItem = function()
		skyScript.setAmbiance("night")
	end,
}

defineObject{
	name = "scroll_dark_night",
	class = "Item",
	uiName = "Scroll of Dark Night Ambiance",
	model = "assets/models/items/scroll.fbx",
	gfxIndex = 112,
	scroll = true,
	weight = 0.3,
	onUseItem = function()
		skyScript.setAmbiance("dark_night")
	end,
}

defineObject{
	name = "scroll_rainy_night",
	class = "Item",
	uiName = "Scroll of Rainy Night Ambiance",
	model = "assets/models/items/scroll.fbx",
	gfxIndex = 112,
	scroll = true,
	weight = 0.3,
	onUseItem = function()
		skyScript.setAmbiance("rainy_night")
	end,
}
