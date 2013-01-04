tGame = {	
	--DataModules = These are stored in the Game.GetDataMethods() method
	DataModuleEntity = "dungeon_wall_text_long",
};

function GetDataMethods()
local tMethods = {
	["NPC"] = NPC,
};

return tMethods
end


--[[
----------------
Game.Save()
Return Type: nil
----------------
This will store all non-persistent
data in wall text(s) so the data
can be recalled by Game.Load().
]]
function Save()
local tMethods = Game.CheckDataModules();

	for sClass, tClass in pairs(tMethods) do
	--get the entity that will store the data
	local hDataModule = GetDataModule(sClass);
	--get the table that needs to be converted to string
	local tData = tClass.GetDataTable();
	--convert the table to a string
	local sData = Util.TableToString(tData, 1);
	--create the funciton to return the data
	--local sFunction = "function ReturnData()\nlocal tRet = "..sData..";\nreturn tRet\nend";
	--store the new function in the data module object
	hDataModule:setWallText(sData);
	end

end


--have the monsters spawn only if they have not....load them from the data file is they've been stored...nevermind...game will save monsters


function Load()
local tMethods = Game.CheckDataModules();
	
	for sClass, tClass in pairs(tMethods) do
	--get the entity that will store the data
	local hDataModule = GetDataModule(sClass)
	--get the table that holds the data to load
	local tData = Util.StringToTable(hDataModule:getWallText());
	tClass.SetDataTable(tData);
	--local tData = tClass.GetDataTable();
	--convert the table to a string
	end
	
end


function GetDataModuleID(sClass)
return "data_module_"..string.lower(string.gsub(sClass, " ", "_"));
end

function GetDataModule(sClass)
local sID = GetDataModuleID(sClass)
return findEntity(sID)
end


function CheckDataModules()
local tMethods = GetDataMethods();

	for sClass, tClass in pairs(tMethods) do
	sID = Game.GetDataModuleID(sClass);
		
		if not findEntity(sID) then
		spawn(tGame.DataModuleEntity, 1, 0, 0, 0, sID);
		end
		
	end

return tMethods
end