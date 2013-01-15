LoadModule("NPC",[[
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
	Portrait = "",   -- Picture of the npc to use in dialogs. Please use a 128x128 image
};



function AddObject(sObject)

	if Util.VarIsValid({"s"}, sObject) then
		
		if string.gsub(sObject, " ", "") ~= "" then
			
			if not tNPC.Objects[sObject] then
			tNPC.Objects[sObject] = sObject;
			end
		
		end
		
	end	

end



function DeleteObject(sObject)
	
	if tNPC.Objects[sObject] then
	tNPC.Objects[sObject] = nil;
	end

end



function GetObjects()
	return tNPC.Objects
end








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



function Exists(sID)
	
	if type(sID) == "string" then
		sID = string.lower(sID);

		if tNPC.NPCs[sID] then
			return true
		end
	
	end
	
	return false
end



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



function GetDataTable()
	return tNPC
end



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



function HasDialog(sID)

	if type(sID) == "string" then
	sID = string.lower(sID);
	
	return true
	end
	
return false
end



function requestDialog(s_id)
	
	if NPC.Exists(s_id) then
	s_id = string.lower(s_id);
	
		--make sure no other dialog is open
		if not Dialog.GetOpen().IsOpen then
			local hEntity = findEntity(s_id);
			
			--find outif the NPC has a dialog option
			if NPC.HasDialog(s_id) then
			
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
						--Dialog.SetOpen(s_id, true);					
					end
					
				end
				
			end
			
		end
	end
	
end



function SetAttr(sID, vAtt, vValue)
	
	if NPC.Exists(sID) then
	tNPC.NPCs[sID][vAtt] = vValue;	
	end
	
end



function SetDataTable(tData)
	tNPC = tData;
end






function OnAttack(hEntity, sAttack)
	return false
end



function OnDamage(hEntity, nDamage, sDamageType)
	return false
end



function OnDealDamage(hEntity, nChampionID, nDamage)
	return false
end



function OnDie(hEntity)
	return false
end



function OnMove(h_entity, nDirection)

	-- NPC can't move if the player is talking with him
	if Dialog.getActiveDialogNpc() == h_entity.id then
		return false
	end

	return true
end



function OnProjectileHit(hEntity, hProjectile, nDamage, sDamageType)
	return false
end



function OnRangedAttack(hEntity)
	return false
end



function OnTurn(h_entity, n_direction)

	-- NPC can't turn if the player is talking with him
	if Dialog.getActiveDialogNpc() == h_entity.id then
		return false
	end

	return true
end

]]);