-- This file has been generated by Dungeon Editor beta-1.2.9

-- TODO: place your custom wall set definitions here


-- Import dependencies

import "mod_assets/sx_towntileset/scripts/sx_towntileset_objects.lua"
import "mod_assets/sx_towntileset/scripts/sx_towntileset_materials.lua"
import "mod_assets/sx_towntileset/scripts/sx_towntileset_sounds.lua"

-- Define the Town WallSet

defineWallSet{
	name = "sx_town",
	randomFloorFacing = false,

	floors = {
		"mod_assets/sx_towntileset/models/sx_town_floor.fbx", 5,
		"mod_assets/sx_towntileset/models/sx_town_floor_02.fbx", 1,
		"mod_assets/sx_towntileset/models/sx_town_floor_03.fbx", 1,
		--"assets/models/env/temple_floor_drainage.fbx", 1,
	},
	
	walls = {
		"mod_assets/sx_towntileset/models/sx_town_wall.fbx", 5,
		"mod_assets/sx_towntileset/models/sx_town_wall_drainage.fbx", 1,
	},
	
	pillars = {
		"mod_assets/sx_towntileset/models/sx_town_pillar.fbx", 1,
	},
	
	ceilings = {
		"mod_assets/sx_towntileset/models/sx_blocker2.fbx", 1,
	},
	
	ceilingShafts = {
		"assets/models/env/temple_ceiling_pit.fbx", 1,
	},
	
	floorDecorations = {
	},
	
	wallDecorations = {
		--"mod_assets/sx_towntileset/models/sx_town_wall_barrels.fbx", 1,
		--"mod_assets/sx_towntileset/models/sx_town_wall_window_low_snapon.fbx", 1,
	},
	
	pillarDecorations = {
		--"mod_assets/sx_towntileset/models/sx_pillar_flowers_yellow.fbx", 1,
		--"assets/models/env/metal_hook_chain_pillar.fbx", 1,
		--"assets/models/env/metal_ring_pillar.fbx", 1,
	},
}

defineWallSet{
	name = "sx_town_indoor",
	randomFloorFacing = false,

	floors = {
		"mod_assets/sx_towntileset/models/sx_town_floor_indoor.fbx", 5,
	},
	
	walls = {
		"mod_assets/sx_towntileset/models/sx_town_wall_indoor.fbx", 5,
		"mod_assets/sx_towntileset/models/sx_town_wall_indoor_02.fbx", 1,
		"mod_assets/sx_towntileset/models/sx_town_wall_indoor_03.fbx", 1,
		"mod_assets/sx_towntileset/models/sx_town_wall_indoor_04.fbx", 1,
	},
	
	pillars = {
		"mod_assets/sx_towntileset/models/sx_town_pillar_wood.fbx", 1,
	},
	
	ceilings = {
		"mod_assets/sx_towntileset/models/sx_town_ceiling_indoor.fbx", 1,
	},
	
	ceilingShafts = {
		"assets/models/env/temple_ceiling_pit.fbx", 1,
	},
	
	floorDecorations = {
	},
	
	wallDecorations = {
		--"mod_assets/sx_towntileset/models/sx_town_wall_barrels.fbx", 1,
		--"mod_assets/sx_towntileset/models/sx_town_wall_window_low_snapon.fbx", 1,
	},
	
	pillarDecorations = {
		--"mod_assets/sx_towntileset/models/sx_pillar_flowers_yellow.fbx", 1,
		--"assets/models/env/metal_hook_chain_pillar.fbx", 1,
		--"assets/models/env/metal_ring_pillar.fbx", 1,
	},
}