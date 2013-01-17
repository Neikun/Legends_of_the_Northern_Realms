tGame = {	
	--DataModules = These are stored in the game.getModuleClasses() method
	DataModuleEntity = "dungeon_wall_text_long",
	Initialized = false,
};

function getInitialized()
return tgame.Initialized
end

function SetInitialized(bInitialized)
	
	if type(bInitialized) == "boolean" then
	tgame.Initialized = bInitialized;
	else
	tgame.Initialized = false;
	end
	
end


--[[
-----------------------
game.checkDataModules()
Return Type: nil
Method Type: internal
-----------------------
This ensures that all data
modules exist. If they do not,
they are created. This also
returns a table containing a
list of methods.
]]
function checkDataModules()
local t_methods = getModuleClasses();

	for sClass, tClass in pairs(t_methods) do
	sID = game.getDataModuleID(sClass);
		
		if not findEntity(sID) then
		spawn(tgame.DataModuleEntity, 1, 0, 0, 0, sID);
		end
		
	end

return t_methods
end


--[[
-----------------------
game.getModuleClasses()
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
function getModuleClasses()
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


--[[
----------------------
game.getClassMethods()
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
function getClassMethods(sClass)
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
game.getDataModuleID()
Return Type: string
Method Type: internal
----------------------
Used for keeping the
data module id the same
universally throughout
all methods.
]]
function getDataModuleID(sClass)
return "data_module_"..string.lower(string.gsub(sClass, " ", "_"));
end


--[[
---------------------
game.getDataModule()
Return Type: table
Method Type: internal
---------------------
This will load all non-persistent
data from data modules (wall text(s)).
]]
function getDataModule(sClass)
local sID = getDataModuleID(sClass)
return findEntity(sID)
end


--[[
---------------------
game.load()
Return Type: table
Method Type: external
---------------------
This will load all non-persistent
data from data modules (wall text(s)).
]]
function load()
local t_methods = game.checkDataModules();

	for sClass, tClass in pairs(t_methods) do
	--get the entity that stores the data
	local hDataModule = game.getDataModule(sClass)
	--get the table that holds the data to load
	local tData = util.table_fromString(hDataModule:getWallText());
	tClass.SetDataTable(tData);
	end

end


--[[
---------------------
game.save()
Return Type: nil
Method Type: external
---------------------
This will store all non-persistent
data in wall text(s) so the data
can be recalled by game.load().
]]
function save()
local t_methods = game.checkDataModules();

	for sClass, tClass in pairs(t_methods) do
	--get the entity that will store the data
	local hDataModule = game.getDataModule(sClass);
	--get the table that needs to be converted to string
	local tData = tClass.GetDataTable();
	--convert the table to a string
	local sData = util.table_toString(tData);
	--create the function to return the data
	--local sFunction = "function ReturnData()\nlocal t_ret = "..sData..";\nreturn t_ret\nend";
	--store the new function in the data module object
	hDataModule:setWallText(sData);
	end

end