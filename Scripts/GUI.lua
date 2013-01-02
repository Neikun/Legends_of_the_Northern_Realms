tGUI = {
	ActiveState = "",
	States = {
		["Shop"] = {
			Active = false,		
		},
	},
};

--[[
All base GUI functions get one parameter, a gui context object (see below).
	width: returns the width of the screen.
    height returns the height of the screen.
    mouseX: x-coordinate of the mouse cursor.
    mouseY: y-coordinate of the mouse cursor.
    color(red, green, blue, alpha): sets the pen color. Alpha parameter is optional (defaults to 255).
    font(font): sets the typeface (font must be “tiny”, small”, “medium” or “large”).
    drawRect(x, y, width, height): draws a filled rectangle with current pen color.
    drawImage(filename, x, y): draws an image modulated with current pen color.
    drawText(text, x, y): draws a line of text with current typeface and pen color.
    button(id, x, y, width, height): returns true if the mouse was clicked in the given button rectangle. id must be a unique string identifier.
    mouseDown(button): returns true if a mouse button is down (0=left, 1=middle, 2=right).
    keyDown(key): returns true if the given key is down.
]]



function DrawState()


end

--onDrawGui: a hook which is called after the dungeon view has been rendered.
function OnDraw(hGUI)

	if GUI.GetState() == "Shop" then
	
	end

end

--onDrawInventory: a hook which is called after a champion’s inventory screen has been rendered.
function OnDrawInventory(hGUI)

end

--onDrawStats: a hook which is called after a champion’s stats screem has been rendered.
function OnDrawStats(hGUI)

end

--onDrawSkills: a hook which is called after a champion’s skills screen has been rendered.
function OnDrawSkills(hGUI)

end


function SetState(sState)

	if tGUI.States[sState] then
	tGUI.ActiveState = sState;
	end

end

function GetState()
return tGUI.ActiveState
end