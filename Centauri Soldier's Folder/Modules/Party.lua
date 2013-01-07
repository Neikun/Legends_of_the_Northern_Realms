tParty = {
	[1] = {},
	[2] = {},
	[3] = {},
	[4] = {},
};







--=============================================================
--=============================================================
-- <<<						HOOKS					  	 >>> --
--=============================================================
--=============================================================
--[[
---------------------
Party.()
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
Party.()
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


function OnDie(nChampionID)
end


function OnDamage(nChampionID, nDamage, sDamageType)
	
	if NPC.GetDialogOpen().IsOpen then
	return false
	end

return true
end


function OnLevelUp(nChampionID)
end


function OnMove(hParty, nDirection)
	
	if NPC.GetDialogOpen().IsOpen then
	return false
	end

return true
end

function OnPickUpItem(hParty, hItem)
	
	if NPC.GetDialogOpen().IsOpen then
	return false
	end

return true
end
function OnProjectileHit(nChampionID, hProjectile, nDamage, sDamageType)
	
	if NPC.GetDialogOpen().IsOpen then
	return false
	end

return true
end


function OnReceiveCondition(nChampionID, sCondition, nValue)
end


function OnRest(hParty)
end


function OnTurn(hParty, nDirection)
	
	if NPC.GetDialogOpen().IsOpen then
	return false
	end

return true
end


function OnUseItem(nChampionID, hItem, nSlot)
	
	if NPC.GetDialogOpen().IsOpen then
	return false
	end

return true
end


function OnWakeUp(hParty)
end