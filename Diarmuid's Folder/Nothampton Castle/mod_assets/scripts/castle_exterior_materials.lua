-- "Northern Dungeon" is a modified copy of the "Dungeon" wall set from Legend of Grimrock
-- All original models, textures etc. used in this wall set are copyright (C) Almost Human Ltd.
-- For more details on using and redistributing these assets, please visit: http://www.grimrock.net/modding/modding-and-asset-usage-terms/



defineMaterial{
   name = "castle_stone",
   diffuseMap = "mod_assets/textures/castle_exterior/castle_stone_dif.tga",
   specularMap = "mod_assets/textures/castle_exterior/castle_stone_spec.tga",
   doubleSided = true,
   lighting = true,
   alphaTest = false,
   blendMode = "Opaque",
   textureAddressMode = "Clamp",
   glossiness = 30,
   depthBias = 0,
   }
   
defineMaterial{
   name = "sky",
   diffuseMap = "mod_assets/textures/castle_exterior/sky.tga",
   doubleSided = true,
   lighting = true,
   alphaTest = false,
   blendMode = "Opaque",
   textureAddressMode = "Clamp",
   glossiness = 30,
   depthBias = 2,
   }
   
defineMaterial{
   name = "castle_stone_red",
   diffuseMap = "mod_assets/textures/castle_exterior/castle_stone_red_dif.tga",
   specularMap = "mod_assets/textures/castle_exterior/castle_stone_spec.tga",
   doubleSided = true,
   lighting = true,
   alphaTest = false,
   blendMode = "Opaque",
   textureAddressMode = "Clamp",
   glossiness = 30,
   depthBias = 0,
   }

defineMaterial{
   name = "castle_wall",
   diffuseMap = "mod_assets/textures/castle_exterior/castle_wall_dif.tga",
   specularMap = "mod_assets/textures/castle_exterior/castle_stone_spec.tga",
   doubleSided = false,
   lighting = true,
   alphaTest = false,
   blendMode = "Opaque",
   textureAddressMode = "Clamp",
   glossiness = 30,
   depthBias = 0,
   }
   
defineMaterial{
   name = "castle_window",
   diffuseMap = "mod_assets/textures/castle_exterior/black.tga",
   specularMap = "mod_assets/textures/castle_exterior/black.tga",
   doubleSided = false,
   lighting = true,
   alphaTest = false,
   blendMode = "Opaque",
   textureAddressMode = "Clamp",
   glossiness = 10,
   depthBias = 0,
   }