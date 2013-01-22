-- ==========================================================================
--                 MULTI-LEVEL DUNGEON COMPILER
-- ==========================================================================


-- Wallset Definition
-- ************************************


wallset = {
	_wall  = {
		{1, "_castle_exterior_wall_1above"},
		{2, "_castle_exterior_wall_2above"},
		{-1, "_castle_exterior_wall_1below"},
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
}


-- Main Compiler Module
-- ************************************

function compileDungeon(firstLevel, lastLevel)
	local levels = getMaxLevels()
	for level = 1,levels do
		for x = 0,31 do
			for y = 0,31 do
				for l = firstLevel, lastLevel do
					if l ~= level then
						local stairsCheck = false
						-- Create Objects
						for i in entitiesAt(l, x, y) do
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
						end
						-- Create Walls
						if isWall(l, x, y) then
							for wallDir = 0, 3 do
								local dx, dy = getForward(wallDir)
								if not(isWall(l, x+dx, y+dy)) then
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
						if l > level and (l == lastLevel or isWall(l+1, x, y)) then
							local objToSpawn
							for _, spawnObjects in ipairs(dungeonCompiler.wallset._floor) do
								if spawnObjects[1] == level - l then
									objToSpawn = spawnObjects[2]
								end
							end
							if objToSpawn then
								spawn(objToSpawn, level, x, y)
							end
						end						
					end
				end
			end
		end
	end
end

compileDungeon(1,3)