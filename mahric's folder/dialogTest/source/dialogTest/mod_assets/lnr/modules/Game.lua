LoadModule("Game",[[
tGame = {	
	--DataModules = These are stored in the Game.GetModuleClasses() method
	DataModuleEntity = "dungeon_wall_text_long",
	Initialized = false,
};

function GetInitialized()
return tGame.Initialized
end

function SetInitialized(bInitialized)
	
	if type(bInitialized) == "boolean" then
	tGame.Initialized = bInitialized;
	else
	tGame.Initialized = false;
	end
	
end



function CheckDataModules()
local tMethods = GetModuleClasses();

	for sClass, tClass in pairs(tMethods) do
	sID = Game.GetDataModuleID(sClass);
		
		if not findEntity(sID) then
		spawn(tGame.DataModuleEntity, 1, 0, 0, 0, sID);
		end
		
	end

return tMethods
end



function GetModuleClasses()
local tClasses = {
	["Dialog"] = Dialog,
	["Game"] = Game,
	["GUI"] = GUI,
	["Help	"] = Help,
	["NPC"] = NPC,
	["Party"] = Party,
	["Quest"] = Quest,
	["Shop"] = Shop,
};

return tClasses
end



function GetClassMethods(sClass)
local tMethdods = {
	["Dialog"] = {},
	["Game"] = {},
	["GUI"] = {},
	["Help	"] = {},
	["NPC"] = {},
	["Party"] = {},
	["Quest	"] = {},	
};

return tMethdods
end




function GetDataModuleID(sClass)
return "data_module_"..string.lower(string.gsub(sClass, " ", "_"));
end



function GetDataModule(sClass)
local sID = GetDataModuleID(sClass)
return findEntity(sID)
end



function Load()
local tMethods = Game.CheckDataModules();

	for sClass, tClass in pairs(tMethods) do
	--get the entity that stores the data
	local hDataModule = GetDataModule(sClass)
	--get the table that holds the data to load
	local tData = Util.Table_FromString(hDataModule:getWallText());
	tClass.SetDataTable(tData);
	end

end



function Save()
local tMethods = Game.CheckDataModules();

	for sClass, tClass in pairs(tMethods) do
	--get the entity that will store the data
	local hDataModule = GetDataModule(sClass);
	--get the table that needs to be converted to string
	local tData = tClass.GetDataTable();
	--convert the table to a string
	local sData = Util.Table_ToString(tData);
	--create the function to return the data
	--local sFunction = "function ReturnData()\nlocal tRet = "..sData..";\nreturn tRet\nend";
	--store the new function in the data module object
	hDataModule:setWallText(sData);
	end

end
]]);