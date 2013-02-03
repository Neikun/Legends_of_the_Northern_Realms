-- Small Tapestries

cloneObject {
    name = "temple_mosaic_wall_ku_1",
    baseObject = "temple_mosaic_wall_1",
    model = "mod_assets/models/env/temple_mosaic_wall_ku_01.fbx",
}

cloneObject {
    name = "temple_mosaic_wall_ku_2",
    baseObject = "temple_mosaic_wall_2",
    model = "mod_assets/models/env/temple_mosaic_wall_ku_02.fbx",
}

cloneObject {
    name = "temple_mosaic_wall_dain_1",
    baseObject = "temple_mosaic_wall_1",
    model = "mod_assets/models/env/temple_mosaic_wall_dain_01.fbx",
}

cloneObject {
    name = "temple_mosaic_wall_dain_2",
    baseObject = "temple_mosaic_wall_2",
    model = "mod_assets/models/env/temple_mosaic_wall_dain_02.fbx",
}

cloneObject {
    name = "temple_mosaic_wall_ros_1",
    baseObject = "temple_mosaic_wall_1",
    model = "mod_assets/models/env/temple_mosaic_wall_ros_01.fbx",
}

cloneObject {
    name = "temple_mosaic_wall_ros_2",
    baseObject = "temple_mosaic_wall_2",
    model = "mod_assets/models/env/temple_mosaic_wall_ros_02.fbx",
}



-- Floor tiles

defineObject{
	name = "temple_floor_ku_01",
	class = "Decoration",
	model = "mod_assets/models/env/temple_floor_ku_01.fbx",
	placement = "floor",
	replacesFloor = true,
	editorIcon = 136,
}

defineObject{
	name = "temple_floor_ku_02",
	class = "Decoration",
	model = "mod_assets/models/env/temple_floor_ku_02.fbx",
	placement = "floor",
	replacesFloor = true,
	editorIcon = 136,
}

defineObject{
	name = "temple_floor_dain_01",
	class = "Decoration",
	model = "mod_assets/models/env/temple_floor_dain_01.fbx",
	placement = "floor",
	replacesFloor = true,
	editorIcon = 136,
}

defineObject{
	name = "temple_floor_dain_02",
	class = "Decoration",
	model = "mod_assets/models/env/temple_floor_dain_02.fbx",
	placement = "floor",
	replacesFloor = true,
	editorIcon = 136,
}

defineObject{
	name = "temple_floor_ros_01",
	class = "Decoration",
	model = "mod_assets/models/env/temple_floor_ros_01.fbx",
	placement = "floor",
	replacesFloor = true,
	editorIcon = 136,
}

defineObject{
	name = "temple_floor_ros_02",
	class = "Decoration",
	model = "mod_assets/models/env/temple_floor_ros_02.fbx",
	placement = "floor",
	replacesFloor = true,
	editorIcon = 136,
}



-- Large Tapestries

cloneObject {
    name = "gobelin_ku",
    baseObject = "gobelin",
    model = "mod_assets/models/env/gobelin_ku.fbx",
    brokenModel = "mod_assets/models/env/gobelin_ku_torn.fbx",
}

cloneObject {
    name = "gobelin_ros",
    baseObject = "gobelin",
    model = "mod_assets/models/env/gobelin_ros.fbx",
    brokenModel = "mod_assets/models/env/gobelin_ros_torn.fbx",
}

cloneObject {
    name = "gobelin_dain",
    baseObject = "gobelin",
    model = "mod_assets/models/env/gobelin_dain.fbx",
    brokenModel = "mod_assets/models/env/gobelin_dain_torn.fbx",
}



-- Doors

cloneObject{
	name = "third_circle_door_ku",
	baseObject = "temple_door_iron",
	model = "mod_assets/models/env/third_circle_door_ku.fbx",
	doorFrameModel = "assets/models/env/temple_door_frame.fbx",
	pullChainModel = "assets/models/env/door_pullchain.fbx",
	pullChainAnim = "assets/animations/env/door_pullchain.fbx",
	openVelocity = 1.1,
}