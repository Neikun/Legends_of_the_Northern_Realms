-- **************************************************************************************
--                                         MATERIALS
-- **************************************************************************************


defineMaterial{
   name = "castle_stone",
   diffuseMap = "mod_assets/textures/castle_exterior/castle_stone_dif.tga",
   specularMap = "mod_assets/textures/castle_exterior/castle_stone_spec.tga",
   doubleSided = true,
   lighting = true,
   alphaTest = false,
   blendMode = "Opaque",
   textureAddressMode = "Clamp",
   glossiness = 30,
   depthBias = 0,
   }
   
defineMaterial{
   name = "sky",
   diffuseMap = "mod_assets/textures/castle_exterior/sky.tga",
   doubleSided = true,
   lighting = true,
   alphaTest = false,
   blendMode = "Opaque",
   textureAddressMode = "Clamp",
   glossiness = 30,
   depthBias = 2,
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
   glossiness = 30,
   depthBias = 0,
   }

defineMaterial{
   name = "castle_wall",
   diffuseMap = "mod_assets/textures/castle_exterior/castle_wall_dif.tga",
   specularMap = "mod_assets/textures/castle_exterior/castle_stone_spec.tga",
   doubleSided = false,
   lighting = true,
   alphaTest = false,
   blendMode = "Opaque",
   textureAddressMode = "Clamp",
   glossiness = 30,
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
	name = "_castle_exterior_wall_1below",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/wall_1below.fbx",
	placement = "wall",
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

-- Sky
-- =================================================================================

defineObject{
	name = "castle_exterior_sky",
	class = "Decoration",
	model = "mod_assets/models/castle_exterior/sky.fbx",
	placement = "floor",
	replacesFloor = false,
	editorIcon = 136,
}

-- SX Objects
-- =================================================================================

defineObject{
	name = "sx_ceiling_lamp_outside",
	class = "LightSource",
	lightPosition = vec(0, 10, 0),
	lightRange = 60,
	lightColor = vec(1, 0.8, 0.7),
	brightness = 8,
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
	editorIcon = 8,
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
	class = "Pit",
	model = "mod_assets/models/sx_pit.fbx",
	trapDoorModel = "mod_assets/models/sx_pit_door.fbx",
	openAnim = "assets/animations/env/dungeon_pit_trapdoor_open.fbx",
	closeAnim = "assets/animations/env/dungeon_pit_trapdoor_close.fbx",
	placement = "floor",
	editorIcon = 40,
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
		"assets/models/env/metal_hooks_wall.fbx", 1,
		"assets/models/env/metal_hooks_chain_wall.fbx", 1,
	},
	
	pillarDecorations = {
		"assets/models/env/metal_hook_pillar.fbx", 1,
		"assets/models/env/metal_hook_chain_pillar.fbx", 1,
		"assets/models/env/metal_ring_pillar.fbx", 1,
	},
}