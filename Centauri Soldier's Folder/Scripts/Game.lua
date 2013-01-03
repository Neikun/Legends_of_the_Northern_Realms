tGame = {	
	DataModules = {"NPC",""},
	DataModuleEntity = "dungeon_wall_text_long",
};

--[[
----------------
Game.Save()
Return Type: nil
----------------
This will store all non-persistent
data in script(s) and so the data
can be recalled by Game.Load().
This may need to be implemented using
save points throughout the game.
]]
function Save()
Game.CheckDataModules();
	
hDataModule:setWallText();

end


--have the monsters spawn only if they have not been....load them from the data file is they've been stored.


function Load()
Game.CheckDataModules();

end


function GetDataModule(sClass)
local sID = "data_module_"..string.lower(string.gsub(sClass, " ", "_"));
return findEntity(sID)
end


function CheckDataModules()
	
	for nIndex, sClass in pairs(tGame.DataModules) do
	local sID = "data_module_"..string.lower(string.gsub(sClass, " ", "_"));
	
		if not findEntity(sID) then
		spawn(tGame.DataModuleEntity, 1, 0, 0, 0, sID);	
		end
	end
	
end
