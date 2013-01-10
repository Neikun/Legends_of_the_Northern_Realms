LoadModule("Party",[[
tParty = {
	[1] = {},
	[2] = {},
	[3] = {},
	[4] = {},
};



function OnAttack(nChampionID, hWeapon)
local nXAdjust = 0;
local nYAdjust = 0;
local hParty = findEntity("party");
local tNPCObjects = NPC.GetObjects();
	
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



function OnCastSpell(nChampionID, sSpell)
	
	if NPC.GetDialogOpen().IsOpen then
	return false
	end

return true
end



function OnDie(nChampionID)
end



function OnDamage(nChampionID, nDamage, sDamageType)
	
	if Dialog.GetOpen().IsOpen then
	return false
	end

return true
end



function OnLevelUp(nChampionID)
end



function OnMove(hParty, nDirection)
	
	if Dialog.GetOpen().IsOpen then
	return false
	end

return true
end



function OnPickUpItem(hParty, hItem)
	
	if Dialog.GetOpen().IsOpen then
	return false
	end

return true
end



function OnProjectileHit(nChampionID, hProjectile, nDamage, sDamageType)
	
	if Dialog.GetOpen().IsOpen then
	return false
	end

return true
end



function OnReceiveCondition(nChampionID, sCondition, nValue)
end



function OnRest(hParty)
end



function OnTurn(hParty, nDirection)
	
	if Dialog.GetOpen().IsOpen then
	return false
	end

return true
end



function OnUseItem(nChampionID, hItem, nSlot)
	
	if Dialog.GetOpen().IsOpen then
	return false
	end

return true
end



function OnWakeUp(hParty)
end
]]);