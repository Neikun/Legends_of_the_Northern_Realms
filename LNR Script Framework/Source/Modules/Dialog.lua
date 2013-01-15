--[[
	This script contains all functions needed for dialogs.
	Please consult the wiki for a guide on how to use this module.
--]]
tDialog = {
	dialogs = {},			-- Contrains definition of all defined dialogs
	activeDialog = nil,		-- ID of dialog currently on screen
	startedAt = nil,		-- Time_played the dialog was first shown
}

--[[
------------------------------------------------
dialog.new(string, string, string or nil, string or nil)
Return Type: string (id of the dialog)
Method Type: external
-------------------------------------------------
Defines a new dialog window, but does not show it yet.
If no id is passed, one is assigned automatically.
Use the following methods to enchance the dialog:
 - addButton() -> Adds an extra button to the dialog window
 - activate()  -> Shows the defined dialog and waits for input
A maximum of one dialog window can be open at an_y time!
]]
function new(s_text, s_buttonText, s_npc, s_id)

	-- Check parameters; mandatory and/or type checking
	if type(s_text) == "string" and type(s_buttonText) == "string" and (s_npc == nil or type(s_npc) == "string") and (s_id == nil or type(s_id) == "string") then

		-- if no id is given, create a random one
		if s_id == "" or s_id == nil then
			s_id = Util.String_GenerateUUID("dlg_")
		end

		-- Get definition of existing dialog with that id
		if getDialog(s_id) == nil then
		
			-- Create a new dialog if none exists with that id
			local s_newDialog = { id = s_id,
								  text = s_text,
								  buttons = {s_buttonText},
								  npc = s_npc,
								  callBack = nil,
								}
			table.insert(tDialog.dialogs, s_newDialog)
		end
		
		return s_id
	else
		print("Calling dialog.new() with wrong number and/or type of parameters.")
	end
end

--[[
------------------------------------------------
dialog.addButton(string, string)
Return Type: none
Method Type: external
-------------------------------------------------
Adds a button with the specified buttonText to the dialog with the given id
]]
function addButton(s_id, s_buttonText)

	-- Check parameters; mandatory and/or type checking
	if type(s_id) == "string" and type(s_id) == "string" then
	
		table.insert(getDialog(s_id).buttons, 1, s_buttonText)
		
	else
		print("Calling dialog.addButton() with wrong number and/or type of parameters.")
	end
end

--[[
------------------------------------------------
dialog.activate(string, function or nil)
Return Type: none
Method Type: external
-------------------------------------------------
Activates the dialog, showing it to the player. As long as the dialog is 
shown, the party is not able to move and turn. The dialog that is returned 
will be called when the player pressed one of the buttons. The buttonText 
of the pressed button will be given as parameter.
]]
function activate(s_id, f_callBack)

	-- Check parameters; mandatory and/or type checking
	if type(s_id) == "string" and (f_callBack == nil or type(f_callBack)=="function") then
	
		-- Check if there already is an acive dialog
		if tDialog.activeDialog == nil then
		
			-- Get dialog definition
			local t_dlg = getDialog(s_id)
			if t_dlg then
			
				-- Make fetched dialog the active dialog
				t_dlg.callBack = f_callBack
				tDialog.activeDialog = s_id
				tDialog.startedAt = getStatistic("play_time")

			end
		else
			print("Can't activate a dialog while another one is active!")
		end
	else
		print("Calling dialog.activate() with wrong number and/or type of parameters.")
	end
end

--[[
------------------------------------------------
dialog.deactivate()
Return Type: none
Method Type: external
-------------------------------------------------
Deactivated the current dialog, hiding it from the player.
No button is pressed while deactivating it, so no callback is done.
]]
function deactivate()
	-- remove any active dialog (if any)
	tDialog.activeDialog = nil
	tDialog.startedAt = nil
end

--[[
------------------------------------------------
dialog.quickYesNoDialog(string, string or nil, function or nil)
Return Type: none
Method Type: external
-------------------------------------------------
A quick way to show a dialog with Yes/No buttons.
]]
function quickYesNoDialog(s_text, f_callBack, s_npc)

	-- Check parameters; mandatory and/or type checking
	if type(s_text) == "string" and (f_callBack == nil or type(f_callBack == "function")) and (s_npc == nil or type(s_npc)=="string") then
	
		-- Use standard id and get current dialogdefinition
		local s_id = "dlgQuickYesNo"
		local t_dlg = getDialog(s_id)
		
		-- Make a new dialogdefinition if none is found
		if t_dlg == nil then
			s_id = new(s_text, "Yes", s_npc, s_id)
			addButton(s_id, "No?!")
		else
			-- And replace text and npc if a dialogdefinition was found
			t_dlg.text = s_text
			t_dlg.npc = s_npc
		end
		
		-- Show the dialog
		activate(s_id, f_callBack)
		
	else
		print("Calling dialog.quickYesNoDialog() with wrong number and/or type of parameters.")
	end
end

--[[
------------------------------------------------
dialog.quickDialog(string, function or nil, string or nil)
Return Type: none
Method Type: external
-------------------------------------------------
A quick way to show a dialog with a Close button.
]]
function quickDialog(s_text, f_callBack, s_npc)

	-- Check parameters; mandatory and/or type checking
	if type(s_text) == "string" and (f_callBack == nil or type(f_callBack == "function")) and (s_npc == nil or type(s_npc)=="string") then

		-- Use standard id and get current dialogdefinition
		local s_id = "dlgQuickClose"
		local t_dlg = getDialog(s_id)
		
		-- Make a new dialogdefinition if none is found
		if t_dlg == nil then
			s_id = new(s_text, "Close", s_npc, s_id)
		else
			-- And replace text and npc if a dialogdefinition was found
			t_dlg.text = s_text
			t_dlg.npc = s_npc
		end

		-- Show the dialog
		activate(s_id, f_callBack)
		
	else
		print("Calling dialog.quickDialog() with wrong number and/or type of parameters.")
	end
end

--[[
------------------------------------------------
dialog.isActivated(string or nil)
Return Type: boolean
Method Type: external
-------------------------------------------------
Checks if a dialog is shown to the screen. 
Is nil returned as parameter, then this functions checks if an_y dialog 
is being shown. Is an ID returned as parameter, then this function only
checks if that specific dialog is shown.
]]
function isActivated(s_id)
	if id and type(s_id)=="string" then
		return tDialog.activeDialog == s_id
	else
		return tDialog.activeDialog ~= nil
	end
end

--[[
------------------------------------------------
dialog.isActivated(string)
Return Type: string or nil
Method Type: external
-------------------------------------------------
Returns the ID of the npc the current dialog is with.
Returns nil of no dialog is active or no npc is asociated with the current dialog.
]]
function getActiveDialogNpc()

	-- Check parameters; mandatory and/or type checking
	if id and type(s_id)=="string" then
	
		return tDialog.activeDialog.npc
		
	end
	
	return nil
end

--[[
------------------------------------------------
dialog.getDialog(string)
Return Type: none
Method Type: internal
-------------------------------------------------
Returns dialoginfo by id.
]]
function getDialog(s_id) 

	-- return dialogdefinition by id
	for _, t_dlg in pairs(tDialog.dialogs) do
		if t_dlg.id == s_id then
			return t_dlg
		end
	end
end

--[[
------------------------------------------------
dialog.onDraw(h_GUI)
Return Type: none
Method Type: internal
-------------------------------------------------
Draws the active dialog on screen and processes button clicks.
]]
function onDraw(h_GUI)
	if tDialog.activeDialog then		
		local t_dlg = getDialog(tDialog.activeDialog)
		local s_response = nil

		-- Calculate window width, starting with minimum width and adding pixels depending on content
		local n_windowWidth = 256
		-- Add 8 pixels to width for every character in the widest line of the text. But the 1st 18 characters are free
		n_windowWidth = n_windowWidth + math.max(0, (charWidth(t_dlg.text) - 18) * 8)
		-- Round to the nearest higher whole factor of 128, since tiles are 128x128
		n_windowWidth = math.ceil(n_windowWidth / 128) * 128
		
		-- Calculate offset of the window (position it in the middle of the screen)
		local n_windowOffsetX = (h_GUI.width - n_windowWidth) / 2
		
		-- Calculate window height
		local n_windowHeight = 256 -- min height
		-- Add 24 pixels to height for each line, but the first 5 lines are free
		n_windowHeight = n_windowHeight + math.max(0, (countLines(t_dlg.text) - 5) * 24)
		-- Add 24 pixels to height for extra line of the buttontext, but the first line is free
		n_windowHeight = n_windowHeight + math.max(0, (getButtonMaxLines(t_dlg.buttons) - 1) * 24)
		-- Round to the nearest higher whole factor of 128
		n_windowHeight = math.ceil(n_windowHeight / 128) * 128
		
		-- Calculate offset of the window (position it in the middle of the screen)
		local n_windowOffsetY = (h_GUI.height - n_windowHeight) / 2

		-- Draw Window in tiles of 128x128 tiles
		local n_maxX = math.floor(n_windowWidth / 128) - 1
		local n_maxY = math.floor(n_windowHeight / 128) - 1
		h_GUI.color(255, 255, 255, 255)				
		for n_y = 0, n_maxY do
			for n_x = 0, n_maxX do
				h_GUI.drawImage("mod_assets/lnr/textures/dialog/window_128_"..getTileName(n_x, n_maxX, n_y, n_maxY)..".tga", n_windowOffsetX + n_x * 128, n_windowOffsetY + n_y * 128)
			end
		end

		-- Draw text
		drawText(h_GUI, t_dlg.text, n_windowOffsetX + 40, n_windowOffsetY + 40)

		-- Draw buttons
		local n_maxLines = math.max(0, getButtonMaxLines(t_dlg.buttons) -1);
		local n_buttonOffsetX = n_windowWidth - 40
		local n_buttonOffsetY = n_windowHeight - 72 - n_maxLines * 25;
		
		for _, n_btn in pairs(t_dlg.buttons) do
		
			-- Calculate width, height and other numbers
			local n_buttonWidth = 64 + math.max(0, (charWidth(n_btn) - 2) * 8)
			n_buttonWidth = math.ceil(n_buttonWidth / 16) * 16
			local n_buttonHeight = math.ceil(32 + n_maxLines * 25)
			n_buttonHeight = math.ceil(n_buttonHeight / 16) * 16
			local n_maxX = math.ceil(n_buttonWidth / 16) - 1
			local n_maxY = math.ceil(n_buttonHeight / 16) -1

			-- Draw the button, made up of 16x16 tiles
			n_buttonX = n_windowOffsetX + n_buttonOffsetX - n_buttonWidth
			n_buttonY = n_windowOffsetY + n_buttonOffsetY 
			for n_y = 0, n_maxY do
				for n_x = 0, n_maxX do
					h_GUI.drawImage("mod_assets/lnr/textures/dialog/button_16_"..getTileName(n_x, n_maxX, n_y, n_maxY)..".tga", n_buttonX + n_x * 16, n_buttonY + n_y * 16)
				end
			end

			-- Write the buttontext
			h_GUI.font("small")
			h_GUI.color(255, 255, 255, 255)
			local n_buttonTextX = n_windowOffsetX + n_buttonOffsetX - n_buttonWidth + (n_buttonWidth - (charWidth(n_btn)+0.5) * 8) / 2
			local n_buttonTextY = n_windowOffsetY + n_buttonOffsetY + 6 + (n_buttonHeight - (countLines(n_btn)-1) * 16) / 2
			h_GUI.drawText(n_btn, n_buttonTextX, n_buttonTextY)
			
			-- Check if the button has been pressed
			if h_GUI.button(n_btn, n_buttonX, n_buttonY, n_buttonWidth, n_buttonHeight) then
				s_response = n_btn
			end
			n_buttonOffsetX = n_buttonOffsetX - n_buttonWidth - 20
		end
		
		-- Handle if one of the buttons is pressed
		if s_response then
			
			-- close the current dialog
			deactivate()
			if t_dlg.callBack then
				t_dlg.callBack(s_response)
			end
			
		end

	end
end

--[[
------------------------------------------------
dialog.getTileName(number, number, number, number)
Return Type: string
Method Type: internal
-------------------------------------------------
Helper function to determine which image can be taken from a nine-patch image like a window or button
]]
function getTileName(n_x, n_n_maxX, n_y, n_n_maxY)
	-- Determine what image to use to draw
	local s_tileName = ""
	if n_y == 0 then
		if n_x == 0 then
			s_tileName = "top_left"
		else
			if n_x == n_n_maxX then
				s_tileName = "top_right"							
			else
				s_tileName = "top_middle"
			end
		end
	else
		if n_y == n_n_maxY then
			if n_x == 0 then
				s_tileName = "bottom_left"
			else
				if n_x == n_n_maxX then
					s_tileName = "bottom_right"							
				else
					s_tileName = "bottom_middle"
				end
			end
		else
			if n_x == 0 then
				s_tileName = "middle_left"
			else
				if n_x == n_n_maxX then
					s_tileName = "middle_right"							
				else
					s_tileName = "middle_middle"
				end
			end
		end
	end
	return s_tileName
end

--[[
------------------------------------------------
dialog.drawText(entity, string, number, number)
Return Type: none
Method Type: internal
-------------------------------------------------
Draws the "text that is being said" on the window, starting at n_areaX and n_areaY.
Uses the elapsed time since activating the dialog to slowly write the text on the screen.
]]
function drawText(h_GUI, s_text, n_areaX, n_areaY)

	-- Set font size and color
	h_GUI.font("medium")
	h_GUI.color(255, 255, 255, 255)
	
	-- Determine what part of the text we need to write
	local n_textLength = math.floor((getStatistic("play_time") - tDialog.startedAt) * 30)

	h_GUI.drawText(string.sub(s_text, 1, n_textLength), n_areaX, n_areaY + 17)
end

--[[
------------------------------------------------
dialog.charWidth(string)
Return Type: number
Method Type: internal
-------------------------------------------------
Returns the maximum number of characters on a single line within the whole string.
Example: The string "Hello\nWorld!" contains 2 lines. The first line contains 5 characters, the second one is 6.
         So this function would return 6 if used on the string.
]]
function charWidth(s_text)

	local n_maxLen = 0
	local n_curLen = 0

	for n_Nr = 1, string.len(s_text) do		
		if string.sub(s_text, n_Nr, n_Nr) == "\n" then
			n_curLen = 0
		else
			n_curLen = n_curLen + 1
		end
		if n_curLen > n_maxLen then 
			n_maxLen = n_curLen
		end
	end
	return n_maxLen

end

--[[
------------------------------------------------
dialog.countLines(string)
Return Type: number
Method Type: internal
-------------------------------------------------
Returns the number of lines in the text.
Example: The text "Hello\nWorld!" would return 2.
]]
function countLines(s_text)
	return string.len(s_text) - string.len(string.gsub(s_text, "\n", "")) + 1
end

--[[
------------------------------------------------
dialog.getButtonMaxLines(table)
Return Type: number
Method Type: internal
-------------------------------------------------
Helper function used to determine the height of the buttons.
Returns the number of lines of the largest (=highest) button.
]]
function getButtonMaxLines(t_buttons)
	local n_maxLines = 0
	for _, s_btn in pairs(t_buttons) do
		if countLines(s_btn) > n_maxLines then
			n_maxLines = countLines(s_btn)
		end
	end
	return n_maxLines
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Backward compatibility functions
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function SetOpen(s_id, bOpen)
	print("dialog.SetOpen is not supported an_ymore. Use dialog.activate() and dialog.deactivate() instead")
end

function SetState(sState)
	print("SetState is not supported an_ymore! If you think you need states, consult Mahric.")
end

function GetState()
	print("GetState is not supported an_ymore. Instead use isActivated()")
	return ""
end
