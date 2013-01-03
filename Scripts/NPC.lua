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


function Get.DataTable()
return tNPC
end


--[[
-----------------------------
NPC.Create(sID, table or nil)
Return Type: string
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
--------------------
NPC.Exists(string)
Return Type: boolean
--------------------
Checks to see whether or not
an NPC exists in the tNPC.NPCs
table.
Note: This function does not check
the validity of the entity, in fact,
this function assumes that the
entitity exists.
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
-----------------------
NPC.GetIDByName(string)
Return Type: string
-----------------------
Gets an NPC's ID by its
name. If the NPC does
not exist, a blank string
is returned.
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
-----------------------------------------
NPC.GetIDByName(string, string, variable)
Return Type: nil
-----------------------------------------
Sets an NPC's attribute
value. If the attribute
does not exist then it
will be created.
]]
function SetAttr(sID, sAtt, vValue)
	
	if NPC.Exists(sID) then
	tNPC.NPCs[sID][sAtt] = vValue;	
	end
	
end