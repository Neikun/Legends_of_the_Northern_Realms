-- ==========================================================================
--                        MULTI-LEVEL DUNGEON COMPILER
-- ==========================================================================



-- ==========================================================================
--                            WALLSET DEFINITIONS
-- ==========================================================================



wallset = {
	_wall  = {"dx_temple_wall","wall",0,0,0},
	_wall_x2  = {"dx_temple_wall_x2","wall",0,0,0},
	_wall_x3  = {"dx_temple_wall_x3","wall",0,0,0},
	--_wall_dxs = {"dxs_castle_exterior_wall","wall",0,0,0},
	--_pillar = {"dx_castle_exterior_pillar_small","pillar",0,0,0},
	_floor = {"dx_temple_floor","floor",0,0,0},
	_ceiling = {"dx_temple_ceiling","floor",0,0,3},
	_stairsUp = "dx_temple_stairs_up",
	_stairsDown = "dx_temple_stairs_down",
	_stairs = "_dx_temple_stairs",
	_stairs_dxs = {"dxs_castle_exterior_stairs","floor",0,0,0},

	torch_holder = {"dx_torch_holder","wall",0,0,0},
	_torch = {"dx_torch_lit","wall",0,0,0},
}

wallData = {}

wallObjects = {}

-- ==========================================================================
--                           MAIN COMPILER INIT MODULE
-- ==========================================================================
objects = {}

function compileDungeon(firstLevel, lastLevel)
	
	-- SMART TILESET SCRIPTING
	
	for level = firstLevel,lastLevel do
	
		for y = 10,20 do
		
			for x = 10,20 do
			
				-- Scan walls
				if isWall_dx(level, x, y) then
				
					for facing = 0, 3 do
					
						local dx, dy = getForward(facing)
					
						if getWallData(level, x, y, facing) == nil and not(isWall_dx(level, x + dx, y + dy)) then
						
							local sideFacing = (facing + 3) % 4
							local sx, sy = getForward(sideFacing)
							local panelSize = 1
							
							if facing == 0 or facing == 1 then
							
								for i = 1, 10 do
								
									if isWall_dx(level, x - sx * i, y - sy * i) and not(isWall_dx(level, x - sx * i + dx, y - sy * i + dy)) then
										setWallData(level, x - sx * i, y - sy * i, facing, 0)
										panelSize = panelSize + 1
									else
										break
									end
								
								end
								
								setWallData(level, x, y, facing, 0)
								setWallData(level, x - sx * (panelSize - 1), y - sy * (panelSize - 1), facing, panelSize)
							
							end
							
							if facing == 2 or facing == 3 then
							
								for i = 1, 10 do
								
									if isWall_dx(level, x + sx * i, y + sy * i) and not(isWall_dx(level, x + sx * i + dx, y + sy * i + dy)) then
										setWallData(level, x + sx * i, y + sy * i, facing, 0)
										panelSize = panelSize + 1
									end
								
								end
								
								setWallData(level, x, y, facing, panelSize)
							
							end
						
						end
					
					end
				
				end
									
			
				-- -- Spawn stairs, teleporters and onLevelUp / onLevelDown / onLevelChange hooks
				for i in entitiesAt(level, x, y) do
				
					-- Spawn solid wall elements
					if i.name == "dx_solid_wall" then
					
						for wallDir = 0, 3 do
						
							local dx, dy = getForward(wallDir)
							
							if not(isWall_dx(level, x+dx, y+dy)) and not(isObjectByName("temple_stairs_up", level, x+dx, y+dy)) and not(isObjectByName("temple_stairs_down", level, x+dx, y+dy)) then
								spawn("dx_temple_solid_wall", level, x+dx, y+dy, (wallDir+2)%4)
							end
							
						end
						
					end

				end

			end
			
		end
		
	end
	
	-- MULTI-LEVEL SPAWNING
	
	for level = firstLevel, lastLevel do
		for x = 10,20 do
			for y = 10,20 do
				
				local topRange = level - 2
				if topRange < firstLevel then topRange = firstLevel end
				
				local bottomRange = level + 1
				if bottomRange > lastLevel then bottomRange = lastLevel end
				
				for l = topRange, bottomRange do
				
					--Create intermediate walls
					if isObjectByName("sx_remove_floor", l, x, y) then
						for wallDir = 0, 3 do
							local dx, dy = getForward(wallDir)
							if not(isObjectByName("sx_remove_floor", l ,x+dx, y+dy)) then
								spawnMultiLevelObject("_wall", level, l, x, y, wallDir, nil, -3)
							end
						end
					end
						
					if l ~= level then
						local stairsCheck = false
						for i in entitiesAt(level,x,y) do
							if i.name == wallset._stairsUp or i.name == wallset._stairsDown then
								stairsCheck = true
							end
						end
						-- Create Objects
						for i in entitiesAt(l, x, y) do
							-- Spawn multi-level architecture
							if wallset[i.name] then
								if not(stairsCheck) then
									if wallset[i.name][2] == "pillar" then
										spawnMultiLevelObject(i.name, level, l, x, y, 0)
									else	
										spawnMultiLevelObject(i.name, level, l, x, y, i.facing)
									end
								else
									if i.name == wallset._stairs then
										local dx, dy = getForward(i.facing)
										--spawnMultiLevelObject("_stairs_dxs", level, l, x-dx, y-dy, i.facing)
									end
								end
							end
							-- Spawn torchHolders
							if i.class == "TorchHolder" and i:hasTorch() then
								spawnMultiLevelObject("_torch", level, l, x, y, i.facing)
								local fxId = dungeonCompiler:playFx("torchLight",level, x, y, i.facing)
								findEntity(fxId):translate(0,(level - l)*6,0)
							end

						end
						
						-- Create Walls
						if isWall_dx(l, x, y) then
							for wallDir = 0, 3 do
								local dx, dy = getForward(wallDir)
								if not(isWall_dx(l, x+dx, y+dy)) and not(isObjectByName("sx_remove_wall", l, x+dx, y+dy, (wallDir+2)%4)) then
									--if (l>level and isObjectByName("sx_remove_floor", l-1, x+dx, y+dy)) or (l == firstLevel or isObjectByName("sx_remove_floor", l-1, x+dx, y+dy)) then
										if not(stairsCheck) then
											spawnMultiLevelObject("_wall", level, l, x+dx, y+dy, (wallDir+2)%4)
										else
											local wx, wy = getForward((wallDir+1)%4)
											--spawnMultiLevelObject("_wall_dxs", level, l, x+dx+wx, y+dy+wy, (wallDir+2)%4)
										end
									--end
								end

								
								local px, py = getForward((wallDir+1)%4)
								-- if not((isWall_dx(l, x+dx, y+dy)) and not(isObjectByName("sx_remove_wall", l, x+dx, y+dy, (wallDir+3)%4))) then
																		
									-- -- Create small pillars
									-- if l <= level or (l > level and isObjectByName("sx_remove_floor", l-1, x+dx, y+dy)) then
										-- local p1x, p1y, p2x, p2y
										-- local wx, wy = getForward((wallDir+1)%4)
										-- if wallDir == 0 then
											-- p1x, p1y = x, y
											-- p2x, p2y = x+wx, y+wy
										-- elseif wallDir == 1 then
											-- p1x, p1y = x+dx, y+dy
											-- p2x, p2y = x+dx+wx, y+dy+wy
										-- elseif wallDir == 2 then
											-- p1x, p1y = x+dx, y+dy
											-- p2x, p2y = x+dx-wx, y+dy-wy
										-- elseif wallDir == 3 then
											-- p1x, p1y = x, y
											-- p2x, p2y = x-wx, y-wy
										-- end
										-- if not(findEntity("pillar."..level.."."..l.."."..p1x.."."..p1y)) then
											-- spawnMultiLevelObject("_pillar", level, l, p1x, p1y, 0)
										-- end
										-- if not(findEntity("pillar."..level.."."..l.."."..p2x.."."..p2y)) then
											-- spawnMultiLevelObject("_pillar", level, l, p2x, p2y, 0)
										-- end
									-- end
								-- end
							end
						end
						
						--Create floors
						if l > level then
							if not(isObjectByName("sx_remove_floor", l, x, y)) and not(isWall_dx(l, x, y)) then
								spawnMultiLevelObject("_floor", level, l, x, y, 0)
							end
						end	

						--Create ceilings
						if l < level then
							if (l == firstLevel or not(isObjectByName("sx_remove_ceiling", l, x, y))) and not(isWall_dx(l, x, y)) then
								spawnMultiLevelObject("_ceiling", level, l, x, y, 0)
							end
						end							
					end
				end
			end
		end
	end
end

function isWall_dx(level, x, y)
	if (isWall(level, x, y) or isObjectByName("dx_solid_wall", level, x, y)) and not(isObjectByName("temple_stairs_up", level, x, y)) and not(isObjectByName("temple_stairs_down", level, x, y)) then
		return true
	else
		return false
	end
end

function spawnMultiLevelObject(name, level, objectLevel, x, y, facing, id, vOffset)
	
	if vOffset == nil then
		vOffset = 0
	end

	if level < 1 or level > getMaxLevels() then
		return false
	end
	local objData = dungeonCompiler.wallset[name]
	
	local id
	
	if objData then
		local dx, dy = getForward(facing)
		id = shootProjectileWithId(objData[1], level, x, y, facing, 0, 0, 0, dx*objData[3], ((level - objectLevel) * 6) + objData[5] + 24 + vOffset, -dy*objData[3], 0, party, true)
		if name == "_wall" then	
			table.insert(wallObjects, id);
		end
		table.insert(objects, id)
	end
	
end

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

function getObjectData(name)
	local obj = {}
	if dungeonCompiler.wallset[name] then
	end
end

function isObjectByName(name, objLevel, x, y, facing)
	if objLevel < 1 or objLevel > getMaxLevels() then
		return false
	end
	for i in entitiesAt(objLevel, x, y) do
		if facing then
			if i.name == name and i.facing == facing then
				return true
			end
		else
			if i.name == name then
				return true
			end
		end
	end
	return false
end

function isObjectById(id, level, x, y, facing)
	if level < 1 or level > getMaxLevels() then
		return false
	end
	for i in entitiesAt(level, x, y) do
		if facing then
			if i.id == id and i.facing == facing then
				return true
			end
		else
			if i.id == id then
				return true
			end
		end
	end
	return false
end

function debugPrint(l, x, y, pl, px, py, data)

	if l == pl and x == px and y == py then
		print(data)
	end
	
end

function setWallData(level, x, y, facing, value)
	
	wallData[level.."."..x.."."..y.."."..facing] = value
	
end

function getWallData(level, x, y, facing)

	return wallData[level.."."..x.."."..y.."."..facing]
	
end
	
-- ==========================================================================
--                            WALLSET DEFINITIONS
-- ==========================================================================

function onLevelUp(trigger)
	print("going up!")
end

function onLevelDown(trigger)
	print("going down!")
end


-- ==========================================================================
--                            EXSP FX FUNCTIONS
-- ==========================================================================


fxDefs = {}

function defineFx(self, name, properties)
	if not(self.fxDefs[name]) then 
		self.fxDefs[name] = {} 
	else
		return false
	end
	
	-- populate Table
	for k,v in pairs(properties) do
		self.fxDefs[name][k] = v
	end
	
	if debugDefinitions then
		print("FX defined: "..name)
	end
end

function playFx(self, name, level, x, y, facing, properties)

	-- retreive fx definition
	local fx = {}
	for k, v in pairs(self.fxDefs[name]) do
		fx[k] = v
	end
	if properties then
		for k, v in pairs(properties) do
			fx[k] = v
		end
	end
	local red, green, blue = unpack(fx.color)
		
	local particleSystem
	local tx, ty, tz 
	if not(facing) then
		particleSystem = fx.particleSystem
		tx, ty, tz = unpack(fx.translation)
	else
		if type(fx.particleSystem) == "table" then
			particleSystem = fx.particleSystem[facing+1]
		else
			particleSystem = fx.particleSystem
		end
		if #fx.translation > 3 then
			tx, ty, tz = unpack(fx.translation[facing+1])
		else
			tx, ty, tz = unpack(fx.translation)
		end
	end
	
	-- spawn fx
	fxId = randomId("playFx")
	spawn("fx", level, x, y, 0, fxId)
		:setParticleSystem(particleSystem)
		:setLight(red, green, blue, fx.brightness, fx.range, fx.time, fx.castShadow)
		:translate(tx, ty, tz)
	
	return fxId
end

function randomId(prefix)
	local numId = math.random(10000,99999)
	while findEntity(prefix.."."..numId) do
		numId = math.random(10000,99999)
	end
	return prefix.."."..numId
end

-- ==========================================================================
--                            RUNTIME INIT
-- ==========================================================================


dungeonCompiler:defineFx("torchLight",{
	particleSystem = "torch",
	color = {1, 0.8, 0.45},
	brightness = 4,
	range = 10,
	time = 10000000,
	castShadow = false,
	translation = {{0,1.85,1.1},{1.1,1.85,0},{0,1.85,-1.1},{-1.1,1.85,0}}
	}
)

compileDungeon(1,9)

--print("Objects:",#objects)
--print("Wall Objects:",#wallObjects)

--spawnMultiLevelObject("_wall_x3", 8, 8, 13, 13, 1)
