LoadModule("GUI",[[
tGUI = {};







--onDrawGui: a hook which is called after the dungeon view has been rendered.
function OnDraw(hGUI)

end

--onDrawInventory: a hook which is called after a championís inventory screen has been rendered.
function OnDrawInventory(hGUI)
	
	if Dialog.GetState() ~= "" then
	return false
	end
	
end

--onDrawStats: a hook which is called after a championís stats screem has been rendered.
function OnDrawStats(hGUI)
	
	if Dialog.GetState() ~= "" then
	return false
	end
	
end

--onDrawSkills: a hook which is called after a championís skills screen has been rendered.
function OnDrawSkills(hGUI)
	
	if Dialog.GetState() ~= "" then
	return false
	end
	
end



]]);