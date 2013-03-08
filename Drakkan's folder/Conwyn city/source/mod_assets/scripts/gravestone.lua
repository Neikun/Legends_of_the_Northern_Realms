defineObject{
    name = "gravestone_01",
    class = "Blockage",
	model = "mod_assets/models/gravestone_01.fbx",
    placement = "floor",
	repelProjectiles = true,
	hitSound = "impact_blade",
	editorIcon = 56,
}

defineObject{
    name = "gravestone_02",
    class = "Blockage",
	model = "mod_assets/models/gravestone_02.fbx",
    placement = "floor",
	repelProjectiles = true,
	hitSound = "impact_blade",
	editorIcon = 56,
}

defineObject{
    name = "gravestone_03",
    class = "Blockage",
	model = "mod_assets/models/gravestone_03.fbx",
    placement = "floor",
	repelProjectiles = true,
	hitSound = "impact_blade",
	editorIcon = 56,
}

defineObject{
    name = "gravestone_04",
    class = "Blockage",
	model = "mod_assets/models/gravestone_04.fbx",
    placement = "floor",
	repelProjectiles = true,
	hitSound = "impact_blade",
	editorIcon = 56,
}

defineMaterial{
	name = "gravestones",
	diffuseMap = "mod_assets/textures/gravestones_dif.tga",
	specularMap = "mod_assets/textures/gravestones_spec.tga",
	normalMap = "mod_assets/textures/gravestones_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,
}