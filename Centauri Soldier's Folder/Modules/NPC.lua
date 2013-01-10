tNPC = {		
	Objects = {
		"",
	},
	Classes = {
		"Healer",
		"Kiosk",
		"Shop Keeper",
	},
	NPCs = {},
};

--used for creating new NPCs
tNPCBaseAttributes = {
	Associations = {},	
	Effects = {},
	Classes = {},
	Enemies = {},	
	Friends = {},
	IsAlive = true,
	IsRecruitable = false,
	Name = "",
	Object = "",
	Origin = "",
	Skills = {},
};


--[[
-----------------------------
NPC.AddObject(string)
Return Type: nil
Method Type: external
-----------------------------
This adds an NPC object to the
framework so it may be accessed
by other methods.
]]
function AddObject(sObject)

	if Util.VarIsValid({"s"}, sObject) then
		
		if string.gsub(sObject, " ", "") ~= "" then
			
			if not tNPC.Objects[sObject] then
			tNPC.Objects[sObject] = sObject;
			end
		
		end
		
	end	

end


--[[
-----------------------------
NPC.DeleteObject(string)
Return Type: nil
Method Type: external
-----------------------------

]]
function DeleteObject(sObject)
	
	if tNPC.Objects[sObject] then
	tNPC.Objects[sObject] = nil;
	end

end


--[[
-----------------------------
NPC.GetObjects()
Return Type: nil
Method Type: external
-----------------------------
This gets a numerically-indexed
table whose values are the NPC
objects recognized by the frame-.
]]
function GetObjects()
return tNPC.Objects
end







--[[
-----------------------------
NPC.Create(string, table or nil)
Return Type: string
Method Type: external
-----------------------------
Creates an NPC using the base
attributes listed above. These
may be altered anytime by using
the NPC.SetAttr() function. The
intialization of an NPC may also
be accompanied by a table of
attributes that will be set upon
its creation but is not required.
If the NPC was created successfully,
its ID is returned otherwise a blank
string is returned.
Note: The ID should <always> be the
entity ID to which the NPC as been
or will be assigned and <not> the
entity name (which is the general
form of the entity from which this
particular one is spawned).
]]
function Create(sID, tProps)
local sRet = "";
	
	if type(sID) == "string" then
	sID = string.lower(sID);
	
		--create the base NPC if it does not exist
		if not tNPC.NPCs[sID] then
		tNPC.NPCs[sID] = {};
		sRet = sID;
		
			--cycle through the Base Attributes
			for sIndex, vValue in pairs(tNPCBaseAttributes) do
			tNPC.NPCs[sID][sIndex] = vValue;
			end
			
		end
		
		--if any properties were included, set them
		if type(tProps) == "table" then
			
			for sIndex, vValue in pairs(tProps) do
			tNPC.NPCs[sID][sIndex] = vValue;
			end
		
		end
		
	end

return sRet
end


--[[
---------------------
NPC.Exists(string)
Return Type: boolean
Method Type: external
---------------------
Checks to see whether or not
an NPC exists in the tNPC.NPCs
table.
Note: This function does not check
the validity of the entity, in fact,
this function assumes that the
entity exists (or will exist).
]]
function Exists(sID)
	
	if type(sID) == "string" then
	sID = string.lower(sID);

		if tNPC.NPCs[sID] then
		return true
		end
	
	end
	
return false
end


--[[
---------------------------
NPC.GetAttr(string, string)
Return Type: string
Method Type: external
---------------------------
Gets an NPC's attribute value
If the NPC or Attribute does
not exist, a blank string is
returned.
]]
function GetAttr(sID, sAtt)
local sRet = "";
		
	if NPC.Exists(sID) then	
	sID = string.lower(sID);
	
		if tNPC.NPCs[sID][sAtt] then
		return tNPC.NPCs[sID][sAtt]
		end
		
	end
	
return sRet
end


--[[
-----------------------------
NPC.GetDataTable()
Return Type: table
Method Type: internal
-----------------------------
Used for getting the information
that will be saved in the data
module.
]]
function GetDataTable()
return tNPC
end


--[[
-----------------------
NPC.GetIDByName(string)
Return Type: string
Method Type: external
-----------------------
Gets an NPC's ID by its
name. If the NPC does
not exist, a blank string
is returned.
Notes:
1. This function is not
reliable if more than one
NPC share the same name.
2. This function is NOT
case-sensitive.
]]
function GetIDByName(sName)
local sRet = "";
sName = string.lower(sName);

	for sID, tNPC in pairs(tNPC.NPCs) do
	local sMyName = string.lower(tNPC.NPCs.Name);
	
		if sMyName == sName then
		return sID
		end
		
	end

return sRet
end


--[[
-----------------------------
NPC.HasDialog()
Return Type: boolean
Method Type: internal
-----------------------------
INCOMPLETE
]]
function HasDialog(sID)

	if type(sID) == "string" then
	sID = string.lower(sID);
	
	return true
	end
	
return false
end


--[[
-----------------------------------------------
NPC.SetAttr(sID)
Return Type: nil
Method Type: external
-----------------------------------------------
Attempts to open a dialog with an NPC. The NPC
ID is the ID (not name) of the entity.
]]
function RequestDialog(sID)
	
	if NPC.Exists(sID) then
	sID = string.lower(sID);
	
		--make sure no other dialog is open
		if not Dialog.GetOpen().IsOpen then
		local hEntity = findEntity(sID);
			
			--find outif the NPC has a dialog option
			if NPC.HasDialog(sID) then
			
				--check to see if the entity is in the dungeon
				if hEntity then			
				--find the party's location
				local hParty = findEntity("party");
												
					if hParty then
					--THIS WILL BE UPDATED TO CALL THE DIALOG THROUGH THE GUI FRAMEWORK					
					local nX, nY, nFacing, nlevel = hEntity.x, hEntity.y, Util.Position_GetOppositeFacing(hParty.facing), hEntity.level
					--facing only cannot be set. There must be other and different variables incuded. So, the moves once to a random location and then back again.
					hEntity:setPosition(math.random(0, 31), math.random(0, 31), math.random(0, 3), nlevel);
					--set the monster's desired postion
					hEntity:setPosition(nX, nY, nFacing, nlevel);
					--tell the NPC and player that they're interacting
					Dialog.SetOpen(sID, true);					
					end
					
				end
				
			end
			
		end
	end
	
end


--[[
-----------------------------------------------
NPC.SetAttr(string, string or number, variable)
Return Type: nil
Method Type: external
-----------------------------------------------
Sets an NPC's attribute value. If the attribute
does not exist then it is created.
]]
function SetAttr(sID, vAtt, vValue)
	
	if NPC.Exists(sID) then
	tNPC.NPCs[sID][vAtt] = vValue;	
	end
	
end


--[[
-----------------------------
NPC.SetDataTable(tables)
Return Type: nil
Method Type: internal
-----------------------------
Used for setting the information
that was loaded from the data
module.
]]
function SetDataTable(tData)
tNPC = tData;
end


--[[============================================================
						#### HOOKS ####
--============================================================]]


--[[
---------------------
NPC.OnAttack()
Return Type: boolean
Method Type: internal
---------------------
See Scripting Reference
]]
function OnAttack(hEntity, sAttack)
return false
end


--[[
---------------------
NPC.OnDamage()
Return Type: boolean
Method Type: internal
---------------------
See Scripting Reference
]]
function OnDamage(hEntity, nDamage, sDamageType)
return false
end


--[[
---------------------
NPC.OnDealDamage()
Return Type: boolean
Method Type: internal
---------------------
See Scripting Reference
]]
function OnDealDamage(hEntity, nChampionID, nDamage)
return false
end


--[[
---------------------
NPC.OnDie()
Return Type: boolean
Method Type: internal
---------------------
See Scripting Reference
]]
function OnDie(hEntity)
return false
end


--[[
---------------------
NPC.OnMove()
Return Type: boolean
Method Type: internal
---------------------
See Scripting Reference
]]
function OnMove(hEntity, nDirection)
local tDialog = Dialog.GetOpen();

	if tDialog.IsOpen then
		
		if tDialog.ID == hEntity.id then
		return false
		end
		
	end

return true
end


--[[
---------------------
NPC.OnProjectileHit()
Return Type: boolean
Method Type: internal
---------------------
See Scripting Reference
]]
function OnProjectileHit(hEntity, hProjectile, nDamage, sDamageType)
return false
end


--[[
---------------------
NPC.OnRangedAttack()
Return Type: boolean
Method Type: internal
---------------------
See Scripting Reference
]]
function OnRangedAttack(hEntity)
return false
end


--[[
---------------------
NPC.OnTurn()
Return Type: boolean
Method Type: internal
---------------------
See Scripting Reference
]]
function OnTurn(hEntity, nDirection)
local tDialog = Dialog.GetOpen();

	if tDialog.IsOpen then
		
		if tDialog.ID == hEntity.id then
		return false
		end
		
	end

return true
end