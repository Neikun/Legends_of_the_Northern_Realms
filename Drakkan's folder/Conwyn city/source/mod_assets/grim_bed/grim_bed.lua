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