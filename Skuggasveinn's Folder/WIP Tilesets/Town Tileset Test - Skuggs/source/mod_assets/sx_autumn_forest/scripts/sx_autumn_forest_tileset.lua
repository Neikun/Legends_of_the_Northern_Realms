

-- Import dependencies

import "mod_assets/sx_autumn_forest/scripts/sx_autumn_forest_objects.lua"
import "mod_assets/sx_autumn_forest/scripts/sx_autumn_forest_materials.lua"

-- Forest Wallset

defineWallSet{
	name = "sx_forest_autumn",
	randomFloorFacing = false,

	floors = {
		"mod_assets/sx_autumn_forest/models/sx_forest_ground_01.fbx", 1,
		"mod_assets/sx_autumn_forest/models/sx_forest_ground_02.fbx", 1,
		"mod_assets/sx_autumn_forest/models/sx_forest_ground_03.fbx", 1,
	},
	
	walls = {
		"mod_assets/sx_autumn_forest/models/sx_forest_wall_01.fbx", 1,
		"mod_assets/sx_autumn_forest/models/sx_forest_wall_02.fbx", 1,
		"mod_assets/sx_autumn_forest/models/sx_forest_wall_03.fbx", 1,
	},
	
	pillars = {
		"mod_assets/sx_autumn_forest/models/sx_autumn_tree_large_01.fbx", 1,
	},
	
	ceilings = {
		"mod_assets/sx_autumn_forest/models/sx_forest_sky_01.fbx", 1,
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