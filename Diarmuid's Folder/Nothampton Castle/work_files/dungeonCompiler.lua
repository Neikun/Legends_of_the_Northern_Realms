-- ==========================================================================
--                 MULTI-LEVEL DUNGEON COMPILER
-- ==========================================================================


-- Wallset Definition
-- ************************************


wallset = {
	_wall  = {
		{1, "_castle_exterior_wall_1above"},
		{2, "_castle_exterior_wall_2above"},
		{3, "_castle_exterior_wall_3above"},
		{-1, "_castle_exterior_wall_1below"},
		{-2, "_castle_exterior_wall_2below"},
	},
	_pillar = {
		{1, "_castle_exterior_pillar_small_1above"},
		{2, "_castle_exterior_pillar_small_2above"},
		{-1, "_castle_exterior_pillar_small_1below"},
	},
	_floor = {
		{-1, "_castle_exterior_floor_1below"},
	},
	castle_exterior_pillar_big = {
		{1, "_castle_exterior_pillar_big_1above"},
		{2, "_castle_exterior_pillar_big_2above"},
		{3, "_castle_exterior_pillar_big_3above"},
		{-1, "_castle_exterior_pillar_big_1below"},
	},
	castle_exterior_pillar_small = {
		{1, "_castle_exterior_pillar_small_1above"},
		{2, "_castle_exterior_pillar_small_2above"},
		{-1, "_castle_exterior_pillar_small_1below"},
	},
	castle_exterior_wall_windows = {
		{1, "_castle_exterior_wall_windows_1above"},
		{2, "_castle_exterior_wall_windows_2above"},
		{-1, "_castle_exterior_wall_windows_1below"},
	},
	castle_exterior_parapet = {
		{1, "_castle_exterior_parapet_1above"},
		{2, "_castle_exterior_parapet_2above"},
		{3, "_castle_exterior_parapet_3above"},
		{-1, "_castle_exterior_parapet_1below"},
		{-2, "_castle_exterior_parapet_2below"},
	},
	castle_exterior_parapet_pillar = {
		{1, "_castle_exterior_parapet_pillar_1above"},
		{2, "_castle_exterior_parapet_pillar_2above"},
		{3, "_castle_exterior_parapet_pillar_3above"},
		{-1, "_castle_exterior_parapet_pillar_1below"},
		{-2, "_castle_exterior_parapet_pillar_2below"},
	},	
	_castle_exterior_stairs = {
		{1, "_castle_exterior_stairs_1above"},
		{2, "_castle_exterior_stairs_2above"},
		{3, "_castle_exterior_stairs_3above"},
		{-1, "_castle_exterior_stairs_1below"},
		{-2, "_castle_exterior_stairs_2below"},
		{-3, "_castle_exterior_stairs_3below"},
	},
	torch_holder = {
		{1, "_torch_holder_1above"},
		{2, "_torch_holder_2above"},
		{3, "_torch_holder_3above"},
		{-1, "_torch_holder_1below"},
		{-2, "_torch_holder_2below"},
		{-3, "_torch_holder_3below"},
	},
	_torch = {
		{1, "_torch_lit_1above"},
		{2, "_torch_lit_2above"},
		{3, "_torch_lit_3above"},
		{-1, "_torch_lit_1below"},
		{-2, "_torch_lit_2below"},
		{-3, "_torch_lit_3below"},
	},
}


-- Main Compiler Module
-- ************************************

function compileDungeon(firstLevel, lastLevel)
	local levels = getMaxLevels()
	for level = 1,levels do
		for x = 0,31 do
			for y = 0,31 do
				for l = firstLevel, lastLevel do
					-- Spawn stairs
					for i in entitiesAt(l, x, y) do
						if i.name == "castle_exterior_stairs_up" then
							spawn("_castle_exterior_stairs", l, x, y, i.facing)
						end
					end
					if l ~= level then
						local stairsCheck = false
						-- Create Objects
						for i in entitiesAt(l, x, y) do
							-- Spawn multi-level architecture
							for object, defs in pairs(dungeonCompiler.wallset) do
								if i.name == object then
									local objToSpawn
									for _, spawnObjects in ipairs(defs) do
										if spawnObjects[1] == level - l then
											objToSpawn = spawnObjects[2]
										end
									end
									if objToSpawn then
										spawn(objToSpawn, level, x, y, i.facing)
									end
								end
							end
							-- Spawn torchHolders
							if i.class == "TorchHolder" and i:hasTorch() then
								local objToSpawn
								for _, spawnObjects in ipairs(dungeonCompiler.wallset._torch) do
									if spawnObjects[1] == level - l then
										objToSpawn = spawnObjects[2]
									end
								end
								if objToSpawn then
									spawn(objToSpawn, level, x, y, i.facing)
								end
								local fxId = dungeonCompiler:playFx("torchLight",level, x, y, i.facing)
								findEntity(fxId):translate(0,(level - l)*4.5,0)
							end
							-- Spawn sx_remove_floor elements where not already present
							if l > firstLevel then
								if i.name == "sx_remove_ceiling" then
									local removeFloorFound = false
									for j in entitiesAt(l-1, x, y) do
										if j.name == "sx_remove_floor" then
											removeFloorFound = true
										end
									end
									if not(removeFloorFound) then
										spawn("sx_remove_floor", l-1, x, y, 0)
									end
								end
							end
						end
						-- Create Walls
						if isWall(l, x, y) then
							for wallDir = 0, 3 do
								local dx, dy = getForward(wallDir)
								local wallRemover = false
								local isFloor = false
								local isStairs = false
								for i in entitiesAt(l, x+dx, y+dy) do
									if i.name == "sx_remove_wall" and (i.facing+2)%4 == wallDir then
										wallRemover = true
									end
								end
								if l > level then
									isFloor = true
									for i in entitiesAt(l-1, x+dx, y+dy) do
										if i.name == "sx_remove_floor" then
											isFloor = false
										end
									end
								end
								if not(isWall(l, x+dx, y+dy)) and not(wallRemover) and not(isFloor) then
									local objToSpawn
									for _, spawnObjects in ipairs(dungeonCompiler.wallset._wall) do
										if spawnObjects[1] == level - l then
											objToSpawn = spawnObjects[2]
										end
									end
									if objToSpawn then
										spawn(objToSpawn, level, x+dx, y+dy, (wallDir+2)%4)
									end
									local px, py = getForward((wallDir+1)%4)
									-- Create pillars
									objToSpawn = nil
									for _, spawnObjects in ipairs(dungeonCompiler.wallset._pillar) do
										if spawnObjects[1] == level - l then
											objToSpawn = spawnObjects[2]
										end
									end
									if objToSpawn then
										local p1x, p1y, p2x, p2y
										local wx, wy = getForward((wallDir+1)%4)
										if wallDir == 0 then
											p1x, p1y = x, y
											p2x, p2y = x+wx, y+wy
										elseif wallDir == 1 then
											p1x, p1y = x+dx, y+dy
											p2x, p2y = x+dx+wx, y+dy+wy
										elseif wallDir == 2 then
											p1x, p1y = x+dx, y+dy
											p2x, p2y = x+dx-wx, y+dy-wy
										elseif wallDir == 3 then
											p1x, p1y = x, y
											p2x, p2y = x-wx, y-wy
										end
										if not(findEntity("pillar."..level.."."..l.."."..p1x.."."..p1y)) then
											spawn(objToSpawn, level, p1x, p1y, wallDir, "pillar."..level.."."..l.."."..p1x.."."..p1y)
										end
										if not(findEntity("pillar."..level.."."..l.."."..p2x.."."..p2y)) then
											spawn(objToSpawn, level, p2x, p2y, wallDir, "pillar."..level.."."..l.."."..p2x.."."..p2y)
										end
									end
								end
							end
						end
						--Create floor
						if l > level then
							local removeFloorFound = false
							for j in entitiesAt(l, x, y) do
								if j.name == "sx_remove_floor" then
									removeFloorFound = true
								end
							end
							if (l == lastLevel or not(removeFloorFound)) and not(isWall(l, x, y)) then
								local objToSpawn
								for _, spawnObjects in ipairs(dungeonCompiler.wallset._floor) do
									if spawnObjects[1] == level - l then
										objToSpawn = spawnObjects[2]
									end
								end
								if objToSpawn then
									spawn(objToSpawn, level, x, y, 0)
								end
							end
						end						
					end
				end
			end
		end
	end
end





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


dungeonCompiler:defineFx("torchLight",{
	particleSystem = "torch",
	color = {1, 0.5, 0.25},
	brightness = 10,
	range = 6,
	time = 1000000,
	castShadow = true,
	translation = {{0,1.5,1},{1,1.5,0},{0,1.5,-1},{-1,1.5,0}}
	}
)

compileDungeon(1,4)