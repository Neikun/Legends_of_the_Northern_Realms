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
				NPC.requestDialog(hEntity.id);	
				return false
			end
			
		end
		
	end
	
	return true
end



function OnCastSpell(n_championID, s_spell)
	
	-- You can't cast if any dialog is open
	if Dialog.isActivated() then
		return false
	end

	return true
end



function OnDie(nChampionID)
end



function OnDamage(n_championID, n_damage, s_damageType)
	
	-- Not while having a dialog window open
	if Dialog.isActivated() then
		return false
	end

	return true
end



function OnLevelUp(nChampionID)
end



function OnMove(hParty, nDirection)
	
	-- You can't move when a dialog window is open
	if Dialog.isActivated() then
		return false
	end

	return true
end



function OnPickUpItem(h_party, h_item)
	
	-- You can't pick anything up while a dialog window is open
	if Dialog.isActivated() then
		return false
	end

	return true
end



function OnProjectileHit(n_championID, h_projectile, n_damage, s_damageType)
	
	-- You can't get hit by a projectile while a dialog window is open
	if Dialog.isActivated() then
		return false
	end

	return true
end



function OnReceiveCondition(nChampionID, sCondition, nValue)
end



function OnRest(hParty)
end



function OnTurn(h_party, n_direction)
	
	-- You can't turn while a dialog window is open
	if Dialog.isActivated() then
		return false
	end

	return true
end



function OnUseItem(n_championID, h_item, n_slot)
	
	-- You can't use an item while a dialog window is open
	if Dialog.isActivated() then
		return false
	end

	return true
end



function OnWakeUp(hParty)
end

]]);