tParty = {
	[1] = {},
	[2] = {},
	[3] = {},
	[4] = {},
};

--[[============================================================
						#### HOOKS ####
--============================================================]]
--[[
---------------------
Party.OnAttack()
Return Type: boolean
Method Type: internal
---------------------
See Scripting Reference
]]
function OnAttack(nChampionID, hWeapon)
local nXAdjust = 0;
local nYAdjust = 0;
local hParty = findEntity("party");
local tNPCObjects = {"npc_boatman"};
	
	--get the tile in front of the party
	if hParty.facing == 0 then
	nYAdjust = -1;
	
	elseif hParty.facing == 1 then
	nXAdjust = 1;
	
	elseif hParty.facing == 2 then
	nYAdjust = 1;
	
	elseif hParty.facing == 3 then
	nXAdjust = -1;
	
	end
	
	--check for NPCs in front of the party
	for hEntity in entitiesAt(hParty.level, hParty.x + nXAdjust, hParty.y + nYAdjust) do
		
		for nObjectID, sObject in pairs(tNPCObjects) do
			
			--if found, request a dialog
			if hEntity.name == sObject then				
			NPC.RequestDialog(hEntity.id);	
			return false
			end
			
		end
		
	end
	
return true
end


--[[
---------------------
Party.OnCastSpell()
Return Type: boolean
Method Type: internal
---------------------
See Scripting Reference
]]
function OnCastSpell(nChampionID, sSpell)
	
	if NPC.GetDialogOpen().IsOpen then
	return false
	end

return true
end


--[[
---------------------
Party.OnDie()
Return Type: boolean
Method Type: internal
---------------------
See Scripting Reference
]]
function OnDie(nChampionID)
end


--[[
---------------------
Party.OnDamage()
Return Type: boolean
Method Type: internal
---------------------
See Scripting Reference
]]
function OnDamage(nChampionID, nDamage, sDamageType)
	
	if NPC.GetDialogOpen().IsOpen then
	return false
	end

return true
end


--[[
---------------------
Party.OnLevelUp()
Return Type: boolean
Method Type: internal
---------------------
See Scripting Reference
]]
function OnLevelUp(nChampionID)
end


--[[
---------------------
Party.OnMove()
Return Type: boolean
Method Type: internal
---------------------
See Scripting Reference
]]
function OnMove(hParty, nDirection)
	
	if NPC.GetDialogOpen().IsOpen then
	return false
	end

return true
end


--[[
---------------------
Party.OnPickUpItem()
Return Type: boolean
Method Type: internal
---------------------
See Scripting Reference
]]
function OnPickUpItem(hParty, hItem)
	
	if NPC.GetDialogOpen().IsOpen then
	return false
	end

return true
end


--[[
---------------------
Party.OnProjectileHit()
Return Type: boolean
Method Type: internal
---------------------
See Scripting Reference
]]
function OnProjectileHit(nChampionID, hProjectile, nDamage, sDamageType)
	
	if NPC.GetDialogOpen().IsOpen then
	return false
	end

return true
end


--[[
---------------------
Party.OnReceiveCondition()
Return Type: boolean
Method Type: internal
---------------------
See Scripting Reference
]]
function OnReceiveCondition(nChampionID, sCondition, nValue)
end


--[[
---------------------
Party.OnRest()
Return Type: boolean
Method Type: internal
---------------------
See Scripting Reference
]]
function OnRest(hParty)
end


--[[
---------------------
Party.OnTurn()
Return Type: boolean
Method Type: internal
---------------------
See Scripting Reference
]]
function OnTurn(hParty, nDirection)
	
	if NPC.GetDialogOpen().IsOpen then
	return false
	end

return true
end


--[[
---------------------
Party.OnUseItem()
Return Type: boolean
Method Type: internal
---------------------
See Scripting Reference
]]
function OnUseItem(nChampionID, hItem, nSlot)
	
	if NPC.GetDialogOpen().IsOpen then
	return false
	end

return true
end


--[[
---------------------
Party.OnWakeUp()
Return Type: boolean
Method Type: internal
---------------------
See Scripting Reference
]]
function OnWakeUp(hParty)
end