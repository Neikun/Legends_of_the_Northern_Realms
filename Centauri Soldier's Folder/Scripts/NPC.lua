tNPC = {
	Classes = {
		"Healer",
		"Kiosk",
		"Shop Keeper",
	},
	NPCs = {},
};

--used for creating new NPCs
tNPCBaseAttributes = {
	Effects = {},
	Classes = {},
	Enemies = {},
	Friends = {},
	IsAlive = true,
	IsRecruitable = false,
	Name = "",
	Origin = "",
	Skills = {},
};


--[[
-----------------------------
NPC.Create(sID, table or nil)
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
If the NPX was created successfully,
its ID is returned otherwise a blank
string is returned.
]]
function Create(sID, tProps)
local sRet = "";

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
	if tProps then
		
		for sIndex, vValue in pairs(tProps) do
		tNPC.NPCs[sID][sIndex] = vValue;
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

	if tNPC.NPCs[sID] then
	return true
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