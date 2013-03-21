-- **************************************************************************************
--                                         MATERIALS
-- **************************************************************************************
   
defineMaterial{
	name = "sx_invisible",
	diffuseMap = "assets/textures/common/black.tga",
	doubleSided = false,
	lighting = false,
	alphaTest = true,
	blendMode = "Additive",
	textureAddressMode = "Clamp",
	glossiness = 0,
	depthBias = 0,
}

-- **************************************************************************************
--                                         OBJECTS
-- **************************************************************************************


-- Walls
-- =================================================================================

defineObject{
	name = "temple_wall",
	class = "Decoration",
	model = "assets/models/env/temple_wall_01.fbx",
	placement = "wall",
	editorIcon = 120,
}

cloneObject{
	name = "dx_temple_solid_wall",
	baseObject = "temple_secret_door",
	model = "assets/models/env/temple_wall_01.fbx",
}

defineObject{
	name = "dx_solid_wall",
	class = "Decoration",
	model = "mod_assets/models/sx_blocker.fbx",
	placement = "ceiling",
	editorIcon = 144,
}

-- Stairs
-- =================================================================================

defineObject{
	name = "dx_temple_stairs_up",
	class = "Stairs",
	model = "mod_assets/models/sx_blocker.fbx",
	down = false,
	editorIcon = 48,
}

defineObject{
	name = "dx_temple_stairs_down",
	class = "Stairs",
	model = "mod_assets/models/sx_blocker.fbx",
	down = true,
	editorIcon = 48,
}

defineObject{
	name = "_dx_temple_stairs",
	class = "Decoration",
	model = "mod_assets/models/env/temple_stairs.fbx",
	placement = "floor",
	editorIcon = 48,
}

-- Clone DX Objects
-- =================================================================================
local dxObjects = {
	"temple_wall",
	"temple_floor",
	"temple_ceiling",
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

-- Add DXS Objects:
local dxsObjects = {

}

for _,objectName in ipairs(dxsObjects) do
	defineObject{
		name = "dxs_"..objectName,
		class = "Item",
		model = "mod_assets/models/env/"..objectName.."_dxs.fbx",
		gfxIndex = 1,
		uiName = "dx"..objectName,
		castShadow = true,
		weight = 0.1,
		projectileRotationSpeed = 0,
		fragile = true,
	}
end


-- SX Objects
-- =================================================================================

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
	editorIcon = 124,
}

defineObject{
	name = "sx_remove_ceiling",
	class = "Decoration",
	model = "mod_assets/models/sx_blocker.fbx",
	placement = "ceiling",
	editorIcon = 104,
}

defineObject{
	name = "sx_remove_floor",
	class = "Decoration",
	model = "mod_assets/models/sx_blocker.fbx",
	replacesFloor = true,
	placement = "floor",
	editorIcon = 136,
}

defineObject{
	name = "dx_invisible_pit",
	class = "Pit",
	model = "mod_assets/models/sx_blocker.fbx",
	trapDoorModel = "assets/models/env/temple_pit_trapdoor.fbx",
	openAnim = "assets/animations/env/temple_pit_trapdoor_open.fbx",
	closeAnim = "assets/animations/env/temple_pit_trapdoor_close.fbx",
	placement = "floor",
	editorIcon = 40,
}
