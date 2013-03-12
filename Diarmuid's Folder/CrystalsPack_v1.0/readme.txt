#####    Custom Crystals System, Version 1.0    #####
#####  Scripting & Design by Diarmuid & Neikun  #####


[[[[[ SETUP INSTRUCTIONS: ]]]]]
----------------------------------------------------------------------------------
	1. copy animations, models, scripts and textures folders to your mod_assets folder
	2. add the following line at the end of your init.lua:
		import "mod_assets/scripts/crystals.lua"
	3. create a script_entity named crystalHandler in the dungeon editor
	4. copy the contents of crystalHandler.lua into this crystalHandler script entity.


[[[[[ THIS PACK CONTAINS: ]]]]]]

1. models and textures for the following 7 crystal colors:
----------------------------------------------------------------------------------
	- green
	- red
	- pink
	- orange
	- yellow
	- black
	- white

	TO USE THE CRYSTALS:
	Simply put the dx_healing_crystal_object_color object in the editor like a normal crystal. That's it!

	### WARNING ###
	!!! DO NOT use directly any of the crystal components that start with the | character: "|dx...". 
	Those objects have a red X icon and appear at the end of the objects list.
	Make sure you use the ones starting with underscore "dx_..."!!!
	### WARNING ###


2. crystals.lua: 
----------------------------------------------------------------------------------
	A modular lua file which generates the crystal objects and components.


	### WARNING ###
	!!! DO NOT change anything in this file except in the Define Crystals section in the end. !!!
	### WARNING ###

	If you wish to add custom colors, the crystals are defined with the following syntax:

	defineCrystal{
		color = "green",
		lightColor = {0.5,1,0.5},
		particleFogColor = {0.15, 0.80, 0.35},
		particleStarsColor = {1.0,4.0,1.0},
	}

	for the defineCrystal function to work, you must create the following files, replacing "green" with the color you want to define:
		- dx_healing_crystal_green.dds (texture)
		- dx_healing_crystal_shader_green.dds (texture)
		- dx_healing_crystal_green.model (model, which has dx_healing_crystal_crystal_green 
			set as material for all 5 meshes in the GMT)
		- dx_healing_crystal_shader_green.model (model, which has dx_healing_crystal_shader_green set as material in the GMT)

	Use the provided models and textures as basis for your own crystals, and do not forget to add their functionnality in the
	onCrystalClick function in the script entity.



3. crystalHandler script: 
----------------------------------------------------------------------------------
	This must be copied in the dungeon editor in a scriptEntity named crystalHandler, and controls the crystals behaviour.

	
	By default, all crystals heal the party when clicking on them. You can however change 
	what the crystals do by putting your own function at the end of the crystalHandler script.

	There is a global onCrystalClick(crystal) function which is called when you click an active crystal.
	The crystal object is passed as a parameter, and you can use the following properties to write custom functions:

		crystal.color : the color of the crystal
		crystal.id : the id of the crystal entity
		crystal.level, crystal.x, crystal.y : the position of the crystal
		crystal.active : true/false, state of the crystal


	### WARNING ###
	!!! DO NOT set anything in the crystal object table, even if lua allows you to, to not break it. 
	Treat them as read-only properties. !!!
	### WARNING ###

	if you return false from onCrystalClick, you will prevent the crystal from deactivating. This can 
	be used to allow the crystal to be "used" only under certain conditions.

	Two functions are also provided for handling crystals:

	- crystalHandler.spawnCrystal(color, level, x, y, id)
	
		color: a string with a valid defined color
		level, x, y: position to spawn the crystal
		id: a string with the unique id to give to the crystal
		
	- crystalHandler.destroyCrystal(id)
		id: a string with the id of the crystal to destroy

