-- This file has been generated by Dungeon Editor 1.3.6

-- TODO: place your custom dungeon object definitions here

defineObject{
	name = "sx_orrr2_small_pillar",
	class = "Decoration",
	model = "mod_assets/models/sx_orrr2_small_pillar.fbx",
	placement = "pillar",
	editorIcon = 108,
}

defineObject{
	name = "sx_orrr2_small_pillar_corner",
	class = "Decoration",
	model = "mod_assets/models/sx_orrr2_small_pillar_corner.fbx",
	placement = "pillar",
	editorIcon = 108,
}

defineObject{
	name = "sx_orrr2_small_pillar_corner_outward",
	class = "Decoration",
	model = "mod_assets/models/sx_orrr2_small_pillar_corner_outward.fbx",
	placement = "pillar",
	editorIcon = 108,
}


defineObject{
	name = "sx_orrr2_chain_railing",
	class = "Door",
	model = "mod_assets/models/sx_orrr2_chain_railing.fbx",
	openSound = "wall_sliding",
	closeSound = "wall_sliding",
	lockSound = "wall_sliding_lock",
	openVelocity = 0.5,
	closeVelocity = -0.5,
	secretDoor = true,
	placement = "wall",
	editorIcon = 120,
}