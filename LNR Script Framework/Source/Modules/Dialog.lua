tDialog = {
	ActiveState = "",	
	Dialog = {
		IsOpen = false,
		ID = "",
	},
	States = {
		["Shop"] = {
			
		},
		["None"] = {},
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


function DrawAll()




	

end



--[[
-----------------------------
Dialog.GetDialogOpen()
Return Type: table
Method Type: internal
-----------------------------
Returns the table containing
the information regarding
any open dialog and to which
NPC it belongs.
]]
function GetOpen()
return tDialog.Dialog
end



--[[
------------------------------------------------
Dialog.SetOpen(boolean or nil, string or nil)
Return Type: table
Method Type: external
-------------------------------------------------
Sets whether or not a dialog is open and, if so,
to which NPC it belongs.
Returns the table containing the information regarding
any open dialog and to which NPC it belongs.
Note: If either variable is nil, the ID is blank or
the 'bOpen' variable is false, it will set the
dialog as closed. This is intended for convenience.
]]
function SetOpen(sID, bOpen)
local bIsOpen = false;
local sMyID = "";
	
	if NPC.Exists(sID) and Util.VarIsValid({"b","l"}, bOpen) then
	sID = string.lower(sID);
		
		if bOpen then
		
			if type(sID) == "string" then
				
				if string.gsub(sID, " ", "") ~= "" then				
				bIsOpen = bOpen;
				sMyID = sID;		
				end
						
			end
			
		end
		
	end
		
tDialog.Dialog.IsOpen = bIsOpen;
tDialog.Dialog.ID = sMyID;
return tDialog.Dialog
end



function SetState(sState)
	
	if type(sState) == "string" then
	
		if tGUI.States[sState] then	
		tGUI.ActiveState = sState;
	
		else
		tGUI.ActiveState = "";
		
		end
	
	else
	tGUI.ActiveState = "";
	
	end

end

function GetState()
return tGUI.ActiveState
end