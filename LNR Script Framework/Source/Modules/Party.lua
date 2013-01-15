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


--[[
---------------------
Party.OnCastSpell()
Return Type: boolean
Method Type: internal
---------------------
See Scripting Reference
]]
function OnCastSpell(n_championID, s_spell)
	
	-- You can't cast if any dialog is open
	if Dialog.isActivated() then
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
function OnDamage(n_championID, n_damage, s_damageType)
	
	-- Not while having a dialog window open
	if Dialog.isActivated() then
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
	
	-- You can't move when a dialog window is open
	if Dialog.isActivated() then
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
function OnPickUpItem(h_party, h_item)
	
	-- You can't pick anything up while a dialog window is open
	if Dialog.isActivated() then
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
function OnProjectileHit(n_championID, h_projectile, n_damage, s_damageType)
	
	-- You can't get hit by a projectile while a dialog window is open
	if Dialog.isActivated() then
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
function OnTurn(h_party, n_direction)
	
	-- You can't turn while a dialog window is open
	if Dialog.isActivated() then
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
function OnUseItem(n_championID, h_item, n_slot)
	
	-- You can't use an item while a dialog window is open
	if Dialog.isActivated() then
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
