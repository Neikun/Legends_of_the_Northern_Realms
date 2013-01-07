-- This file was generated by Centauri Soldier

-- TODO: place your custom Party definitions and hooks here

cloneObject{	
	name = "party",
	baseObject = "party",
	onAttack = function(nChampionID, hWeapon)
	return Party.OnAttack(nChampionID, hWeapon);	
	end,		
	onCastSpell = function(nChampionID, sSpell)
	return Party.OnCastSpell(nChampionID, sSpell);		
	end,
	onDamage = function(nChampionID, nDamage, sDamageType)
	return Party.OnDamage(nChampionID, nDamage, sDamageType);		
	end,
	onDie = function(nChampionID)
	return Party.OnDie(nChampionID);
	end,
	onDrawGui = function(hGUI)
	return GUI.OnDraw(hGUI)
	end,
	onDrawInventory = function(hGUI)
	return GUI.OnDrawInventory(hGUI)
	end,
	onDrawStats = function(hGUI)
	return GUI.OnDrawStats(hGUI)
	end,	
	onDrawSkills = function(hGUI)
	return GUI.OnDrawSkills(hGUI)
	end,	
	onLevelUp = function(nChampionID)
	return Party.OnLevelUp(nChampionID);
	end,
	onMove = function(hParty, nDirection)	
	return Party.OnMove(hParty, nDirection);		
	end,
	onPickUpItem = function(hParty, hItem)
	return Party.OnPickUpItem(hParty, hItem);		
	end,	
	onProjectileHit = function(nChampionID, hProjectile, nDamage, sDamageType)
	return Party.OnProjectileHit(nChampionID, hProjectile, nDamage, sDamageType);
	end,
	onRest = function(hParty)
	return Party.OnRest(hParty);
	end,
	onReceiveCondition = function(nChampionID, sCondition, nValue)
	return Party.OnReceiveCondition(nChampionID, sCondition, nValue);
	end,
	onTurn = function(hParty, nDirection)
	return Party.OnTurn(hParty, nDirection);		
	end,
	onUseItem = function(nChampionID, hItem, nSlot)
	return Party.OnUseItem(hParty, nDirection);		
	end,
	onWakeUp = function(hParty)
	return Party.OnWakeUp(hParty);
	end,	
}