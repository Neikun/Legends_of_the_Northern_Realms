LoadModule("Dialog",[[
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




function DrawAll()




	

end




function GetOpen()
return tDialog.Dialog
end




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
]]);