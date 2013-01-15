LoadModule("GUI",[[
tGUI = {};







--onDrawGui: a hook which is called after the dungeon view has been rendered.
function onDraw(h_gui)

	-- draw dialog is one is active
	if Dialog.isActivated() then
		Dialog.onDraw(h_gui)
	end
	
end

--onDrawInventory: a hook which is called after a champion’s inventory screen has been rendered.
function onDrawInventory(h_gui)
	-- removed return value; has no effect
end

--onDrawStats: a hook which is called after a champion’s stats screem has been rendered.
function onDrawStats(h_gui)
	-- removed return value; has no effect
end

--onDrawSkills: a hook which is called after a champion’s skills screen has been rendered.
function onDrawSkills(h_gui)
	-- removed return value; has no effect
end



]]);