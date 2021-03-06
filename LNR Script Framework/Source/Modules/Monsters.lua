--[[
Usage:
Create a script entity
called 'Monsters' and place
this code in it.
Call Monsters.Init() and
Monsters.spawnLevel(nLevel) using the
current level as the argument.
I like to use a use once-only invisible
pressure plate for this. I place it
under the starting position for level 1
and on the stairs down for lower levels.
]]



--[EDIT THIS TABLE TO SUIT YOUR DUNGEON]
tMonsters = {	
	--[[create a numeric index in this table for each level in your dungeon
		whose value is a number indicating the base number of monsters that will spawn in that level]]
	baseCount = {
		[1] = math.random(6,10),
		[2] = math.random(6,12),
		[3] = math.random(7,12),
		[4] = math.random(7,14),
		[5] = math.random(8,14),
		[6] = math.random(8,16),
		[7] = math.random(9,16),
		[8] = math.random(9,18),
		[9] = math.random(10,18),
		[10] = math.random(10,20),
		[11] = math.random(11,20),
		[12] = math.random(11,22),
		[13] = math.random(12,22),
		[14] = math.random(12,24),
		[15] = math.random(13,24),
		[16] = math.random(13,26),
		[17] = math.random(14,26),
		[18] = math.random(14,28),
		[19] = math.random(15,28),
		[20] = math.random(15,30),
		[21] = math.random(16,30),
		[22] = math.random(16,32),
		[23] = math.random(17,32),
		[24] = math.random(17,34),
		[25] = math.random(18,34),
	},
	--used for calculating the number of monsters to add/subract during the spawn phase
	baseCountVar = math.random(4, 27) / 10,
	--used to determine the variance in monster level
	baseLevelVar = math.random(5, 15) / 10,	
	--[[this table list the mosnters that may spawn on given level (includes the previous lists).
		e.g. a level 3 spawn phase may spawns monsters from table 3 as well as all monsters from tables 2 and 1
		you may arrange these how you please (even adding monsters etc.) or simply leave them as they are]]
	levelClass = {
		[1] = {"skeleton_warrior","herder","snail"},
		[2] = {"herder_small","skeleton_patrol","skeleton_archer"},
		[3] = {"crowern","herder_big","skeleton_archer_patrol"},
		[4] = {"spider","scavenger","herder_swarm"},
		[5] = {"tentacles","green_slime","warden"},
		[6] = {"ogre","crab","uggardian"},
		[7] = {"wyvern","ice_lizard","scavenger_swarm"},
		[8] = {"goromorg","shrakk_torr","cube"},	
	},
	levelLimits = {
		baseLevels = {
			--this is the minimum allowed level for a spawning monster		
			Min = 1,
			--this is the maximum allowed level for a spawning monster
			Max = 25,
		},
		--[[if this is set to 'true', the 'baseLevels' 'Min' value will
			be ignored and the champion with lowest level will be used
			to calculate the max level allowed.]]
		useChampionAsMinLevel = true,
		--[[if this is set to 'true', the 'baseLevels' 'Max' value will
			be ignored and the champion with highest level will be used
			to calculate the max level allowed.]]
		useChampionAsMaxLevel = false,			
	},
	--prevents infinite loops in the spawn loop (this number is basically the spawn attemps allowed per monster <shared value>)
	maxSpawnAttemptsFactor = 10,
	--the minimum tiles (x and y) between the party and the each spawning monster
	minPartyDistance = 2,
	--NOT YET USED...will prevent monsters from spawning in tight groups (does not affect group entities)
	minMonsterDistance = 0,
	--used to ensure that multiple spawn sessions per level do not occur [DO NOT EDIT THIS ENTRY]
	spawned = {},
};







--[[>>>>>>>>>>>>>>>>>>>>>>>>>>
Monsters.getRandom(Inetger)
Gets a random monster which
is allowed to spawn in the
specified level.
<<<<<<<<<<<<<<<<<<<<<<<<<<<<]]
function getRandom(n_maxLevelClass)
--floor the input value to unsure it's an integer
n_maxLevelClass = math.floor(n_maxLevelClass);
--the level class table index that will be used when all calculations are done
local n_levelClass = 1;

	--determine which level class will be used and check for number validity
	if n_maxLevelClass > 1 then
	local n_levelClasses = #tMonsters.levelClass;
	--[[total summation of this level's value plus previous levels' values
		e.g. the total value if using level three would be 3 + 2 + 1 = 6]]
	local n_total = 0;
	--the chance that a monster will spawn from a level class table
	local t_levelClassChance = {};
	
		--make sure the input value is not higher then the max number of level class tables
		if n_maxLevelClass > n_levelClasses then
		n_maxLevelClass = n_levelClasses;
		end
			
		--get the total values of each level up to this one
		for n_currentLevel = 1, n_maxLevelClass do
		n_total = n_total + n_currentLevel;
		end
		
		--store the last percentage calculated
		local nLastNumber = 0;
		
		--get the spawn percentage for each level class
		for n_currentLevel = 1, n_maxLevelClass do
		local nMyPercentage = math.floor((n_currentLevel / n_total) * 100);
		
		t_levelClassChance[n_currentLevel] = {
			Min = nLastNumber,
			Max = nMyPercentage,
		};

		nLastNumber = nMyPercentage + 1;
		end
			
		--roll the dice!
		local n_percentage = math.random(1, 100);
				
		--find the level class to use based on the percentage rolled
		for n_index, tRange in pairs(t_levelClassChance) do
			
			if n_percentage >= tRange.Min and n_percentage <= tRange.Max then
			n_levelClass = n_index;
			break;
			end
			
		end
		
	end
	
--get the a random monster from the chosen monster class table
local nMonsterIndex = math.random(1, #tMonsters.levelClass[n_levelClass]);

--return the chosen monster
return tMonsters.levelClass[n_levelClass][nMonsterIndex]
end



--[[>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Monsters.spawnLevel(Integer)
Populates the specified level
with random monsters...AHHHHHH!
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<]]
function spawnLevel(nLevel)
--the number of spawn attempts made (prevents an infinite loop)
local nSpawnAttempts = 0;
--the number of allowed spawn attempts (altered below)
local nAllowedSpawnAttempts = 0;
--get the party entity
local hParty = findEntity("party");
--used to find all of the available spawn tiles in the level
local tSpawnableTiles = {};
--the mean (or average) party level
local nMeanPartyLevel = 0;
--the minumum monster level allowed on spawn
local nMinLevelAllowed = tMonsters.levelLimits.baseLevels.Min;
--the maximum monster level allowed on spawn
local nMaxLevelAllowed = tMonsters.levelLimits.baseLevels.Max;
--the AI table used to randomly set each monster's AI state
local tAI = {"default","guard"};
--see main table for a description of the 'nMinPartyDist' variable
local nMinPartyDist = tMonsters.minPartyDistance;
--see main table for a description of the 'nMinMonsterDist' variable
local nMinMonsterDist = tMonsters.minMonsterDistance;
--[[a certain number<***> stored in the 'nAddative' variable will modify the level's
	base number of spawned monsters . The number below stored in the 'nAlternator'
	variable will determine whether that 'nAddative' modifier will add to the base
	number or subtract from it.]]
local nAlternator = util.Math_GetAlternator();
--this is the base number of monsters that will spawn in this level
local nMonsters = tMonsters.BaseCount[nLevel];
	
	--make sure the spawn record is kept updated
	if not tMonsters.spawned[nLevel] then
	tMonsters.spawned[nLevel] = {};
	end
	
	--used if min and max monster levels are based on champions' levels, otherwise ignored
	local nLowestChampionLevel = 10000;
	local nHighestChampionLevel = 1;
		
	--get the mean party level
	for nChampionID = 1, 4 do
	local uChampion = hParty:getChampion(nChampionID);
	local nMyLevel = uChampion:getLevel();
	nMeanPartyLevel = nMeanPartyLevel + nMyLevel;
		
		--record the lowest level
		if nMyLevel < nLowestChampionLevel then
		nLowestChampionLevel = nMyLevel;
		end
		
		--record the highest level
		if nMyLevel > nHighestChampionLevel then
		nHighestChampionLevel = nMyLevel;
		end
		
	end
	
	--adjust the min monster level (if applicable)
	if tMonsters.levelLimits.useChampionAsMinLevel then
	nMinLevelAllowed = nLowestChampionLevel;
	end
	
	--adjust the max monster level (if applicable)
	if tMonsters.levelLimits.useChampionAsMaxLevel then
	nMaxLevelAllowed = nHighestChampionLevel;
	end
	
	--finish the mean party level calculation
	nMeanPartyLevel = (nMeanPartyLevel / 4);
		
	--determine the addative value that will modify the base number of monsters in this level
	local nAddative = nMeanPartyLevel * tMonsters.baseCountVar--<***> the 'certain number' as mentioned above
	--[[add or subtract (depending on the alternator) the 'nAddative' number to/from the base number of monsters
		to get the final value of mosters to use for this level]]
	local nMonsters = nMonsters + (nAlternator * math.ceil(nAddative));
	
	--adjust the max allowed spawn attempts to reflect the number of monsters in this level
	nAllowedSpawnAttempts = nMonsters * tMonsters.maxSpawnAttemptsFactor;
	
	--go through each tile in the level and determine if it is a wall or not
	for nPseudoX = 1, 32 do
	tSpawnableTiles[nPseudoX] = {};
		
		for nPseudoY = 1, 32 do
		tSpawnableTiles[nPseudoX][nPseudoY] = isWall(nLevel, nPseudoX - 1, nPseudoY - 1);
		end
	
	end
	
	--we'll keep this loop going until all the monsters have been spawned
	repeat
	--let the algoritm know we're making a spawn attempt (prevents an infinite loop)
	nSpawnAttempts = nSpawnAttempts + 1;
	--get a random x value
	local nPseudoX = math.random(1, 32);
	local nX = nPseudoX - 1;
	--get a random y value
	local nPseudoY = math.random(1, 32);
	local nY = nPseudoY - 1;
	--the monster's facing on spawn (randomized below)
	local nFacing = 0;
				
		-- if the tile is not a wall				
		if tSpawnableTiles[nPseudoX][nPseudoY] == false then
		local bSpawnHere = true;
			
			--make sure the tile is empty
			for tEntity in entitiesAt(nLevel, nX, nY) do
			bSpawnHere = false;
			break;
			end
			
			if bSpawnHere then
			--disallow future spawning at this tile
			tSpawnableTiles[nPseudoX][nPseudoY] = true;
			
				--make sure the monster is not facing a wall
				local tFacings = {[1]=-1,[2]=-1,[3]=-1,[4]=-1,};
				local tFacingsUsed = {0,1,2,3};
				
				--randomize the facings so monsters do not tend toward north by default
				for x = 1, 4 do
				local n_index = math.random(1, #tFacingsUsed);
				tFacings[x] = tFacingsUsed[n_index];
				table.remove(tFacingsUsed, n_index);
				end
				
				--get the monster's facing
				for nFacingIndex, nFacingValue in pairs(tFacings) do
										
					if not util.dungeon_adjacentCellIsWall(nLevel, nFacingValue, nX, nY) then
					nFacing = nFacingValue;
					break;
					end
				
				end
			
				--check to make sure the tile is at least the minimum x distance from the party
				if math.abs(hParty.x - nX) > nMinPartyDist then
					
					--check to make sure the tile is at least the minimum y distance from the party
					if math.abs(hParty.y - nY) > nMinPartyDist then
					--get the random monster to spawn
					local sMonsterClass = Monsters.getRandom(nLevel);
					--this prevents duplicate IDs
					sMonsterID = "monster_"..sMonsterClass.."_"..tostring(nLevel).."_"..tostring(nX).."_"..tostring(nY)..util.string_generateUUID(tostring(math.random(1, 100))..sMonsterClass);
					--add this monster to the list of monsters spawned in this level
					tMonsters.spawned[nLevel][#tMonsters.spawned[nLevel] + 1] = sMonsterID;
					--spawn the beast!
					spawn(sMonsterClass, nLevel, nX, nY, nFacing, sMonsterID);
					--get the monsters ID
					local hMonster = findEntity(tostring(sMonsterID));					
					--set the monster's AI state (as discussed above)
					hMonster:setAIState(tAI[math.random(1, #tAI)]);
					--calculate the monster's level based in the mean party level as well as the dungeon level and adjusted for a little variety in difficulty
					local nMonsterLevel = util.math_upOrDown(nMeanPartyLevel + (tMonsters.baseLevelVar * math.random(1, nLevel)));
						
						--make sure the monster's level does not exceed the allowed lower limits
						if nMonsterLevel < nMinLevelAllowed then
						nMonsterLevel = nMinLevelAllowed;
						end
						
						--make sure the monster's level does not exceed the allowed upper limits
						if nMonsterLevel > nMaxLevelAllowed then
						nMonsterLevel = nMaxLevelAllowed;					
						end
					
					--set the monster's level
					hMonster:setLevel(nMonsterLevel);
					
					--inform the algorithm that one of the monsters has spawned
					nMonsters = nMonsters - 1;
					end
					
				end				
				
			end
			
		end
		
	until (nMonsters == 0 or nSpawnAttempts >= nAllowedSpawnAttempts)
	
end