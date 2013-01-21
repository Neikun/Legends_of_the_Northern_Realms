
defineMaterial{
	name = "sx_pinetree_branch_01",
	diffuseMap = "mod_assets/textures/sx_pinetree_branch_snow_dif.tga",
	specularMap = "mod_assets/textures/sx_pinetree_branch_snow_spec.tga",
	--normalMap = "mod_assets/textures/env/sx_seamless_rock_01_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = true,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 5,
	depthBias = 0,
}


defineMaterial{
	name = "sx_snowground_01",
	diffuseMap = "mod_assets/textures/sx_snowground_dif.tga",
	specularMap = "mod_assets/textures/sx_snowground_spec.tga",
	normalMap = "mod_assets/textures/sx_snowground_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,
}

defineMaterial{
	name = "sx_tree_trunk",
	diffuseMap = "mod_assets/textures/sx_tree_trunk_dif.tga",
	specularMap = "mod_assets/textures/sx_tree_trunk_spec.tga",
	normalMap = "mod_assets/textures/sx_tree_trunk_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 20,
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
	name = "sx_skydome",
	diffuseMap = "mod_assets/textures/sx_skydome_dif.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Translucent",
	textureAddressMode = "Wrap",
	glossiness = 5,
	depthBias = 0,
}




-- Objects

defineObject{
	name = "sx_remove_ceiling",
	class = "Decoration",
	model = "mod_assets/models/sx_blocker.fbx",
	placement = "ceiling",
	editorIcon = 104,
}

defineObject{
	name = "sx_pine_tree_large",
	class = "Decoration",
	model = "mod_assets/models/sx_pine_tree_large.fbx",
	placement = "pillar",
	editorIcon = 108,
}

defineObject{
	name = "sx_pine_tree_medium",
	class = "Decoration",
	model = "mod_assets/models/sx_pine_tree_medium.fbx",
	placement = "pillar",
	editorIcon = 108,
}

defineObject{
	name = "sx_pine_tree_small",
	class = "Decoration",
	model = "mod_assets/models/sx_pine_tree_small.fbx",
	placement = "pillar",
	editorIcon = 108,
}

defineObject{
	name = "sx_xmastree",
	class = "Decoration",
	model = "mod_assets/models/sx_xmastree.fbx",
	placement = "floor",
	editorIcon = 100,
}

defineObject{
	name = "sx_xmastree_pillar",
	class = "Decoration",
	model = "mod_assets/models/sx_xmastree.fbx",
	placement = "pillar",
	editorIcon = 108,
}

defineObject{
	name = "sx_xmas_balls",
	class = "Decoration",
	model = "mod_assets/models/sx_xmas_balls.fbx",
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "sx_snowground",
	class = "Decoration",
	model = "mod_assets/models/sx_snowground_01.fbx",
	placement = "floor",
	replacesFloor = true,
	editorIcon = 136,
}

defineObject{
	name = "sx_snowhill_01",
	class = "Decoration",
	model = "mod_assets/models/sx_snowhill_01.fbx",
	placement = "floor",
	replacesFloor = false,
	editorIcon = 136,
}

defineObject{
	name = "sx_snowhill_02",
	class = "Decoration",
	model = "mod_assets/models/sx_snowhill_02.fbx",
	placement = "floor",
	replacesFloor = false,
	editorIcon = 136,
}

defineObject{
	name = "sx_pinetree_wall_01",
	class = "Decoration",
	model = "mod_assets/models/sx_pinetree_wall_01.fbx",
	placement = "wall",
	replacesWall = true,
	editorIcon = 8,
}

defineObject{
	name = "sx_yulesnow",
	class = "LightSource",
	lightPosition = vec(0, 0.4, 0),
	lightRange = 0,
	 lightColor = vec(1, 1, 1),
	brightness = 1,
	castShadow = false,
	model = "mod_assets/models/sx_blocker.fbx",
	placement = "floor",
	particleSystem = "sx_yulesnow",
	particleSystemNode = "MainObject",
	replacesFloor = false,
	editorIcon = 136,
}

defineObject{
	name = "sx_skybox_snow_small",
	class = "Decoration",
	model = "mod_assets/models/sx_skybox_snow_small.fbx",
	placement = "floor",
	replacesFloor = false,
	editorIcon = 136,
}

defineObject{
	name = "sx_snowpile_01",
	class = "Decoration",
	model = "mod_assets/models/sx_snowpile_01.fbx",
	placement = "floor",
	replacesFloor = false,
	editorIcon = 100,
}

defineObject{
	name = "sx_northern_dungeon_wall_2ndstore",
	class = "Decoration",
	model = "mod_assets/models/sx_northern_dungeon_wall_2ndstore.fbx",
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "sx_northern_dungeon_pillar_2ndstore",
	class = "Decoration",
	model = "mod_assets/models/sx_northern_dungeon_pillar_2ndstore.fbx",
	placement = "pillar",
	editorIcon = 108,
}

defineObject{
	name = "sx_northern_dungeon_wall_3rdstore",
	class = "Decoration",
	model = "mod_assets/models/sx_northern_dungeon_wall_3rdstore.fbx",
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "sx_northern_dungeon_pillar_3rdstore",
	class = "Decoration",
	model = "mod_assets/models/sx_northern_dungeon_pillar_3rdstore.fbx",
	placement = "pillar",
	editorIcon = 108,
}

defineObject{
	name = "sx_northern_dungeon_wall_4thstore",
	class = "Decoration",
	model = "mod_assets/models/sx_northern_dungeon_wall_4thstore.fbx",
	placement = "wall",
	editorIcon = 120,
}

defineObject{
	name = "sx_northern_dungeon_pillar_4thstore",
	class = "Decoration",
	model = "mod_assets/models/sx_northern_dungeon_pillar_4thstore.fbx",
	placement = "pillar",
	editorIcon = 108,
}

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


-- Particles

defineParticleSystem{
 name = "sx_yulesnow",
 emitters = {
 -- glow
 {
 emissionRate = 150,
 emissionTime = 0,
 spawnBurst = false,
 maxParticles =300,
 boxMin = {-1.3,-1,-1.3},
 boxMax = {1.3,5,1.3},
 objectSpace = true,
 sprayAngle = {0,1},
 velocity = {0,0},
 texture = "assets/textures/particles/glow.tga",
 lifetime = {100000, 100000},
 colorAnimation = false,
 color0 = {1, 1, 1},
 opacity = 0.7,
 fadeIn = 0.4,
 fadeOut = 4.0,
 size = {0.03, 0.01},
 gravity = {0,-2,0},
 airResistance = 1,
 rotationSpeed = 8,
 blendMode = "Additive",
 }
 }
}