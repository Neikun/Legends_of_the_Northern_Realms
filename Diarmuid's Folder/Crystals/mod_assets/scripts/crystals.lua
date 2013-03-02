function defineCrystal(defs)

	-- ***********************************************************************************
	--                         Define main crystal object
	-- ***********************************************************************************

	cloneObject{
		name = "dx_healing_crystal_object_"..defs.color,
		baseObject = "script_entity",
		editorIcon = 60,
	}
	
	if defs.defineGlassVersion then
	
		cloneObject{
			name = "dx_healing_crystal_object_glass_"..defs.color,
			baseObject = "script_entity",
			editorIcon = 60,
		}
	
	end

	-- ***********************************************************************************
	--                     Define crystal projectile objects
	-- ***********************************************************************************

	-- Crystal, activated
	defineObject{
		name = "_dx_healing_crystal_"..defs.color,
		class = "Pit",
		model = "mod_assets/models/crystals/dx_healing_crystal_floor.fbx",
		trapDoorModel = "mod_assets/models/crystals/dx_healing_crystal_"..defs.color..".fbx",		
		openAnim = "assets/animations/env/healing_crystal_spin.fbx",
		closeAnim = "assets/animations/env/healing_crystal_spin.fbx",
		placement = "floor",
		editorIcon = 60,
	}

	-- Crystal, deactivated
	defineObject{
		name = "_dx_healing_crystal_deactivated_"..defs.color,
		class = "Pit",
		model = "mod_assets/models/crystals/dx_healing_crystal_floor.fbx",
		trapDoorModel = "mod_assets/models/crystals/dx_healing_crystal_"..defs.color..".fbx",		
		openAnim = "mod_assets/animations/crystals/healing_crystal_spin_slow.fbx",
		closeAnim = "mod_assets/animations/crystals/healing_crystal_spin_slow.fbx",
		placement = "floor",
		editorIcon = 60,
	}
	
	if defs.defineGlassVersion then
	
		-- Glass Crystal, activated
		cloneObject{
			name = "_dx_healing_crystal_glass_"..defs.color,
			baseObject = "_dx_healing_crystal_"..defs.color,
			trapDoorModel = "mod_assets/models/crystals/dx_healing_crystal_glass_"..defs.color..".fbx",		
		}

		-- Glass Crystal, deactivated
		cloneObject{
			name = "_dx_healing_crystal_deactivated_glass_"..defs.color,
			baseObject = "_dx_healing_crystal_deactivated_"..defs.color,
			trapDoorModel = "mod_assets/models/crystals/dx_healing_crystal_glass_"..defs.color..".fbx",		
		}
	
	end
	
	-- Projectile shader
	defineObject{
		name = "_dx_healing_crystal_shader_"..defs.color,
		class = "Item",
		model = "mod_assets/models/crystals/dx_healing_crystal_shader_"..defs.color..".fbx",
		gfxIndex = 1,
		uiName = "dx_healing_crystal_additive",
		weight = 0.1,
		projectileRotationSpeed = -0.2,
		projectileRotationY = 1,
		fragile = true,
	}

	-- ***********************************************************************************
	--                           Define crystal lightsources
	-- ***********************************************************************************

	-- Activated state lightsources
	defineObject{
		name = "_dx_healing_crystal_light_"..defs.color,
		class = "LightSource",
		lightPosition = vec(1, 1.5, 1),
		lightRange = 6.5,
		lightColor = vec(defs.lightColor[1], defs.lightColor[2], defs.lightColor[3]),
		brightness = 3,
		castShadow = false,
		flicker = true,
		placement = "floor",
		editorIcon = 88,
	}

	-- Activated state top lightsource
	defineObject{
		name = "_dx_healing_crystal_top_light_"..defs.color,
		class = "LightSource",
		lightPosition = vec(0, 3, 0),
		lightRange = 6.5,
		lightColor = vec(defs.lightColor[1], defs.lightColor[2], defs.lightColor[3]),
		brightness = 3,
		castShadow = false,
		flicker = true,
		placement = "floor",
		editorIcon = 88,
	}
	
	-- Activated state bottom lightsource
	defineObject{
		name = "_dx_healing_crystal_bottom_light_"..defs.color,
		class = "LightSource",
		lightPosition = vec(0, 0.3, 0),
		lightRange = 6.5,
		lightColor = vec(defs.lightColor[1], defs.lightColor[2], defs.lightColor[3]),
		brightness = 3,
		castShadow = false,
		flicker = true,
		placement = "floor",
		editorIcon = 88,
	}
	
	-- Dectivated state lightsources
	defineObject{
		name = "_dx_healing_crystal_light_deactivated_"..defs.color,
		class = "LightSource",
		lightPosition = vec(1, 1.5, 1),
		lightRange = 6.5,
		lightColor = vec(defs.lightColor[1], defs.lightColor[2], defs.lightColor[3]),
		brightness = 1,
		castShadow = false,
		flicker = false,
		placement = "floor",
		editorIcon = 88,
	}
	
	-- Particle system lightsource
	defineObject{
		name = "_dx_healing_crystal_particleSystem_"..defs.color,
		class = "LightSource",
		particleSystem = "dx_healing_crystal_"..defs.color,
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
	--                      Define crystal particleSystems
	-- ***********************************************************************************

	defineParticleSystem{
		name = "dx_healing_crystal_"..defs.color,
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
				color0 = defs.particleFogColor,
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
				color0 = defs.particleStarsColor,
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
	
		defineParticleSystem{
		name = "dx_healing_crystal_fade_"..defs.color,
		emitters = {
			-- fog
			{
				spawnBurst = true,
				emissionRate = 10,
				emissionTime = 0,
				maxParticles = 25,
				boxMin = {-0.5, 0.0,-0.5},
				boxMax = { 0.5, 2.5, 0.5},
				sprayAngle = {0,360},
				velocity = {0.1,0.2},
				objectSpace = true,
				texture = "assets/textures/particles/fog.tga",
				lifetime = {3,3},
				color0 = defs.particleFogColor,
				opacity = 1,
				fadeIn = 2.2,
				fadeOut = 4.2,
				size = {1.5, 1.5},
				gravity = {0,0,0},
				airResistance = 0.1,
				rotationSpeed = 0.3,
				blendMode = "Additive",
			},

			-- stars
			{
				spawnBurst = true,
				emissionRate = 200,
				emissionTime = 0,
				maxParticles = 400,
				boxMin = {-0.6, 0.3,-0.6},
				boxMax = { 0.6, 2.5, 0.6},
				sprayAngle = {0,360},
				velocity = {0.2,0.2},
				objectSpace = true,
				texture = "assets/textures/particles/teleporter.tga",
				lifetime = {1,3},
				color0 = defs.particleStarsColor,
				opacity = 1,
				fadeIn = 0,
				fadeOut = 5,
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
		name = "dx_healing_crystal_"..defs.color,
		diffuseMap = "mod_assets/textures/crystals/dx_healing_crystal_"..defs.color..".tga",
		specularMap = "mod_assets/textures/crystals/dx_healing_crystal_spec.tga",
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
		name = "dx_healing_crystal_shader_"..defs.color,
		diffuseMap = "mod_assets/textures/crystals/dx_healing_crystal_shader_"..defs.color..".tga",
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
	
	if defs.defineGlassVersion then
	
		defineMaterial{
			name = "dx_healing_crystal_glass_"..defs.color,
			diffuseMap = "mod_assets/textures/crystals/dx_healing_crystal_glass_"..defs.color..".tga",
			specularMap = "mod_assets/textures/crystals/dx_healing_crystal_spec.tga",
			normalMap = "assets/textures/env/healing_crystal_normal.tga",
			doubleSided = false,
			lighting = false,
			alphaTest = false,
			blendMode = "Additive",
			textureAddressMode = "Wrap",
			glossiness = 50,
			depthBias = 0,
		}

	end
	
end


-- ***********************************************************************************
--                       Define crystal helper objects & materials
-- ***********************************************************************************

defineObject{
	name = "_dx_healing_crystal_altar",
	class = "Altar",
	model =  "mod_assets/models/crystals/dx_healing_crystal_altar.fbx",
	anchorPos = vec(0, 0, 0),
	targetPos = vec(0, 0, 0),
	targetSize = vec(1.5, 3, 1.5),
	placement = "floor",
	editorIcon = 52,
	onInsertItem = function (self,item)
		crystalHandler.cancelAltar(self,item)
	end
}

cloneObject{
	name = "_dx_healing_crystal_fake_item",
	baseObject = "heavy_shield",
	model = "mod_assets/models/crystals/dx_healing_crystal_fake_item.fbx",	
}

cloneObject{
	name = "_dx_healing_crystal_grating",
	baseObject = "dungeon_wall_grating",
	model = "mod_assets/models/crystals/dx_healing_crystal_grating.fbx",	
}

defineMaterial{
	name = "dx_invisible",
	diffuseMap = "assets/textures/common/black.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = true,
	blendMode = "Additive",
	textureAddressMode = "Wrap",
	glossiness = 5,
	depthBias = 0,
}

-- ***********************************************************************************
--                                    Define crystals 
-- ***********************************************************************************

defineCrystal{
	color = "green",
	lightColor = {0.5,1,0.5},
	particleFogColor = {0.15, 0.80, 0.35},
	particleStarsColor = {1.0,4.0,1.0},
}

defineCrystal{
	color = "pink",
	lightColor = {1,0.5,1},
	particleFogColor = {0.80, 0.15, 0.70},
	particleStarsColor = {4.0,1.0,2.0},
}

defineCrystal{
	color = "red",
	lightColor = {1.6,0.5,0.5},
	particleFogColor = {1.10, 0.20, 0.20},
	particleStarsColor = {4.0, 1.0, 1.0},
	defineGlassVersion = true,
}

defineCrystal{
	color = "black",
	lightColor = {0.1, 0.1, 0.1},
	particleFogColor = {0.2, 0.2, 0.2},
	particleStarsColor = {0, 0, 0},
}

defineCrystal{
	color = "orange",
	lightColor = {1.10, 0.3, 0},
	particleFogColor = {1.10, 0.22, 0},
	particleStarsColor = {1.10, 0.1, 0},
}
