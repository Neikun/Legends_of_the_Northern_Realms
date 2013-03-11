--[[

#####    Crystal Handler Script, Version 1.0    #####
#####  Scripting & Design by Diarmuid & Neikun  #####

Setup instructions:
Copy the contents of this file in your dungeon a script entity named crystalHandler.

]]


crystalObjects = {}

-- *****************************************************************************************
--                                    CRYSTAL FUNCTIONS
-- *****************************************************************************************

function createCrystals()

	for level = 1, getMaxLevels() do

		for x = 0,31 do
			
			for y = 0,31 do
				
				for i in entitiesAt(level, x, y) do
					
					if string.find(i.name, "dx_healing_crystal_object_") then
						
						local color = string.sub(i.name, 27)
						spawnCrystal(color, level, x, y, i.id)
						
					end
				
				end
			
			end
		
		end
	
	end
	
end


function spawnCrystal(color, level, x, y, id)

	if crystalObjects[id] then
		print("Warning: crystal id already in use!")
		return false
	end
	
	-- Create crystal lua object and IDs
	crystalObjects[id] = {}
	local crystal = crystalObjects[id]
	crystal.color = color
	crystal.id = id
	crystal.level = level
	crystal.x = x
	crystal.y = y
	crystal.activated = crystal.id.."_activated"
	crystal.deactivated = crystal.id.."_deactivated"
	crystal.lights = {}
	crystal.dimLights = {}
	crystal.gratings = {}
	for j = 0, 3 do
		crystal.lights[j] = crystal.id.."_light_"..j
		crystal.dimLights[j] = crystal.id.."_dimLight_"..j
		crystal.gratings[j] = crystal.id.."_grating_"..j
	end
	crystal.topLight = crystal.id.."_topLight"
	crystal.bottomLight = crystal.id.."_bottomLight"
	crystal.particleSystem = crystal.id.."_particleSystem"
	crystal.altar = crystal.id.."_altar"
	crystal.timer = crystal.id.."_timer"
	crystal.fakeItem = crystal.id.."_fakeItem"
	crystal.animTimerActivated = crystal.id.."_animTimer1"
	crystal.animTimerDeactivated = crystal.id.."_animTimer2"
	
	-- Set it to active
	crystal.active = true
	
	-- Spawn activated state
	spawn("_dx_healing_crystal_"..crystal.color, level, x, y, 0, crystal.activated)
		:addTrapDoor()
		:setPitState("open")
		:close()
							
	-- Play crystal sounds
	for j = 0, 3 do
		local dx, dy = getForward(j)
		playSoundAt("crystal_ambient", level, x+dx, y+dy)
	end
	
	-- Spawn shader projectile and register ID
	crystal.shader = shootProjectileWithId("_dx_healing_crystal_shader_"..crystal.color,level,x,y,0,0,0,0,0,14,0,0,party,true)
	
	-- Spawn lights & particles lightsources
	for j = 0,3 do
		spawn("_dx_healing_crystal_light_"..crystal.color, level, x, y, j, crystal.lights[j])
		spawn("_dx_healing_crystal_light_deactivated_"..crystal.color, level, x, y, j, crystal.dimLights[j]):deactivate()
	end
	spawn("_dx_healing_crystal_top_light_"..crystal.color, level, x, y, 0, crystal.topLight)
	spawn("_dx_healing_crystal_bottom_light_"..crystal.color, level, x, y, 0, crystal.bottomLight)
	
	spawn("_dx_healing_crystal_particleSystem_"..crystal.color, level, x, y, 0, crystal.particleSystem)
	
	-- Spawn altar and fake item
	spawn("_dx_healing_crystal_altar", level, x, y, 0, crystal.altar)
		:addItem(spawn("_dx_healing_crystal_fake_item",nil,nil,nil,nil,crystal.fakeItem))
		:addConnector("deactivate", "crystalHandler", "useCrystal")
		
	-- Spawn crystal timers
	spawn("timer", level, x, y, 0, crystal.timer)
		:setTimerInterval(120)
		:addConnector("activate", "crystalHandler", "reactivateCrystal")
	spawn("timer", level, x, y, 0, crystal.animTimerActivated)
		:setTimerInterval(14)
		:addConnector("activate", "crystalHandler", "crystalAnimation")
		:activate()
	spawn("timer", level, x, y, 0, crystal.animTimerDeactivated)
		:setTimerInterval(40)
		:addConnector("activate", "crystalHandler", "crystalAnimation")
		
	-- Spawn gratings
	for j = 0, 3 do
		spawn("_dx_healing_crystal_grating", level, x, y, j, crystal.gratings[j])
	end
	
end

function destroyCrystal(id)
	
	if crystalObjects[id] then
	
		local crystal = crystalObjects[id]
		
		if crystal.active then
			findEntity(crystal.activated):destroy()
			findEntity(crystal.shader):destroy()
		else
			findEntity(crystal.deactivated):destroy()
		end		
		for i = 0,3 do
			findEntity(crystal.lights[i]):destroy()
			findEntity(crystal.dimLights[i]):destroy()
			findEntity(crystal.gratings[i]):destroy()
		end
		findEntity(crystal.topLight):destroy()
		findEntity(crystal.bottomLight):destroy()
		findEntity(crystal.particleSystem):destroy()
		findEntity(crystal.altar):destroy()
		findEntity(crystal.fakeItem):destroy()
		findEntity(crystal.timer):destroy()
		findEntity(crystal.animTimerActivated):destroy()
		findEntity(crystal.animTimerDeactivated):destroy()
		
		crystal = nil
		
	end
	
end


function crystalAnimation(timer)

	-- Retrieve crystal lua object by extracting its id from the timer id
	local crystal = crystalObjects[string.sub(timer.id,0,-12)]
	local level, x, y = timer.level, timer.x, timer.y
	
	if crystal.active == true then
	
		if findEntity(crystal.activated) then
		
			findEntity(crystal.activated):setPitState("open")
			findEntity(crystal.activated):close()
			
			for i = 0, 3 do
				local dx, dy = getForward(i)
				playSoundAt("crystal_ambient", level, x+dx, y+dy)
			end
			
		else
		
			findEntity(crystal.deactivated):destroy()
			
			-- Spawn deactivated state
			spawn("_dx_healing_crystal_"..crystal.color, level, x, y, 0, crystal.activated)
				:addTrapDoor()
				:setPitState("open")
				:close()
				
			findEntity(crystal.animTimerActivated):activate()
			findEntity(crystal.animTimerDeactivated):deactivate()
		
		end
		
	else
	
		if findEntity(crystal.activated) then
		
			findEntity(crystal.activated):destroy()
			
			-- Spawn deactivated state
			spawn("_dx_healing_crystal_deactivated_"..crystal.color, level, x, y, 0, crystal.deactivated)
				:addTrapDoor()
				:setPitState("open")
				:close()
			
			findEntity(crystal.animTimerDeactivated):activate()
			findEntity(crystal.animTimerActivated):deactivate()
			
		else
		
			findEntity(crystal.deactivated):setPitState("open")
			findEntity(crystal.deactivated):close()
		
		end
		
	end

end


function useCrystal(altar)
		
	-- Retrieve crystal lua object by extracting its id from the altar id
	local crystal = crystalObjects[string.sub(altar.id,0,-7)]
	local level, x, y = altar.level, altar.x, altar.y	
	
	-- Respawn item on altar
	setMouseItem(nil)
	altar:addItem(spawn("_dx_healing_crystal_fake_item",nil,nil,nil,nil,crystal.fakeItem))
	
	if crystal.active then
	
		-- Call Crystal Hook
		local returnValue = onCrystalClick(crystal)
		
		if returnValue == false then
			return false
		end
		
		-- Turn off activated state lights and turn on deactivated state lights
		for i = 0,3 do
			findEntity(crystal.lights[i]):deactivate()
			findEntity(crystal.dimLights[i]):activate()
		end
		findEntity(crystal.topLight):deactivate()
		findEntity(crystal.bottomLight):deactivate()
		
		-- Turn off particle system
		findEntity(crystal.particleSystem):deactivate()
		
		-- Spawn fadeout partile system
		spawn("fx", altar.level, altar.x, altar.y, 0)
			:setParticleSystem("dx_healing_crystal_fade_"..crystal.color)
			:setLight(0,0,0,1,0,8,false)
		
		-- Destroy shader projectile
		findEntity(crystal.shader):destroy()

		-- Start timer
		findEntity(crystal.id.."_timer"):activate()
		
		-- Deactivate crystal
		crystal.active = false
	
	end
	
end


function reactivateCrystal(timer)

	-- Retrieve crystal lua object by extracting its id from the timer id
	local crystal = crystalObjects[string.sub(timer.id,0,-7)]
	local level, x, y = timer.level, timer.x, timer.y
		
	-- Turn off deactivated state lights and turn on activated state lights
	for i = 0,3 do
		findEntity(crystal.lights[i]):activate()
		findEntity(crystal.dimLights[i]):deactivate()
	end
	findEntity(crystal.topLight):activate()
	findEntity(crystal.bottomLight):activate()
	
	-- Turn on particle system
	findEntity(crystal.particleSystem):activate()

	-- Spawn shader projectile and register ID
	crystal.shader = shootProjectileWithId("_dx_healing_crystal_shader_"..crystal.color,level,x,y,0,0,0,0,0,14,0,0,party,true)

	-- Stop timer
	findEntity(crystal.id.."_timer"):deactivate()
	
	-- Reactivate crystal
	crystal.active = true
	
end

function cancelAltar(altar)

	for i in altar:containedItems() do
	
		if i.name ~= "_dx_healing_crystal_fake_item" then
			setMouseItem(spawn(i.name))
			i:destroy()
		end
		
	end
	
end


-- *****************************************************************************************
--                                    HELPER FUNCTIONS
-- *****************************************************************************************

function shootProjectileWithId(projName,level,x,y,dir,speed,gravity,velocityUp,offsetX,offsetY,offsetZ,attackPower, ignoreEntity,fragile,championOrdinal)
	local pIds = {}
	
	for i in entitiesAt(level, x, y) do
		if i.class == "Item" and string.find(i.id, "^%d+$") then
			pIds[i.id] = i.name
		end
	end
	
	shootProjectile(projName,level,x,y,dir,speed,gravity,velocityUp,offsetX,offsetY,offsetZ,attackPower, ignoreEntity,fragile,championOrdinal)
 	
	for i in entitiesAt(level, x, y) do
		if i.class == "Item" and string.find(i.id, "^%d+$") and not(pIds[i.id]) then
			return i.id
		end
	end  

end

-- *****************************************************************************************
--                                           INIT
-- *****************************************************************************************

createCrystals()

-- *****************************************************************************************
--                                  CUSTOM CRYSTAL FUNCTIONS
-- *****************************************************************************************


function onCrystalClick(crystal)
	
	if crystal.color == "green" then
	
		party:heal()
		
	end
	
	if crystal.color == "pink" then
	
		party:heal()
		
	end

	if crystal.color == "red" then
	
		party:heal()
		
	end

	if crystal.color == "black" then
	
		party:heal()
		
	end

	if crystal.color == "orange" then
	
		party:heal()
		
	end	
	
	if crystal.color == "yellow" then
	
		party:heal()
		
	end	
	
	if crystal.color == "white" then
	
		party:heal()
		
	end	
end

