--[[
By Centauri Soldier
CentauriSoldier@MadGamerHideout.net

<<<Current Version>>>
1.0

<<<Version History>>>
1.0
Added the ability to use party min and max levels for monster min and max spawn levels

0.9
Added monster minimum and maximum level limits
Added the UpOrDown() function

0.8
Enhanced the facing subroutine to include random spawn facings

0.7
Added a subroutine that ensures monsters do not face walls when spawning

0.6
Fixed a bug that caused monsters to have invalid spawn locations
Added a subroutine that prevents infinite looping, looping,...

0.5
Added a subroutine that checks for minimum distance from the party
Renamed some variables

0.4
Added the AdjacentCellIsWall() function
Fixed some logic erros in cell versus table index for tiles

0.3
Added the GetUUID() funciton
Added the GetAlternator() function
Fixed the some minor bugs

0.2
Fixed several bugs in the generator code

0.1
Made the basic generator code to create random monsters


Licensed under Attribution 3.0 Unported
Use, edit and distribute as you like.
Please give credit if you do (the
first two lines of this license comment).

License Details
http://creativecommons.org/licenses/by/3.0/

Usage:
Create a script entity
called 'Monsters' and place
this code in it.
Call Monsters.Init() and
Monsters.SpawnLevel(nLevel) using the
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
	BaseCount = {
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
	BaseCountVar = math.random(4, 27) / 10,
	--used to determine the variance in monster level
	BaseLevelVar = math.random(5, 15) / 10,	
	--[[this table list the mosnters that may spawn on given level (includes the previous lists).
		e.g. a level 3 spawn phase may spawns monsters from table 3 as well as all monsters from tables 2 and 1
		you may arrange these how you please (even adding monsters etc.) or simply leave them as they are]]
	LevelClass = {
		[1] = {"skeleton_warrior","herder","snail"},
		[2] = {"herder_small","skeleton_patrol","skeleton_archer"},
		[3] = {"crowern","herder_big","skeleton_archer_patrol"},
		[4] = {"spider","scavenger","herder_swarm"},
		[5] = {"tentacles","green_slime","warden"},
		[6] = {"ogre","crab","uggardian"},
		[7] = {"wyvern","ice_lizard","scavenger_swarm"},
		[8] = {"goromorg","shrakk_torr","cube"},	
	},
	LevelLimits = {
		BaseLevels = {
			--this is the minimum allowed level for a spawning monster		
			Min = 1,
			--this is the maximum allowed level for a spawning monster
			Max = 25,
		},
		--[[if this is set to 'true', the 'BaseLevels' 'Min' value will
			be ignored and the champion with lowest level will be used
			to calculate the max level allowed.]]
		UseChampionAsMinLevel = true,
		--[[if this is set to 'true', the 'BaseLevels' 'Max' value will
			be ignored and the champion with highest level will be used
			to calculate the max level allowed.]]
		UseChampionAsMaxLevel = false,			
	},
	--prevents infinite loops in the spawn loop (this number is basically the spawn attemps allowed per monster <shared value>)
	MaxSpawnAttemptsFactor = 10,
	--the minimum tiles (x and y) between the party and the each spawning monster
	MinPartyDistance = 2,
	--NOT YET USED...will prevent monsters from spawning in tight groups (does not affect group entities)
	MinMonsterDistance = 0,
	--used to ensure that multiple spawn sessions per level do not occur [DO NOT EDIT THIS ENTRY]
	Spawned = {},
};



--[[>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Monsters.AdjacentCellIsWall(Integer, Integer, Integer, Integer)
Used to determine if a cell adjacent to
the input cell is a wall. This is, of course,
relative to the input facing.
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<]]
function AdjacentCellIsWall(nLevel, nFacing, nX, nY)

	if nFacing == 0 then
	nY = nY - 1;
	
	elseif nFacing == 1 then
	nX = nX + 1;
	
	elseif nFacing == 2 then
	nY = nY + 1;
	
	elseif nFacing == 3 then
	nX = nX - 1;
	
	end
	
	if nX > -1 and nX < 32 and nY > -1 and nY < 32 then
	return isWall(nLevel, nX, nY)
	end
	
return true
end



--[[>>>>>>>>>>>>>>>>>>>>>>>>>>
Monsters.GenerateUUID(String)
Creates a Universal Unique
Identifier that may contain
a prefix.
<<<<<<<<<<<<<<<<<<<<<<<<<<<<]]
function GenerateUUID(sPrefix)
local tChars = {"x","3","y","1","b","2","p","e","8","f","v","t","g","9","h","7","u","4","i","z","a","j","0","c","k","l","5","m","n","w","o","q","r","s","d","6"};
local tSequence = {1,4,4,4,12};
local sUUID = "";
local nMaxPrefixLength = 6; --range from 0 to 8
local sDelimiter = "-";

if type(sPrefix) == "string" then
local nLength = string.len(sPrefix);
	
	if nLength > nMaxPrefixLength then
	sPrefix = string.sub(sPrefix, 1, nMaxPrefixLength);
	end
	
	if string.gsub(sPrefix, " ", "") ~= "" then
	sUUID = sPrefix..sDelimiter;
	end
	
	if nLength < nMaxPrefixLength then
	tSequence[1] = tSequence[1] + (nMaxPrefixLength - nLength);
	end
	
else
tSequence[1] = 8;
end

--fix the - at the end...
for nIndex, nSequence in pairs(tSequence) do
	
	for x = 1, nSequence do
	sUUID = sUUID..tChars[math.random(1, 36)];
	end

sUUID = sUUID.."-";
end

return sUUID
end



--[[>>>>>>>>>>>>>>>>>>>>>>>>>>
Monsters.GetAlternator
Gets a random number:
either 1 or -1.
<<<<<<<<<<<<<<<<<<<<<<<<<<<<]]
function GetAlternator()
return (-1) ^ math.random(1,2)
end



--[[>>>>>>>>>>>>>>>>>>>>>>>>>>
Monsters.GetRandom(Inetger)
Gets a random monster which
is allowed to spawn in the
specified level.
<<<<<<<<<<<<<<<<<<<<<<<<<<<<]]
function GetRandom(nMaxLevelClass)
--floor the input value to unsure it's an integer
nMaxLevelClass = math.floor(nMaxLevelClass);
--the level class table index that will be used when all calculations are done
local nLevelClass = 1;

	--determine which level class will be used and check for number validity
	if nMaxLevelClass > 1 then
	local nLevelClasses = #tMonsters.LevelClass;
	--[[total summation of this level's value plus previous levels' values
		e.g. the total value if using level three would be 3 + 2 + 1 = 6]]
	local nTotal = 0;
	--the chance that a monster will spawn from a level class table
	local tLevelClassChance = {};
	
		--make sure the input value is not higher then the max number of level class tables
		if nMaxLevelClass > nLevelClasses then
		nMaxLevelClass = nLevelClasses;
		end
			
		--get the total values of each level up to this one
		for nCurrentLevel = 1, nMaxLevelClass do
		nTotal = nTotal + nCurrentLevel;
		end
		
		--store the last percentage calculated
		local nLastNumber = 0;
		
		--get the spawn percentage for each level class
		for nCurrentLevel = 1, nMaxLevelClass do
		local nMyPercentage = math.floor((nCurrentLevel / nTotal) * 100);
		
		tLevelClassChance[nCurrentLevel] = {
			Min = nLastNumber,
			Max = nMyPercentage,
		};

		nLastNumber = nMyPercentage + 1;
		end
			
		--roll the dice!
		local nPercentage = math.random(1, 100);
				
		--find the level class to use based on the percentage rolled
		for nIndex, tRange in pairs(tLevelClassChance) do
			
			if nPercentage >= tRange.Min and nPercentage <= tRange.Max then
			nLevelClass = nIndex;
			break;
			end
			
		end
		
	end
	
--get the a random monster from the chosen monster class table
local nMonsterIndex = math.random(1, #tMonsters.LevelClass[nLevelClass]);

--return the chosen monster
return tMonsters.LevelClass[nLevelClass][nMonsterIndex]
end



--[[>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Monsters.SpawnLevel(Integer)
Populates the specified level
with random monsters...AHHHHHH!
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<]]
function SpawnLevel(nLevel)
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
local nMinLevelAllowed = tMonsters.LevelLimits.BaseLevels.Min;
--the maximum monster level allowed on spawn
local nMaxLevelAllowed = tMonsters.LevelLimits.BaseLevels.Max;
--the AI table used to randomly set each monster's AI state
local tAI = {"default","guard"};
--see main table for a description of the 'nMinPartyDist' variable
local nMinPartyDist = tMonsters.MinPartyDistance;
--see main table for a description of the 'nMinMonsterDist' variable
local nMinMonsterDist = tMonsters.MinMonsterDistance;
--[[a certain number<***> stored in the 'nAddative' variable will modify the level's
	base number of spawned monsters . The number below stored in the 'nAlternator'
	variable will determine whether that 'nAddative' modifier will add to the base
	number or subtract from it.]]
local nAlternator = GetAlternator();
--this is the base number of monsters that will spawn in this level
local nMonsters = tMonsters.BaseCount[nLevel];
	
	--make sure the spawn record is kept updated
	if not tMonsters.Spawned[nLevel] then
	tMonsters.Spawned[nLevel] = {};
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
	if tMonsters.LevelLimits.UseChampionAsMinLevel then
	nMinLevelAllowed = nLowestChampionLevel;
	end
	
	--adjust the max monster level (if applicable)
	if tMonsters.LevelLimits.UseChampionAsMaxLevel then
	nMaxLevelAllowed = nHighestChampionLevel;
	end
	
	--finish the mean party level calculation
	nMeanPartyLevel = (nMeanPartyLevel / 4);
		
	--determine the addative value that will modify the base number of monsters in this level
	local nAddative = nMeanPartyLevel * tMonsters.BaseCountVar--<***> the 'certain number' as mentioned above
	--[[add or subtract (depending on the alternator) the 'nAddative' number to/from the base number of monsters
		to get the final value of mosters to use for this level]]
	local nMonsters = nMonsters + (nAlternator * math.ceil(nAddative));
	
	--adjust the max allowed spawn attempts to reflect the number of monsters in this level
	nAllowedSpawnAttempts = nMonsters * tMonsters.MaxSpawnAttemptsFactor;
	
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
				local nIndex = math.random(1, #tFacingsUsed);
				tFacings[x] = tFacingsUsed[nIndex];
				table.remove(tFacingsUsed, nIndex);
				end
				
				--get the monster's facing
				for nFacingIndex, nFacingValue in pairs(tFacings) do
										
					if not AdjacentCellIsWall(nLevel, nFacingValue, nX, nY) then
					nFacing = nFacingValue;
					break;
					end
				
				end
			
				--check to make sure the tile is at least the minimum x distance from the party
				if math.abs(hParty.x - nX) > nMinPartyDist then
					
					--check to make sure the tile is at least the minimum y distance from the party
					if math.abs(hParty.y - nY) > nMinPartyDist then
					--get the random monster to spawn
					local sMonsterClass = Monsters.GetRandom(nLevel);
					--this prevents duplicate IDs
					sMonsterID = "monster_"..sMonsterClass.."_"..tostring(nLevel).."_"..tostring(nX).."_"..tostring(nY)..Monsters.GenerateUUID(tostring(math.random(1, 100))..sMonsterClass);
					--add this monster to the list of monsters spawned in this level
					tMonsters.Spawned[nLevel][#tMonsters.Spawned[nLevel] + 1] = sMonsterID;
					--spawn the beast!
					spawn(sMonsterClass, nLevel, nX, nY, nFacing, sMonsterID);
					--get the monsters ID
					hMonster = findEntity(tostring(sMonsterID));					
					--set the monster's AI state (as discussed above)
					hMonster:setAIState(tAI[math.random(1, #tAI)]);
					--calculate the monster's level based in the mean party level as well as the dungeon level and adjusted for a little variety in difficulty
					local nMonsterLevel = Monsters.UpOrDown(nMeanPartyLevel + (tMonsters.BaseLevelVar * math.random(1, nLevel)));
						
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



--[[>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Monsters.UpOrDown(Integer)
A utility function that returns
an integer value to the
(randomly chosen) nearest high
or low value.
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<]]
function UpOrDown(nValue)
		
		if math.random() < 0.5 then
		return math.floor(nValue)
		else
		return math.ceil(nValue)
		end
	
	end