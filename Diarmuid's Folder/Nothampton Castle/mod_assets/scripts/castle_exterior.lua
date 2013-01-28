-- **************************************************************************************
--                                         MATERIALS
-- **************************************************************************************


defineMaterial{
   name = "castle_stone",
   diffuseMap = "mod_assets/textures/castle_exterior/castle_stone_dif.tga",
   specularMap = "mod_assets/textures/castle_exterior/castle_stone_spec.tga",
   normalMap = "mod_assets/textures/castle_exterior/castle_stone_normal.tga",
   doubleSided = true,
   lighting = true,
   alphaTest = false,
   blendMode = "Opaque",
   textureAddressMode = "Clamp",
   glossiness = 30,
   depthBias = 0,
   }
   
defineMaterial{
   name = "castle_pillar_big",
   diffuseMap = "mod_assets/textures/castle_exterior/castle_pillar_big_dif.tga",
   specularMap = "mod_assets/textures/castle_exterior/castle_pillar_big_spec.tga",
   normalMap = "mod_assets/textures/castle_exterior/castle_pillar_big_normal.tga",
   doubleSided = true,
   lighting = true,
   alphaTest = false,
   blendMode = "Opaque",
   textureAddressMode = "Clamp",
   glossiness = 30,
   depthBias = 0,
   }
   
defineMaterial{
   name = "castle_stone_red",
   diffuseMap = "mod_assets/textures/castle_exterior/castle_stone_red_dif.tga",
   specularMap = "mod_assets/textures/castle_exterior/castle_stone_spec.tga",
   normalMap = "mod_assets/textures/castle_exterior/castle_stone_red_normal.tga",
   doubleSided = true,
   lighting = true,
   alphaTest = false,
   blendMode = "Opaque",
   textureAddressMode = "Clamp",
   glossiness = 20,
   depthBias = 0,
   }

defineMaterial{
   name = "castle_wall",
   diffuseMap = "mod_assets/textures/castle_exterior/castle_wall_dif.tga",
   specularMap = "mod_assets/textures/castle_exterior/castle_wall_spec.tga",
   normalMap = "mod_assets/textures/castle_exterior/castle_wall_normal.tga",
   doubleSided = false,
   lighting = true,
   alphaTest = false,
   blendMode = "Opaque",
   textureAddressMode = "Clamp",
   glossiness = 20,
   depthBias = 0,
   }
   
defineMaterial{
   name = "castle_floor",
   diffuseMap = "mod_assets/textures/castle_exterior/castle_floor_dif.tga",
   specularMap = "mod_assets/textures/castle_exterior/castle_floor_spec.tga",
   normalMap = "mod_assets/textures/castle_exterior/castle_floor_normal.tga",
   doubleSided = false,
   lighting = true,
   alphaTest = false,
   blendMode = "Opaque",
   textureAddressMode = "Clamp",
   glossiness = 20,
   depthBias = 0,
   }
   
defineMaterial{
   name = "castle_window",
   diffuseMap = "mod_assets/textures/castle_exterior/black.tga",
   specularMap = "mod_assets/textures/castle_exterior/black.tga",
   doubleSided = false,
   lighting = true,
   alphaTest = false,
   blendMode = "Opaque",
   textureAddressMode = "Clamp",
   glossiness = 10,
   depthBias = 0,
   }
   
defineMaterial{
	name = "sx_invisible",
	diffuseMap = "mod_assets/textures/sx_invisible.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = true,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 5,
	depthBias = 0,
}

defineMaterial{
	name = "castle_wall_ivy",
	diffuseMap = "mod_assets/textures/castle_exterior/castle_wall_ivy_dif.tga",
	specularMap = "assets/textures/props/wall_ivy_spec.tga",
	normalMap = "assets/textures/props/wall_ivy_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = true,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 25,
	depthBias = 0,
}

defineMaterial{
	name = "gobelin_ku",
	diffuseMap = "mod_assets/textures/castle_exterior/castle_gobelin_ku_dif.tga",
	specularMap = "mod_assets/textures/castle_exterior/castle_gobelin_ku_spec.tga",
	normalMap = "assets/textures/env/dungeon_gobelin_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = true,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,
}


-- **************************************************************************************
--                                         OBJECTS
-- **************************************************************************************


-- Walls
-- =================================================================================

defineObject{
	name = "castle_exterior_wall",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/wall.fbx",
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "_castle_exterior_wall_1above",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/wall_1above.fbx",
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "_castle_exterior_wall_2above",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/wall_2above.fbx",
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "_castle_exterior_wall_3above",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/wall_3above.fbx",
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "_castle_exterior_wall_1below",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/wall_1below.fbx",
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "_castle_exterior_wall_2below",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/wall_2below.fbx",
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "_castle_exterior_wall_3below",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/wall_3below.fbx",
	placement = "wall",
	editorIcon = 120,
}

-- Underbridge Walls
-- =================================================================================

defineObject{
	name = "castle_exterior_wall_underbridge",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/wall_underbridge.fbx",
	placement = "wall",
	replacesWall = true,
	editorIcon = 120,
}

defineObject{
	name = "_castle_exterior_wall_underbridge_1above",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/wall_underbridge_1above.fbx",
	placement = "wall",
	replacesWall = true,
	editorIcon = 120,
}

defineObject{
	name = "_castle_exterior_wall_underbridge_2above",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/wall_underbridge_2above.fbx",
	placement = "wall",
	replacesWall = true,
	editorIcon = 120,
}

defineObject{
	name = "_castle_exterior_wall_underbridge_3above",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/wall_underbridge_3above.fbx",
	placement = "wall",
	replacesWall = true,
	editorIcon = 120,
}

defineObject{
	name = "_castle_exterior_wall_underbridge_1below",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/wall_underbridge_1below.fbx",
	placement = "wall",
	replacesWall = true,
	editorIcon = 120,
}

defineObject{
	name = "_castle_exterior_wall_underbridge_2below",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/wall_underbridge_2below.fbx",
	placement = "wall",
	replacesWall = true,
	editorIcon = 120,
}

defineObject{
	name = "_castle_exterior_wall_underbridge_3below",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/wall_underbridge_3below.fbx",
	placement = "wall",
	replacesWall = true,
	editorIcon = 120,
}

-- Floors
-- =================================================================================

defineObject{
	name = "castle_exterior_floor",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/floor.fbx",
	placement = "floor",
	replacesFloor = true,
	editorIcon = 136,
}

defineObject{
	name = "_castle_exterior_floor_1below",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/floor_1below.fbx",
	placement = "floor",
	replacesFloor = true,
	editorIcon = 136,
}

defineObject{
	name = "_castle_exterior_floor_2below",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/floor_2below.fbx",
	placement = "floor",
	replacesFloor = true,
	editorIcon = 136,
}

defineObject{
	name = "_castle_exterior_floor_3below",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/floor_3below.fbx",
	placement = "floor",
	replacesFloor = true,
	editorIcon = 136,
}

-- Big Pillars
-- =================================================================================

defineObject{
   name = "castle_exterior_pillar_big",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/pillar_big.fbx",
   placement = "pillar",
   editorIcon = 108,
   }
   
defineObject{
   name = "_castle_exterior_pillar_big_1above",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/pillar_big_1above.fbx",
   placement = "pillar",
   editorIcon = 108,
   }

defineObject{
   name = "_castle_exterior_pillar_big_2above",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/pillar_big_2above.fbx",
   placement = "pillar",
   editorIcon = 108,
   }
   
defineObject{
   name = "_castle_exterior_pillar_big_3above",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/pillar_big_3above.fbx",
   placement = "pillar",
   editorIcon = 108,
   }
   
defineObject{
   name = "_castle_exterior_pillar_big_1below",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/pillar_big_1below.fbx",
   placement = "pillar",
   editorIcon = 108,
   }


-- Small Pillars
-- =================================================================================

defineObject{
   name = "castle_exterior_pillar_small",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/pillar_small.fbx",
   placement = "pillar",
   editorIcon = 108,
   }
   
defineObject{
   name = "_castle_exterior_pillar_small_1above",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/pillar_small_1above.fbx",
   placement = "pillar",
   editorIcon = 108,
   }

defineObject{
   name = "_castle_exterior_pillar_small_2above",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/pillar_small_2above.fbx",
   placement = "pillar",
   editorIcon = 108,
   }

defineObject{
   name = "_castle_exterior_pillar_small_1below",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/pillar_small_1below.fbx",
   placement = "pillar",
   editorIcon = 108,
   }

   
-- Parapet Pillars
-- =================================================================================

defineObject{
   name = "castle_exterior_parapet_pillar",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/parapet_pillar.fbx",
   placement = "pillar",
   editorIcon = 108,
   }

defineObject{
   name = "_castle_exterior_parapet_pillar_1above",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/parapet_pillar_1above.fbx",
   placement = "pillar",
   editorIcon = 108,
   }
  
defineObject{
   name = "_castle_exterior_parapet_pillar_2above",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/parapet_pillar_2above.fbx",
   placement = "pillar",
   editorIcon = 108,
   }
  
defineObject{
   name = "_castle_exterior_parapet_pillar_3above",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/parapet_pillar_3above.fbx",
   placement = "pillar",
   editorIcon = 108,
   }
  
defineObject{
   name = "_castle_exterior_parapet_pillar_1below",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/parapet_pillar_1below.fbx",
   placement = "pillar",
   editorIcon = 108,
   }
  
defineObject{
   name = "_castle_exterior_parapet_pillar_2below",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/parapet_pillar_2below.fbx",
   placement = "pillar",
   editorIcon = 108,
   }
   
-- Parapets
-- =================================================================================

defineObject{
   name = "castle_exterior_parapet",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/parapet.fbx",
   placement = "wall",
   editorIcon = 92,
   }

defineObject{
   name = "_castle_exterior_parapet_1above",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/parapet_1above.fbx",
   placement = "wall",
   editorIcon = 108,
   }
   
defineObject{
   name = "_castle_exterior_parapet_2above",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/parapet_2above.fbx",
   placement = "wall",
   editorIcon = 108,
   }
      
defineObject{
   name = "_castle_exterior_parapet_3above",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/parapet_3above.fbx",
   placement = "wall",
   editorIcon = 108,
   }
      
defineObject{
   name = "_castle_exterior_parapet_1below",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/parapet_1below.fbx",
   placement = "wall",
   editorIcon = 108,
   }
      
defineObject{
   name = "_castle_exterior_parapet_2below",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/parapet_2below.fbx",
   placement = "wall",
   editorIcon = 108,
   }

-- Arches 1 square
-- =================================================================================

defineObject{
   name = "castle_exterior_arch_1",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/arch_1.fbx",
   placement = "wall",
   editorIcon = 92,
   }

defineObject{
   name = "_castle_exterior_arch_1_1above",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/arch_1_1above.fbx",
   placement = "wall",
   editorIcon = 108,
   }
   
defineObject{
   name = "_castle_exterior_arch_1_2above",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/arch_1_2above.fbx",
   placement = "wall",
   editorIcon = 108,
   }
      
defineObject{
   name = "_castle_exterior_arch_1_3above",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/arch_1_3above.fbx",
   placement = "wall",
   editorIcon = 108,
   }
      
defineObject{
   name = "_castle_exterior_arch_1_1below",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/arch_1_1below.fbx",
   placement = "wall",
   editorIcon = 108,
   }
      
defineObject{
   name = "_castle_exterior_arch_1_2below",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/arch_1_2below.fbx",
   placement = "wall",
   editorIcon = 108,
   }

defineObject{
   name = "_castle_exterior_arch_1_2below",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/arch_1_2below.fbx",
   placement = "wall",
   editorIcon = 108,
   }

   
-- Arches 2 square
-- =================================================================================

defineObject{
   name = "castle_exterior_arch_2",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/arch_2.fbx",
   placement = "wall",
   editorIcon = 92,
   }

defineObject{
   name = "_castle_exterior_arch_2_1above",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/arch_2_1above.fbx",
   placement = "wall",
   editorIcon = 108,
   }
   
defineObject{
   name = "_castle_exterior_arch_2_2above",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/arch_2_2above.fbx",
   placement = "wall",
   editorIcon = 108,
   }
      
defineObject{
   name = "_castle_exterior_arch_2_3above",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/arch_2_3above.fbx",
   placement = "wall",
   editorIcon = 108,
   }
      
defineObject{
   name = "_castle_exterior_arch_2_1below",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/arch_2_1below.fbx",
   placement = "wall",
   editorIcon = 108,
   }
      
defineObject{
   name = "_castle_exterior_arch_2_2below",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/arch_2_2below.fbx",
   placement = "wall",
   editorIcon = 108,
   }

defineObject{
   name = "_castle_exterior_arch_2_3below",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/arch_2_3below.fbx",
   placement = "wall",
   editorIcon = 108,
   }

-- Bridge
-- =================================================================================

defineObject{
   name = "castle_exterior_bridge",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/bridge.fbx",
   placement = "floor",
   editorIcon = 0,
   }
   
defineObject{
   name = "_castle_exterior_bridge_1above",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/bridge_1above.fbx",
   placement = "floor",
   editorIcon = 0,
   }

defineObject{
   name = "_castle_exterior_bridge_2above",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/bridge_2above.fbx",
   placement = "floor",
   editorIcon = 0,
   }

defineObject{
   name = "_castle_exterior_bridge_3above",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/bridge_3above.fbx",
   placement = "floor",
   editorIcon = 0,
   }

defineObject{
   name = "_castle_exterior_bridge_1below",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/bridge_1below.fbx",
   placement = "floor",
   editorIcon = 0,
   }

defineObject{
   name = "_castle_exterior_bridge_2below",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/bridge_2below.fbx",
   placement = "floor",
   editorIcon = 0,
   }

defineObject{
   name = "_castle_exterior_bridge_3below",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/bridge_3below.fbx",
   placement = "floor",
   editorIcon = 0,
   }
   
-- Windows
-- =================================================================================

defineObject{
	name = "castle_exterior_wall_windows",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/wall_windows.fbx",
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "_castle_exterior_wall_windows_1above",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/wall_windows_1above.fbx",
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "_castle_exterior_wall_windows_2above",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/wall_windows_2above.fbx",
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "_castle_exterior_wall_windows_1below",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/wall_windows_1below.fbx",
	placement = "wall",
	editorIcon = 120,
}
      
cloneObject {
    name = "castle_exterior_gobelin_ku",
    baseObject = "gobelin",
    model = "mod_assets/models/castle_exterior/gobelin_ku.fbx",
    brokenModel = "mod_assets/models/castle_exterior/gobelin_ku.fbx",
}

-- Stairs
-- =================================================================================

defineObject{
	name = "castle_exterior_stairs_up",
	class = "Stairs",
	model = "mod_assets/models/sx_blocker.fbx",
	down = false,
	editorIcon = 48,
}

defineObject{
	name = "castle_exterior_stairs_down",
	class = "Stairs",
	model = "mod_assets/models/sx_blocker.fbx",
	down = true,
	editorIcon = 48,
}

defineObject{
	name = "_castle_exterior_stairs",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/stairs_up.fbx",
	placement = "floor",
	editorIcon = 48,
}

defineObject{
	name = "_castle_exterior_stairs_1above",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/stairs_up_1above.fbx",
	placement = "floor",
	editorIcon = 48,
}

defineObject{
	name = "_castle_exterior_stairs_2above",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/stairs_up_2above.fbx",
	placement = "floor",
	editorIcon = 48,
}

defineObject{
	name = "_castle_exterior_stairs_3above",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/stairs_up_3above.fbx",
	placement = "floor",
	editorIcon = 48,
}

defineObject{
	name = "_castle_exterior_stairs_1below",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/stairs_up_1below.fbx",
	placement = "floor",
	editorIcon = 48,
}

defineObject{
	name = "_castle_exterior_stairs_2below",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/stairs_up_2below.fbx",
	placement = "floor",
	editorIcon = 48,
}

defineObject{
	name = "_castle_exterior_stairs_3below",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/stairs_up_3below.fbx",
	placement = "floor",
	editorIcon = 48,
}

   
-- Ivy
-- =================================================================================

defineObject{
	name = "castle_exterior_wall_ivy1",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/ivy1.fbx",
	placement = "wall",
	editorIcon = 120,
}
  
defineObject{
   name = "_castle_exterior_wall_ivy1_1above",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/ivy1_1above.fbx",
   placement = "wall",
   editorIcon = 0,
   }

defineObject{
   name = "_castle_exterior_wall_ivy1_2above",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/ivy1_2above.fbx",
   placement = "wall",
   editorIcon = 0,
   }

defineObject{
   name = "_castle_exterior_wall_ivy1_3above",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/ivy1_3above.fbx",
   placement = "wall",
   editorIcon = 0,
   }

defineObject{
   name = "_castle_exterior_wall_ivy1_1below",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/ivy1_1below.fbx",
   placement = "wall",
   editorIcon = 0,
   }

defineObject{
   name = "_castle_exterior_wall_ivy1_2below",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/ivy1_2below.fbx",
   placement = "wall",
   editorIcon = 0,
   }

defineObject{
   name = "_castle_exterior_wall_ivy1_3below",
   class = "Decoration",
   model = "mod_assets/models/castle_exterior/ivy1_3below.fbx",
   placement = "wall",
   editorIcon = 0,
   }
   
-- SX Objects
-- =================================================================================

defineParticleSystem{
	name = "sky_stars",
	emitters = {
		{
			spawnBurst = true,
			objectSpace = true,
			emissionRate = 400,
			emissionTime = 0,
			maxParticles = 400,
			boxMin = {-1.5, 0.0,-1.5},
			boxMax = { 13.5, 3.0, 13.5},
			sprayAngle = {0,0},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {100000,100000},
			color0 = {3,3,3},
			opacity = 1.0,
			fadeIn = 1,
			fadeOut = 4,
			size = {0.005, 0.05},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 0,
			blendMode = "Translucent",
		},
		{
			spawnBurst = true,
			objectSpace = true,
			emissionRate = 30,
			emissionTime = 0,
			maxParticles = 30,
			boxMin = {-1.5, 0.0,-1.5},
			boxMax = { 13.5, 2.0, 13.5},
			sprayAngle = {0,0},
			velocity = {0,0},
			texture = "mod_assets/textures/star_white.tga",
			lifetime = {100000,100000},
			color0 = {1,1,1},
			opacity = 1.0,
			fadeIn = 1,
			fadeOut = 4,
			size = {0.03, 0.1},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 0.4,
			blendMode = "Translucent",
		},
		{
			spawnBurst = true,
			objectSpace = true,
			emissionRate = 30,
			emissionTime = 0,
			maxParticles = 30,
			boxMin = {-1.5, 0.0,-1.5},
			boxMax = { 13.5, 2.0, 13.5},
			sprayAngle = {0,0},
			velocity = {0,0},
			texture = "mod_assets/textures/star_blue.tga",
			lifetime = {100000,100000},
			color0 = {1,1,1},
			opacity = 1.0,
			fadeIn = 1,
			fadeOut = 4,
			size = {0.05, 0.2},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 0.3,
			blendMode = "Translucent",
		},
		{
			spawnBurst = true,
			objectSpace = true,
			emissionRate = 30,
			emissionTime = 0,
			maxParticles = 30,
			boxMin = {-1.5, 0.0,-1.5},
			boxMax = { 13.5, 2.0, 13.5},
			sprayAngle = {0,0},
			velocity = {0,0},
			texture = "mod_assets/textures/star_pink.tga",
			lifetime = {100000,100000},
			color0 = {1,1,1},
			opacity = 1.0,
			fadeIn = 1,
			fadeOut = 4,
			size = {0.1, 0.4},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 0.5,
			blendMode = "Translucent",
		},
	}
}

defineObject{
	name = "sx_ceiling_lamp_outside",
	class = "LightSource",
	lightPosition = vec(0, 10, 0),
	lightRange = 60,
	lightColor = vec(0.6, 0.7, 1.0),
	brightness = 0.7,
	castShadow = true,
	flicker = false,
	placement = "floor",
	editorIcon = 88,
}

defineObject{
	name = "sx_outwall_pillarkiller",
	class = "Door",
	model = "mod_assets/models/sx_blocker.fbx",
	doorFrameModel = "mod_assets/models/sx_blocker.fbx",
	openSound = "gate_open",
	closeSound = "gate_close",
	lockSound = "gate_lock",
	openVelocity = 1.3,
	closeVelocity = 0,
	closeAcceleration = -10,
	sparse = true,
	placement = "wall",
	killPillars = true,
	editorIcon = 8,
}

defineObject{
	name = "sx_remove_wall",
	class = "Decoration",
	model = "mod_assets/models/sx_blocker.fbx",
	placement = "wall",
	replacesWall = true,
	killPillars = true,
	editorIcon = 124,
}

defineObject{
	name = "sx_remove_ceiling",
	class = "Decoration",
	model = "mod_assets/models/sx_blocker.fbx",
	placement = "ceiling",
	editorIcon = 104,
}

defineObject{
	name = "sx_remove_floor",
	class = "Decoration",
	model = "mod_assets/models/sx_blocker.fbx",
	replacesFloor = true,
	placement = "floor",
	editorIcon = 136,
}

defineObject{
	name = "sx_simple_stairs_up",
	class = "Stairs",
	model = "mod_assets/models/sx_simple_stairs_up.fbx",
	down = false,
	editorIcon = 48,
}

defineObject{
	name = "sx_simple_stairs_down",
	class = "Stairs",
	model = "mod_assets/models/sx_simple_stairs_down.fbx",
	down = true,
	editorIcon = 48,
}

-- **************************************************************************************
--                                         WALL SET
-- **************************************************************************************

defineWallSet{
	name = "castle_exterior",
	randomFloorFacing = true,

	floors = {
		"mod_assets/models/castle_exterior/floor.fbx", 1,
	},
	
	walls = {
		"mod_assets/models/castle_exterior/wall.fbx", 1
	},
	
	pillars = {
		"mod_assets/models/castle_exterior/pillar_small.fbx", 1,
	},
	
	ceilings = {
		"assets/models/env/temple_ceiling.fbx", 1,
	},
	
	ceilingShafts = {
		"assets/models/env/temple_ceiling_pit.fbx", 1,
	},
	
	floorDecorations = {
	},
	
	wallDecorations = {
	},
	
	pillarDecorations = {
	},
}