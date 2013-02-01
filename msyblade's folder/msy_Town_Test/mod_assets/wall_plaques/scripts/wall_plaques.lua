-- Combined Lua definition file for the Wall Plaques
--
-- Author: John Wordsworth <john@johnwordsworth.com>
-- Date: 7th December 2012
-- Usage: Please feel free to use in your mods. 
-- If you do use, a thank you in the credits would be nice! 



--
-- Wall Plaque Materials
--
defineMaterial{
	name = "jw_wall_plaque",
	diffuseMap = "mod_assets/wall_plaques/textures/jw_wall_plaque_dif.tga",
	specularMap = "mod_assets/wall_plaques/textures/jw_wall_plaque_spec.tga",
	normalMap = "mod_assets/wall_plaques/textures/jw_wall_plaque_norm.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 45,
	depthBias = 0,
}

defineMaterial{
	name = "jw_wall_plaque_weathered",
	diffuseMap = "mod_assets/wall_plaques/textures/jw_wall_plaque_weathered_dif.tga",
	specularMap = "mod_assets/wall_plaques/textures/jw_wall_plaque_weathered_spec.tga",
	normalMap = "mod_assets/wall_plaques/textures/jw_wall_plaque_weathered_norm.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 15,
	depthBias = 0,
}


--
-- Wall Plaque Objects
--

defineObject{
	name = "temple_catacomb_plaque_low",
	class = "WallText",
	model = "mod_assets/wall_plaques/models/jw_temple_catacomb_plaque_low.fbx",
	placement = "wall",
	replacesWall = false,
	editorIcon = 28,
}

defineObject{
	name = "temple_catacomb_plaque_high",
	class = "WallText",
	model = "mod_assets/wall_plaques/models/jw_temple_catacomb_plaque_high.fbx",
	placement = "wall",
	replacesWall = false,
	editorIcon = 28,
}

defineObject{
	name = "dungeon_catacomb_plaque_low",
	class = "WallText",
	model = "mod_assets/wall_plaques/models/jw_dungeon_catacomb_plaque_low.fbx",
	placement = "wall",
	replacesWall = false,
	editorIcon = 28,
}

defineObject{
	name = "dungeon_catacomb_plaque_high",
	class = "WallText",
	model = "mod_assets/wall_plaques/models/jw_dungeon_catacomb_plaque_high.fbx",
	placement = "wall",
	replacesWall = false,
	editorIcon = 28,
}

defineObject{
	name = "dungeon_wall_plaque",
	class = "WallText",
	model = "mod_assets/wall_plaques/models/jw_dungeon_wall_plaque.fbx",
	placement = "wall",
	replacesWall = false,
	editorIcon = 28,
}

defineObject{
	name = "temple_wall_plaque",
	class = "WallText",
	model = "mod_assets/wall_plaques/models/jw_temple_wall_plaque.fbx",
	placement = "wall",
	replacesWall = false,
	editorIcon = 28,
}

defineObject{
	name = "prison_wall_plaque",
	class = "WallText",
	model = "mod_assets/wall_plaques/models/jw_prison_wall_plaque.fbx",
	placement = "wall",
	replacesWall = false,
	editorIcon = 28,
}

-- Weathered Copies

defineObject{
	name = "temple_catacomb_plaque_low_weathered",
	class = "WallText",
	model = "mod_assets/wall_plaques/models/jw_temple_catacomb_plaque_low_weathered.fbx",
	placement = "wall",
	replacesWall = false,
	editorIcon = 28,
}

defineObject{
	name = "temple_catacomb_plaque_high_weathered",
	class = "WallText",
	model = "mod_assets/wall_plaques/models/jw_temple_catacomb_plaque_high_weathered.fbx",
	placement = "wall",
	replacesWall = false,
	editorIcon = 28,
}

defineObject{
	name = "dungeon_catacomb_plaque_low_weathered",
	class = "WallText",
	model = "mod_assets/wall_plaques/models/jw_dungeon_catacomb_plaque_low_weathered.fbx",
	placement = "wall",
	replacesWall = false,
	editorIcon = 28,
}

defineObject{
	name = "dungeon_catacomb_plaque_high_weathered",
	class = "WallText",
	model = "mod_assets/wall_plaques/models/jw_dungeon_catacomb_plaque_high_weathered.fbx",
	placement = "wall",
	replacesWall = false,
	editorIcon = 28,
}

defineObject{
	name = "dungeon_wall_plaque_weathered",
	class = "WallText",
	model = "mod_assets/wall_plaques/models/jw_dungeon_wall_plaque_weathered.fbx",
	placement = "wall",
	replacesWall = false,
	editorIcon = 28,
}

defineObject{
	name = "temple_wall_plaque_weathered",
	class = "WallText",
	model = "mod_assets/wall_plaques/models/jw_temple_wall_plaque_weathered.fbx",
	placement = "wall",
	replacesWall = false,
	editorIcon = 28,
}

defineObject{
	name = "prison_wall_plaque_weathered",
	class = "WallText",
	model = "mod_assets/wall_plaques/models/jw_prison_wall_plaque_weathered.fbx",
	placement = "wall",
	replacesWall = false,
	editorIcon = 28,
}