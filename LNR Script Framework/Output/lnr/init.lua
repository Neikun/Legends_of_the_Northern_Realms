--load all the classes and methods before hand to appease the hook functions
import('mod_assets/lnr/ClassMasterFile.lua');
--import the modified party
import("mod_assets/lnr/party.lua");

local tLNRModules = {};

function LoadModule(sModule, sScript)
tLNRModules[#tLNRModules + 1] = {
	Module = sModule,
	Script = sScript,
};
end

function ImportModule(sModule)
	
	if not tLNRModules[sModule] then
	import('mod_assets/lnr/modules/'..sModule..'.lua')
	end
	
end

--import each module in the desired load order
ImportModule("Dialog");
ImportModule("Game");
ImportModule("GUI");
--ImportModule("Help");
ImportModule("Monsters");
ImportModule("NPC");
ImportModule("Party");
--ImportModule("Quest");
--ImportModule("Shop");
ImportModule("Util");


cloneObject {
	name = "LNR Script Framework",
	baseObject = "dungeon_door_wooden",
	onOpen = function(hDoor)
	
		for nIndex, tModule in pairs(tLNRModules) do		
		spawn("script_entity", 1, 0, 0, 0, tModule.Module);
		local hScript = findEntity(tModule.Module);
		hScript:setSource(tModule.Script);
		end
		
	hDoor:close();
	end,
	onClose = function(sDoor)
	hDoor:destroy();
	end,
}