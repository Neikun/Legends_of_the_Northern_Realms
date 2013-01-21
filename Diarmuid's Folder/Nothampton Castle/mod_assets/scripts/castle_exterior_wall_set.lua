-- "Northern Dungeon" is a modified copy of the "Dungeon" wall set from Legend of Grimrock
-- All original models, textures etc. used in this wall set are copyright (C) Almost Human Ltd.
-- For more details on using and redistributing these assets, please visit: http://www.grimrock.net/modding/modding-and-asset-usage-terms/


defineWallSet{
	name = "castle_exterior",
	randomFloorFacing = true,

	floors = {
		"assets/models/env/temple_floor_01.fbx", 30,
		"assets/models/env/temple_floor_drainage.fbx", 1,
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