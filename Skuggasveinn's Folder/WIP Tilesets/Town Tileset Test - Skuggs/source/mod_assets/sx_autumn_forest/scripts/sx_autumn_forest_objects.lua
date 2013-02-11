

-- Trees and pillars

defineObject{
	name = "sx_autumn_tree_large_01",
	class = "Decoration",
	model = "mod_assets/sx_autumn_forest/models/sx_autumn_tree_large_01.fbx",
	placement = "pillar",
	editorIcon = 108,
}

defineObject{
	name = "sx_forest_housepillar_01",
	class = "Decoration",
	model = "mod_assets/sx_autumn_forest/models/sx_forest_housepillar_01.fbx",
	placement = "pillar",
	editorIcon = 108,
}

-- pits

defineObject{
	name = "sx_forest_pit",
	class = "Pit",
    model = "mod_assets/sx_autumn_forest/models/sx_forest_pit.fbx",
	trapDoorModel = "mod_assets/sx_towntileset/models/sx_town_floor_pit_trapdoor.fbx",
	openAnim = "assets/animations/env/dungeon_pit_trapdoor_open.fbx",
	closeAnim = "assets/animations/env/dungeon_pit_trapdoor_close.fbx",
	placement = "floor",
	editorIcon = 40,
}

-- walls

defineObject{
	name = "sx_forest_housewall_01",
	class = "Door",
	model = "mod_assets/sx_autumn_forest/models/sx_forest_housewall_01.fbx",
	openSound = "wall_sliding",
	closeSound = "wall_sliding",
	lockSound = "wall_sliding_lock",
	openVelocity = 0.5,
	closeVelocity = -0.5,
	secretDoor = true,
	placement = "wall",
	editorIcon = 120,
}