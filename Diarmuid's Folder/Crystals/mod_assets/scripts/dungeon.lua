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
#############.......############
#############.......############
#############.......############
###########.#.......############
#############.......############
#############.......############
#############.......############
#############.......############
#############.......############
#############.......############
#############.......############
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
spawn("torch_holder", 11,14,0, "torch_holder_1")
	:addTorch()
spawn("script_entity", 8,12,0, "crystalHandler")
	:setSource("crystalObjects = {}\
\
-- *****************************************************************************************\
--                                    CRYSTAL FUNCTIONS\
-- *****************************************************************************************\
\
function createCrystals()\
\
\9for level = 1, getMaxLevels() do\
\
\9\9for x = 0,31 do\
\9\9\9\
\9\9\9for y = 0,31 do\
\9\9\9\9\
\9\9\9\9for i in entitiesAt(level, x, y) do\
\9\9\9\9\9\
\9\9\9\9\9if string.find(i.name, \"dx_healing_crystal_object_\") then\
\9\9\9\9\9\9\
\9\9\9\9\9\9-- Create crystal lua object and IDs\
\9\9\9\9\9\9crystalObjects[i.id] = {}\
\9\9\9\9\9\9local crystal = crystalObjects[i.id]\
\9\9\9\9\9\9crystal.color = string.sub(i.name, 27)\
\9\9\9\9\9\9crystal.id = i.id\
\9\9\9\9\9\9crystal.activated = crystal.id..\"_activated\"\
\9\9\9\9\9\9crystal.deactivated = crystal.id..\"_deactivated\"\
\9\9\9\9\9\9crystal.lights = {}\
\9\9\9\9\9\9crystal.dimLights = {}\
\9\9\9\9\9\9crystal.gratings = {}\
\9\9\9\9\9\9for j = 0, 3 do\
\9\9\9\9\9\9\9crystal.lights[j] = crystal.id..\"_light_\"..j\
\9\9\9\9\9\9\9crystal.dimLights[j] = crystal.id..\"_dimLight_\"..j\
\9\9\9\9\9\9\9crystal.gratings[j] = crystal.id..\"_grating_\"..j\
\9\9\9\9\9\9end\
\9\9\9\9\9\9crystal.topLight = crystal.id..\"_topLight\"\
\9\9\9\9\9\9crystal.bottomLight = crystal.id..\"_bottomLight\"\
\9\9\9\9\9\9crystal.particleSystem = crystal.id..\"_particleSystem\"\
\9\9\9\9\9\9crystal.altar = crystal.id..\"_altar\"\
\9\9\9\9\9\9crystal.timer = crystal.id..\"_timer\"\
\9\9\9\9\9\9crystal.fakeItem = crystal.id..\"_fakeItem\"\
\9\9\9\9\9\9crystal.animTimerActivated = crystal.id..\"_animTimer1\"\
\9\9\9\9\9\9crystal.animTimerDeactivated = crystal.id..\"_animTimer2\"\
\9\9\9\9\9\9\
\9\9\9\9\9\9-- Set it to active\
\9\9\9\9\9\9crystal.active = true\
\9\9\9\9\9\9\
\9\9\9\9\9\9-- Spawn activated state\
\9\9\9\9\9\9spawn(\"_dx_healing_crystal_\"..crystal.color, level, x, y, 0, crystal.activated)\
\9\9\9\9\9\9\9:addTrapDoor()\
\9\9\9\9\9\9\9:setPitState(\"open\")\
\9\9\9\9\9\9\9:close()\
\9\9\9\9\9\9\9\9\9\9\9\9\
\9\9\9\9\9\9-- Play crystal sounds\
\9\9\9\9\9\9for j = 0, 3 do\
\9\9\9\9\9\9\9local dx, dy = getForward(j)\
\9\9\9\9\9\9\9playSoundAt(\"crystal_ambient\", level, x+dx, y+dy)\
\9\9\9\9\9\9end\
\9\9\9\9\9\9\
\9\9\9\9\9\9-- Spawn shader projectile and register ID\
\9\9\9\9\9\9crystal.shader = shootProjectileWithId(\"_dx_healing_crystal_shader_\"..crystal.color,level,x,y,0,0,0,0,0,14,0,0,party,true)\
\9\9\9\9\9\9\
\9\9\9\9\9\9-- Spawn lights & particles lightsources\
\9\9\9\9\9\9for j = 0,3 do\
\9\9\9\9\9\9\9spawn(\"_dx_healing_crystal_light_\"..crystal.color, level, x, y, j, crystal.lights[j])\
\9\9\9\9\9\9\9spawn(\"_dx_healing_crystal_light_deactivated_\"..crystal.color, level, x, y, j, crystal.dimLights[j]):deactivate()\
\9\9\9\9\9\9end\
\9\9\9\9\9\9spawn(\"_dx_healing_crystal_top_light_\"..crystal.color, level, x, y, 0, crystal.topLight)\
\9\9\9\9\9\9spawn(\"_dx_healing_crystal_bottom_light_\"..crystal.color, level, x, y, 0, crystal.bottomLight)\
\9\9\9\9\9\9\
\9\9\9\9\9\9spawn(\"_dx_healing_crystal_particleSystem_\"..crystal.color, level, x, y, 0, crystal.particleSystem)\
\9\9\9\9\9\9\
\9\9\9\9\9\9-- Spawn altar and fake item\
\9\9\9\9\9\9spawn(\"_dx_healing_crystal_altar\", level, x, y, 0, crystal.altar)\
\9\9\9\9\9\9\9:addItem(spawn(\"_dx_healing_crystal_fake_item\",nil,nil,nil,nil,crystal.fakeItem))\
\9\9\9\9\9\9\9:addConnector(\"deactivate\", \"crystalHandler\", \"useCrystal\")\
\9\9\9\9\9\9\9\
\9\9\9\9\9\9-- Spawn crystal timers\
\9\9\9\9\9\9spawn(\"timer\", level, x, y, 0, crystal.timer)\
\9\9\9\9\9\9\9:setTimerInterval(120)\
\9\9\9\9\9\9\9:addConnector(\"activate\", \"crystalHandler\", \"reactivateCrystal\")\
\9\9\9\9\9\9spawn(\"timer\", level, x, y, 0, crystal.animTimerActivated)\
\9\9\9\9\9\9\9:setTimerInterval(14)\
\9\9\9\9\9\9\9:addConnector(\"activate\", \"crystalHandler\", \"crystalAnimation\")\
\9\9\9\9\9\9\9:activate()\
\9\9\9\9\9\9spawn(\"timer\", level, x, y, 0, crystal.animTimerDeactivated)\
\9\9\9\9\9\9\9:setTimerInterval(40)\
\9\9\9\9\9\9\9:addConnector(\"activate\", \"crystalHandler\", \"crystalAnimation\")\
\9\9\9\9\9\9\9\
\9\9\9\9\9\9-- Spawn gratings\
\9\9\9\9\9\9for j = 0, 3 do\
\9\9\9\9\9\9\9spawn(\"_dx_healing_crystal_grating\", level, x, y, j, crystal.gratings[j])\
\9\9\9\9\9\9end\
\9\9\9\9\9end\
\9\9\9\9\
\9\9\9\9end\
\9\9\9\
\9\9\9end\
\9\9\
\9\9end\
\9\
\9end\
\9\
end\
\
\
function crystalAnimation(timer)\
\
\9-- Retrieve crystal lua object by extracting its id from the timer id\
\9local crystal = crystalObjects[string.sub(timer.id,0,-12)]\
\9local level, x, y = timer.level, timer.x, timer.y\
\9\
\9if crystal.active == true then\
\9\
\9\9if findEntity(crystal.activated) then\
\9\9\
\9\9\9findEntity(crystal.activated):setPitState(\"open\")\
\9\9\9findEntity(crystal.activated):close()\
\9\9\9\
\9\9\9for i = 0, 3 do\
\9\9\9\9local dx, dy = getForward(i)\
\9\9\9\9playSoundAt(\"crystal_ambient\", level, x+dx, y+dy)\
\9\9\9end\
\9\9\9\
\9\9else\
\9\9\
\9\9\9findEntity(crystal.deactivated):destroy()\
\9\9\9\
\9\9\9-- Spawn deactivated state\
\9\9\9spawn(\"_dx_healing_crystal_\"..crystal.color, level, x, y, 0, crystal.activated)\
\9\9\9\9:addTrapDoor()\
\9\9\9\9:setPitState(\"open\")\
\9\9\9\9:close()\
\9\9\9\9\
\9\9\9findEntity(crystal.animTimerActivated):activate()\
\9\9\9findEntity(crystal.animTimerDeactivated):deactivate()\
\9\9\
\9\9end\
\9\9\
\9else\
\9\
\9\9if findEntity(crystal.activated) then\
\9\9\
\9\9\9findEntity(crystal.activated):destroy()\
\9\9\9\
\9\9\9-- Spawn deactivated state\
\9\9\9spawn(\"_dx_healing_crystal_deactivated_\"..crystal.color, level, x, y, 0, crystal.deactivated)\
\9\9\9\9:addTrapDoor()\
\9\9\9\9:setPitState(\"open\")\
\9\9\9\9:close()\
\9\9\9\
\9\9\9findEntity(crystal.animTimerDeactivated):activate()\
\9\9\9findEntity(crystal.animTimerActivated):deactivate()\
\9\9\9\
\9\9else\
\9\9\
\9\9\9findEntity(crystal.deactivated):setPitState(\"open\")\
\9\9\9findEntity(crystal.deactivated):close()\
\9\9\
\9\9end\
\9\9\
\9end\
\
end\
\
\
function useCrystal(altar)\
\9\9\
\9-- Retrieve crystal lua object by extracting its id from the altar id\
\9local crystal = crystalObjects[string.sub(altar.id,0,-7)]\
\9local level, x, y = altar.level, altar.x, altar.y\9\
\9\
\9-- Respawn item on altar\
\9setMouseItem(nil)\
\9altar:addItem(spawn(\"_dx_healing_crystal_fake_item\",nil,nil,nil,nil,crystal.fakeItem))\
\9\
\9if crystal.active then\
\9\
\9\9-- Call Crystal Hook\
\9\9if crystal.color == \"green\" then\
\9\9\9onGreenCrystalClick(crystal)\
\9\9end\
\9\9\
\9\9-- Turn off activated state lights and turn on deactivated state lights\
\9\9for i = 0,3 do\
\9\9\9findEntity(crystal.lights[i]):deactivate()\
\9\9\9findEntity(crystal.dimLights[i]):activate()\
\9\9end\
\9\9findEntity(crystal.topLight):deactivate()\
\9\9findEntity(crystal.bottomLight):deactivate()\
\9\9\
\9\9-- Turn off particle system\
\9\9findEntity(crystal.particleSystem):deactivate()\
\9\9\
\9\9-- Spawn fadeout partile system\
\9\9spawn(\"fx\", altar.level, altar.x, altar.y, 0)\
\9\9\9:setParticleSystem(\"dx_healing_crystal_fade_\"..crystal.color)\
\9\9\9:setLight(0,0,0,1,0,8,false)\
\9\9\
\9\9-- Destroy shader projectile\
\9\9findEntity(crystal.shader):destroy()\
\
\9\9-- Start timer\
\9\9findEntity(crystal.id..\"_timer\"):activate()\
\9\9\
\9\9-- Deactivate crystal\
\9\9crystal.active = false\
\9\
\9end\
\9\
end\
\
\
function reactivateCrystal(timer)\
\
\9-- Retrieve crystal lua object by extracting its id from the timer id\
\9local crystal = crystalObjects[string.sub(timer.id,0,-7)]\
\9local level, x, y = timer.level, timer.x, timer.y\
\9\9\
\9-- Turn off deactivated state lights and turn on activated state lights\
\9for i = 0,3 do\
\9\9findEntity(crystal.lights[i]):activate()\
\9\9findEntity(crystal.dimLights[i]):deactivate()\
\9end\
\9findEntity(crystal.topLight):activate()\
\9findEntity(crystal.bottomLight):activate()\
\9\
\9-- Turn on particle system\
\9findEntity(crystal.particleSystem):activate()\
\
\9-- Spawn shader projectile and register ID\
\9crystal.shader = shootProjectileWithId(\"_dx_healing_crystal_shader_\"..crystal.color,level,x,y,0,0,0,0,0,14,0,0,party,true)\
\
\9-- Stop timer\
\9findEntity(crystal.id..\"_timer\"):deactivate()\
\9\
\9-- Reactivate crystal\
\9crystal.active = true\
\9\
end\
\
function cancelAltar(altar)\
\
\9for i in altar:containedItems() do\
\9\
\9\9if i.name ~= \"_dx_healing_crystal_fake_item\" then\
\9\9\9setMouseItem(spawn(i.name))\
\9\9\9i:destroy()\
\9\9end\
\9\9\
\9end\
\9\
end\
\
\
-- *****************************************************************************************\
--                                    HELPER FUNCTIONS\
-- *****************************************************************************************\
\
function shootProjectileWithId(projName,level,x,y,dir,speed,gravity,velocityUp,offsetX,offsetY,offsetZ,attackPower, ignoreEntity,fragile,championOrdinal)\
\9local pIds = {}\
\9\
\9for i in entitiesAt(level, x, y) do\
\9\9if i.class == \"Item\" and string.find(i.id, \"^%d+$\") then\
\9\9\9pIds[i.id] = i.name\
\9\9end\
\9end\
\9\
\9shootProjectile(projName,level,x,y,dir,speed,gravity,velocityUp,offsetX,offsetY,offsetZ,attackPower, ignoreEntity,fragile,championOrdinal)\
 \9\
\9for i in entitiesAt(level, x, y) do\
\9\9if i.class == \"Item\" and string.find(i.id, \"^%d+$\") and not(pIds[i.id]) then\
\9\9\9return i.id\
\9\9end\
\9end  \
\
end\
\
-- *****************************************************************************************\
--                                           INIT\
-- *****************************************************************************************\
\
createCrystals()\
\
-- *****************************************************************************************\
--                                  CUSTOM CRYSTAL FUNCTIONS\
-- *****************************************************************************************\
\
\
function onGreenCrystalClick(crystal)\
\9\
\9party:heal()\
\9\
end\
\
")
spawn("healing_crystal", 16,17,0, "healing_crystal_1")
spawn("dx_healing_crystal_object_green", 16,16,0, "dx_healing_crystal_object_green_1")
	:setSource("")
spawn("starting_location", 13,16,1, "starting_location")
spawn("dx_healing_crystal_object_pink", 16,15,3, "dx_healing_crystal_object_pink_1")
	:setSource("")
