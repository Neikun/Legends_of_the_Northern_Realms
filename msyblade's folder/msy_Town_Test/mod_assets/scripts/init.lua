-- This file has been generated by Dungeon Editor 1.3.6



import "mod_assets/scripts/flooded_dungeon.lua"

import "mod_assets/wall_plaques/scripts/wall_plaques.lua"

import "mod_assets/log_carpets/log_carpets.lua"

-- import standard assets
import "assets/scripts/standard_assets.lua"
-- please insert into ini.lua: import "mod_assets/grim_bed/grim_bed.lua"
-- Grimrock Bed (Object) by germanny

defineObject{
   name = "grim_bed",
   class = "Altar",
   model = "mod_assets/grim_bed/models/env/grim_bed.fbx",
   placement = "floor",
   editorIcon = 52,
   }

-- Grimrock Bed Textures
-- Change the diffuse texture to 'grim_bed_dif1.tga' for grey sheet!
defineMaterial{
	name = "grim_bed",
	diffuseMap = "mod_assets/grim_bed/textures/env/grim_bed_dif.tga",
	specularMap = "mod_assets/grim_bed/textures/env/grim_bed_spec.tga",
	normalMap = "mod_assets/grim_bed/textures/env/grim_bed_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 40,
	depthBias = 0,
}


-- import custom assets
import "mod_assets/scripts/items.lua"
import "mod_assets/scripts/monsters.lua"
import "mod_assets/scripts/objects.lua"
import "mod_assets/scripts/wall_sets.lua"
import "mod_assets/scripts/recipes.lua"
import "mod_assets/scripts/spells.lua"
import "mod_assets/scripts/materials.lua"
import "mod_assets/scripts/sounds.lua"
import "mod_assets/sx_towntileset/scripts/sx_towntileset.lua"
import "mod_assets/sx_forest_autumn/scripts/sx_forest_autumn_tileset.lua"