-- **************************************************************************************
--                                         OBJECTS
-- **************************************************************************************

-- Clone DX Objects
-- =================================================================================
local dxObjects = {
	"torch_holder",
	"torch_lit",
}

for _,objectName in ipairs(dxObjects) do
	defineObject{
		name = "dx_"..objectName,
		class = "Item",
		model = "mod_assets/models/env/"..objectName.."_dx.fbx",
		gfxIndex = 1,
		uiName = "dx"..objectName,
		castShadow = true,
		weight = 0.1,
		projectileRotationSpeed = 0,
		fragile = true,
	}
end