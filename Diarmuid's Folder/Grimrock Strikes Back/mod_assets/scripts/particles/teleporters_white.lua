-- | ************************************************************ |
-- | * Particles & Teleporters by LordYig
-- | * Version : 1.0
-- | ************************************************************ |
-- | * Teleporters White Definition

defineParticleSystem{
	name = "teleporter_white_01",
	emitters = {
		-- stars
		{
			emissionRate = 200,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = {-1.5,-0.5,-1.5},
			boxMax = { 1.5, 2.5, 1.5},
			sprayAngle = {0,30},
			velocity = {0.5,1.5},
			objectSpace = true,
			texture = "mod_assets/textures/particles/particle_white_10.tga",
			lifetime = {1,1},
			color0 = {0.5,0.5,0.5},
			color1 = {1.0,1.0,1.0},
			color2 = {1.5,1.5,1.5},
			color3 = {1.75,1.75,1.75},
			colorAnimation=true,
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.1, 0.3},
			gravity = {0,-1,0},
			airResistance = 0.1,
			rotationSpeed = 2,
			blendMode = "Additive",
		},
		-- small stars
		{
			emissionRate = 300,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = {-1.5,-0.5,-1.5},
			boxMax = { 1.5, 2.5, 1.5},
			sprayAngle = {0,30},
			velocity = {0.5,1.0},
			objectSpace = true,
			texture = "mod_assets/textures/particles/particle_white_17.tga",
			lifetime = {1,1},
			color0 = {0.25,0.25,0.25},
			color1 = {0.5,0.5,0.5},
			color2 = {0.75,0.75,0.75},
			color3 = {1.0,1.0,1.0},
			colorAnimation=true,
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.05, 0.1},
			gravity = {0,-0.5,0},
			airResistance = 0.1,
			rotationSpeed = 2,
			blendMode = "Additive",
		},
		-- fog
		{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = {-1.5, 0.0,-1.5},
			boxMax = { 1.5, 3.0, 1.5},
			sprayAngle = {0,360},
			velocity = {0.1,1},
			objectSpace = true,
			texture = "assets/textures/particles/fog.tga",
			lifetime = {3,3},
			color0 = {0.1, 0.1, 0.1},
			opacity = 1,
			fadeIn = 2,
			fadeOut = 2,
			size = {2, 2},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 0.3,
			blendMode = "Additive",
		}
	}
}

defineParticleSystem{
	name = "teleporter_white_02",
	emitters = {
		-- stars
		{
			emissionRate = 200,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = {-1.5,-0.5,-1.5},
			boxMax = { 1.5, 2.5, 1.5},
			sprayAngle = {0,0},
			velocity = {0.5,1.5},
			objectSpace = true,
			texture = "mod_assets/textures/particles/particle_white_10.tga",
			lifetime = {1,1},
			color0 = {0.5,0.5,0.5},
			color1 = {1.0,1.0,1.0},
			color2 = {1.5,1.5,1.5},
			color3 = {1.75,1.75,1.75},
			colorAnimation=true,
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.1, 0.3},
			gravity = {0,-1,0},
			airResistance = 0.1,
			rotationSpeed = 2,
			blendMode = "Additive",
		},
		-- small stars
		{
			emissionRate = 300,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = {-1.5,-0.5,-1.5},
			boxMax = { 1.5, 2.5, 1.5},
			sprayAngle = {0,0},
			velocity = {0.5,1},
			objectSpace = true,
			texture = "mod_assets/textures/particles/particle_white_17.tga",
			lifetime = {1,1},
			color0 = {0.25,0.25,0.25},
			color1 = {0.5,0.5,0.5},
			color2 = {0.75,0.75,0.75},
			color3 = {1.0,1.0,1.0},
			colorAnimation=true,
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.05, 0.1},
			gravity = {0,-0.5,0},
			airResistance = 0.1,
			rotationSpeed = 2,
			blendMode = "Additive",
		},
		-- fog
		{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = {-1.5, 0.0,-1.5},
			boxMax = { 1.5, 3.0, 1.5},
			sprayAngle = {0,360},
			velocity = {0.1,1},
			objectSpace = true,
			texture = "assets/textures/particles/fog.tga",
			lifetime = {3,3},
			color0 = {0.1, 0.1, 0.1},
			opacity = 1,
			fadeIn = 2,
			fadeOut = 2,
			size = {2, 2},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 0.3,
			blendMode = "Additive",
		}
	}
}

defineParticleSystem{
	name = "teleporter_white_03",
	emitters = {
		-- stars
		{
			emissionRate = 200,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = {-1.5,-0.5,-1.5},
			boxMax = { 1.5, 3.0, 1.5},
			sprayAngle = {180,180},
			velocity = {0.5,1.5},
			objectSpace = true,
			texture = "mod_assets/textures/particles/particle_white_10.tga",
			lifetime = {1,1},
			color0 = {0.5,0.5,0.5},
			color1 = {1.0,1.0,1.0},
			color2 = {1.5,1.5,1.5},
			color3 = {1.75,1.75,1.75},
			colorAnimation=true,
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.1, 0.3},
			gravity = {0,1,0},
			airResistance = 0.1,
			rotationSpeed = 2,
			blendMode = "Additive",
		},
		-- small stars
		{
			emissionRate = 300,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = {-1.5,-0.5,-1.5},
			boxMax = { 1.5, 3.0, 1.5},
			sprayAngle = {180,180},
			velocity = {0.5,1},
			objectSpace = true,
			texture = "mod_assets/textures/particles/particle_white_17.tga",
			lifetime = {1,1},
			color0 = {0.25,0.25,0.25},
			color1 = {0.5,0.5,0.5},
			color2 = {0.75,0.75,0.75},
			color3 = {1.0,1.0,1.0},
			colorAnimation=true,
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.05, 0.1},
			gravity = {0,0.5,0},
			airResistance = 0.1,
			rotationSpeed = 2,
			blendMode = "Additive",
		},
		-- fog
		{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = {-1.5, 0.0,-1.5},
			boxMax = { 1.5, 3.0, 1.5},
			sprayAngle = {0,360},
			velocity = {0.1,1},
			objectSpace = true,
			texture = "assets/textures/particles/fog.tga",
			lifetime = {3,3},
			color0 = {0.1, 0.1, 0.1},
			opacity = 1,
			fadeIn = 2,
			fadeOut = 2,
			size = {2, 2},
			gravity = {0,0,0},
			airResistance = 0.1,
			rotationSpeed = 0.3,
			blendMode = "Additive",
		}
	}
}