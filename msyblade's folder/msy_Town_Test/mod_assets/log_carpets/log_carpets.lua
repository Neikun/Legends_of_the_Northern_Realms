-- Carpet for Legend of Grimrock
-- by Germanny 01/2013
-- please insert into init.lua: import "mod_assets/log_carpets/log_carpets.lua"


defineObject{
	name = "log_carpet_a",
	class = "Decoration",
	model = "mod_assets/log_carpets/models/env/log_carpet_a.fbx",
	placement = "floor",
	replacesFloor = false,
	editorIcon = 52,
}

defineMaterial{
	name = "log_carpet_a",
	diffuseMap = "mod_assets/log_carpets/textures/env/log_carpet_a_dif.tga",
	specularMap = "mod_assets/log_carpets/textures/env/log_carpet_a_spec.tga",
	normalMap = "mod_assets/log_carpets/textures/env/log_carpet_a_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = true,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 10,
	depthBias = 0,
}

