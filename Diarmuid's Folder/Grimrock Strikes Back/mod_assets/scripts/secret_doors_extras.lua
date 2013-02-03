-- Secret Doors Extras
-- a set of secret doors


-- Materials

defineMaterial{
	name = "temple_wall_glass_transp",
	diffuseMap = "mod_assets/textures/secret_doors/temple_wall_glass_transp_dif.tga",
	specularMap = "assets/textures/env/temple_wall_glass_spec.tga",
	normalMap = "assets/textures/env/temple_wall_glass_normal.tga",
	doubleSided = false,
	lighting = false,
	alphaTest = true,
	blendMode = "Translucent",
	textureAddressMode = "Wrap",
	glossiness = 1,
	depthBias = 0,
}

defineMaterial{
	name = "black_wings",
	diffuseMap = "mod_assets/textures/secret_doors/black_wings_dif.tga",
	specularMap = "assets/textures/monsters/wyvern_spec.tga",
	normalMap = "assets/textures/monsters/wyvern_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 50,
	depthBias = 0,
}

-- Objects

defineObject{
	name = "dungeon_secret_door_flipped",
	class = "Door",
	model = "mod_assets/models/secret_doors/dungeon_secret_door_flipped.fbx",
	openSound = "wall_sliding",
	closeSound = "wall_sliding",
	lockSound = "wall_sliding_lock",
	openVelocity = 0.5,
	closeVelocity = -0.5,
	secretDoor = true,
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "dungeon_secret_door_ivy_1",
	class = "Door",
	model = "mod_assets/models/secret_doors/dungeon_secret_door_ivy_1.fbx",
	openSound = "wall_sliding",
	closeSound = "wall_sliding",
	lockSound = "wall_sliding_lock",
	openVelocity = 0.5,
	closeVelocity = -0.5,
	secretDoor = true,
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "dungeon_secret_door_ivy_2",
	class = "Door",
	model = "mod_assets/models/secret_doors/dungeon_secret_door_ivy_2.fbx",
	openSound = "wall_sliding",
	closeSound = "wall_sliding",
	lockSound = "wall_sliding_lock",
	openVelocity = 0.5,
	closeVelocity = -0.5,
	secretDoor = true,
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "dungeon_secret_door_drain_closed",
	class = "Door",
	model = "mod_assets/models/secret_doors/dungeon_secret_door_drain_closed.fbx",
	openSound = "wall_sliding",
	closeSound = "wall_sliding",
	lockSound = "wall_sliding_lock",
	openVelocity = 0.5,
	closeVelocity = -0.5,
	secretDoor = true,
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "dungeon_secret_door_drain_open",
	class = "Door",
	model = "mod_assets/models/secret_doors/dungeon_secret_door_drain_open.fbx",
	openSound = "wall_sliding",
	closeSound = "wall_sliding",
	lockSound = "wall_sliding_lock",
	openVelocity = 0.5,
	closeVelocity = -0.5,
	secretDoor = true,
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "dungeon_secret_door_wallchain",
	class = "Door",
	model = "mod_assets/models/secret_doors/dungeon_secret_door_wallchain.fbx",
	openSound = "wall_sliding",
	closeSound = "wall_sliding",
	lockSound = "wall_sliding_lock",
	openVelocity = 0.5,
	closeVelocity = -0.5,
	secretDoor = true,
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "dungeon_secret_door_wallchain_2",
	class = "Door",
	model = "mod_assets/models/secret_doors/dungeon_secret_door_wallchain_2.fbx",
	openSound = "wall_sliding",
	closeSound = "wall_sliding",
	lockSound = "wall_sliding_lock",
	openVelocity = 0.5,
	closeVelocity = -0.5,
	secretDoor = true,
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "dungeon_secret_door_wallhook",
	class = "Door",
	model = "mod_assets/models/secret_doors/dungeon_secret_door_wallhook.fbx",
	openSound = "wall_sliding",
	closeSound = "wall_sliding",
	lockSound = "wall_sliding_lock",
	openVelocity = 0.5,
	closeVelocity = -0.5,
	secretDoor = true,
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "dungeon_secret_door_wallring",
	class = "Door",
	model = "mod_assets/models/secret_doors/dungeon_secret_door_wallring.fbx",
	openSound = "wall_sliding",
	closeSound = "wall_sliding",
	lockSound = "wall_sliding_lock",
	openVelocity = 0.5,
	closeVelocity = -0.5,
	secretDoor = true,
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "temple_secret_door_wallring",
	class = "Door",
	model = "mod_assets/models/secret_doors/temple_secret_door_wallring.fbx",
	openSound = "wall_sliding",
	closeSound = "wall_sliding",
	lockSound = "wall_sliding_lock",
	openVelocity = 0.5,
	closeVelocity = -0.5,
	secretDoor = true,
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "temple_secret_door_drain_closed",
	class = "Door",
	model = "mod_assets/models/secret_doors/temple_secret_door_drain_closed.fbx",
	openSound = "wall_sliding",
	closeSound = "wall_sliding",
	lockSound = "wall_sliding_lock",
	openVelocity = 0.5,
	closeVelocity = -0.5,
	secretDoor = true,
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "temple_secret_door_drain_open",
	class = "Door",
	model = "mod_assets/models/secret_doors/temple_secret_door_drain_open.fbx",
	openSound = "wall_sliding",
	closeSound = "wall_sliding",
	lockSound = "wall_sliding_lock",
	openVelocity = 0.5,
	closeVelocity = -0.5,
	secretDoor = true,
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "temple_secret_door_drain_flipped",
	class = "Door",
	model = "mod_assets/models/secret_doors/temple_secret_door_flipped.fbx",
	openSound = "wall_sliding",
	closeSound = "wall_sliding",
	lockSound = "wall_sliding_lock",
	openVelocity = 0.5,
	closeVelocity = -0.5,
	secretDoor = true,
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "temple_secret_door_wallchain",
	class = "Door",
	model = "mod_assets/models/secret_doors/temple_secret_door_wallchain.fbx",
	openSound = "wall_sliding",
	closeSound = "wall_sliding",
	lockSound = "wall_sliding_lock",
	openVelocity = 0.5,
	closeVelocity = -0.5,
	secretDoor = true,
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "temple_secret_door_wallchain_2",
	class = "Door",
	model = "mod_assets/models/secret_doors/temple_secret_door_wallchain_2.fbx",
	openSound = "wall_sliding",
	closeSound = "wall_sliding",
	lockSound = "wall_sliding_lock",
	openVelocity = 0.5,
	closeVelocity = -0.5,
	secretDoor = true,
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "temple_secret_door_wallhook",
	class = "Door",
	model = "mod_assets/models/secret_doors/temple_secret_door_wallhook.fbx",
	openSound = "wall_sliding",
	closeSound = "wall_sliding",
	lockSound = "wall_sliding_lock",
	openVelocity = 0.5,
	closeVelocity = -0.5,
	secretDoor = true,
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "temple_secret_door_window_1",
	class = "Door",
	model = "mod_assets/models/secret_doors/temple_secret_door_window_1.fbx",
	openSound = "wall_sliding",
	closeSound = "wall_sliding",
	lockSound = "wall_sliding_lock",
	openVelocity = 0.5,
	closeVelocity = -0.5,
	secretDoor = true,
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "temple_secret_door_window_1_transp",
	class = "Door",
	model = "mod_assets/models/secret_doors/temple_secret_door_window_1_transp.fbx",
	openSound = "wall_sliding",
	closeSound = "wall_sliding",
	lockSound = "wall_sliding_lock",
	openVelocity = 0.5,
	closeVelocity = -0.5,
	secretDoor = true,
	placement = "wall",
	editorIcon = 120,
}

-- bonus statues

defineObject{
	name = "sx_angelofdeath_statue",
	class = "Decoration",
	model = "mod_assets/models/secret_doors/sx_angelofdeath_statue.fbx",
	placement = "wall",
	replacesWall = false,
	editorIcon = 92,
}

defineObject{
	name = "sx_monk_statue",
	class = "Decoration",
	model = "mod_assets/models/secret_doors/sx_monk_statue.fbx",
	placement = "wall",
	replacesWall = true,
	statueBase = true,
	editorIcon = 92,
}