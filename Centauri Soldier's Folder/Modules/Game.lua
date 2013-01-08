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


--[[
-----------------------
Game.CheckDataModules()
Return Type: nil
Method Type: internal
-----------------------
This ensures that all data
modules exist. If they do not,
they are created. This also
returns a table containing a
list of methods.
]]
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


--[[
-----------------------
Game.GetModuleClasses()
Return Type: table
Method Type: internal
-----------------------
This gets each class that
stores the appropriate method
for the required data module.
Used for checking the data
modules or gettting the class
for some other use in other
modules.
Note: Excludes some modules
intentionally as they may not
be designed or suited for use
with the methods that call this.
]]
function GetModuleClasses()
local tClasses = {
	["Dialog"] = Dialog,
	["Game"] = Game,
	["GUI"] = GUI,
	["Help	"] = Help,
	["NPC"] = NPC,
	["Party"] = Party,
	["Quest	"] = Quest,	
};

return tClasses
end


--[[
----------------------
Game.GetClassMethods()
Return Type: table
Method Type: internal
----------------------
This gets each method in
a given class.
Used for getting a list of
methods as strings. This is
good for allowing the input
of functions as strings in a
method's argument (that's a
mouthful).
Note: Excludes some modules
intentionally as they may not
be designed or suited for use
with the methods that call this.
]]
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



--[[
----------------------
Game.GetDataModuleID()
Return Type: string
Method Type: internal
----------------------
Used for keeping the
data module id the same
universally throughout
all methods.
]]
function GetDataModuleID(sClass)
return "data_module_"..string.lower(string.gsub(sClass, " ", "_"));
end


--[[
---------------------
Game.GetDataModule()
Return Type: table
Method Type: internal
---------------------
This will load all non-persistent
data from data modules (wall text(s)).
]]
function GetDataModule(sClass)
local sID = GetDataModuleID(sClass)
return findEntity(sID)
end


--[[
---------------------
Game.Load()
Return Type: table
Method Type: external
---------------------
This will load all non-persistent
data from data modules (wall text(s)).
]]
function Load()
local tMethods = Game.CheckDataModules();

	for sClass, tClass in pairs(tMethods) do
	--get the entity that stores the data
	local hDataModule = GetDataModule(sClass)
	--get the table that holds the data to load
	local tData = Util.Table.FromString(hDataModule:getWallText());
	tClass.SetDataTable(tData);
	end

end


--[[
---------------------
Game.Save()
Return Type: nil
Method Type: external
---------------------
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
	local sData = Util.Table.ToString(tData);
	--create the function to return the data
	--local sFunction = "function ReturnData()\nlocal tRet = "..sData..";\nreturn tRet\nend";
	--store the new function in the data module object
	hDataModule:setWallText(sData);
	end

end