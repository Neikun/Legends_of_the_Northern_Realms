-- This file has been generated by Dungeon Editor 1.3.6

--- level 1 ---

mapName("Unnamed")
setWallSet("dungeon")
playStream("assets/samples/music/dungeon_ambient.ogg")
mapDesc([[
################################
################################
################################
################################
################################
################################
################################
################################
################################
################################
################################
################################
################################
################################
#############.....##############
#############.#...##############
#############...#.##############
#############.....##############
################################
################################
################################
################################
################################
################################
################################
################################
################################
################################
################################
################################
################################
################################
]])
spawn("starting_location", 15,15,0, "starting_location")
spawn("torch_holder", 15,14,0, "torch_holder_1")
	:addTorch()
spawn("dungeon_alcove", 14,14,0, "dungeon_alcove_1")
	:addItem(spawn("broken_saber"))
spawn("dungeon_alcove", 13,14,0, "dungeon_alcove_2")
	:addItem(spawn("dragon_cape"))
spawn("dungeon_alcove", 13,14,3, "dungeon_alcove_3")
	:addItem(spawn("dragon_gauntlets"))
spawn("dungeon_alcove", 13,15,3, "dungeon_alcove_4")
	:addItem(spawn("dragon_sword"))
spawn("dungeon_alcove", 13,16,3, "dungeon_alcove_5")
	:addItem(spawn("pool_ball"))
spawn("dungeon_alcove", 13,17,3, "dungeon_alcove_6")
	:addItem(spawn("raekenierh"))
spawn("dungeon_alcove", 13,17,2, "dungeon_alcove_7")
	:addItem(spawn("shield_cavalier"))
spawn("dungeon_alcove", 14,17,2, "dungeon_alcove_8")
	:addItem(spawn("emerald_sceptre"))
spawn("dungeon_alcove", 15,17,2, "dungeon_alcove_9")
	:addItem(spawn("darkwood_wand"))
spawn("dungeon_alcove", 16,17,2, "dungeon_alcove_10")
	:addItem(spawn("zokathra"))
spawn("dungeon_alcove", 17,17,2, "dungeon_alcove_11")
	:addItem(spawn("katana"))
spawn("dungeon_alcove", 17,17,1, "dungeon_alcove_12")
	:addItem(spawn("rose_circlet"))
spawn("dungeon_alcove", 17,16,1, "dungeon_alcove_13")
	:addItem(spawn("tanto"))
spawn("dungeon_alcove", 17,15,1, "dungeon_alcove_14")
	:addItem(spawn("ninja_gi"))
spawn("dungeon_alcove", 17,14,1, "dungeon_alcove_15")
	:addItem(spawn("grim_eye"))
spawn("dungeon_alcove", 17,14,0, "dungeon_alcove_16")
spawn("dungeon_alcove", 16,14,0, "dungeon_alcove_17")
spawn("torch_holder", 14,16,0, "torch_holder_2")
	:addTorch()
spawn("torch_holder", 16,15,2, "torch_holder_3")
	:addTorch()
spawn("torch_holder", 16,17,0, "torch_holder_4")
	:addTorch()
spawn("barb", 17,15,3, "barb_1")
spawn("barb", 17,14,3, "barb_2")
