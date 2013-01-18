--load all the classes and methods before hand to appease the hook functions
import('mod_assets/lnr/ClassMasterFile.lua');
--import the modified party
import("mod_assets/lnr/party.lua");

local t_LNRModules = {};

function LoadModule(s_module, s_script)
s_module = string.lower(s_module);

t_LNRModules[#t_LNRModules + 1] = {
	module = s_module,
	script = s_script,
};
end

function importModule(s_module)
s_module = string.lower(s_module);

	if not t_LNRModules[s_module] then
	import('mod_assets/lnr/modules/'..s_module..'.lua')
	end
	
end

--import each module in the desired load order
-----importModule("Dialog");
importModule("game");
-----importModule("GUI");
--importModule("Help");
importModule("monsters");
importModule("npc");
importModule("party");
--importModule("Quest");
--importModule("Shop");
importModule("util");


cloneObject {
	name = "LNR Script Framework",
	baseObject = "dungeon_door_wooden",
	onOpen = function(hDoor)
	
		for n_index, t_module in pairs(t_LNRModules) do		
		spawn("script_entity", 1, 0, 0, 0, t_module.module);
		local h_script = findEntity(t_module.module);
		h_script:setSource(t_module.script);
		end
		
		--init all of the modules
		
		--add all npc objects to the npc table
		
		
	hDoor:close();
	end,
	onClose = function(sDoor)
	hDoor:destroy();
	end,
}