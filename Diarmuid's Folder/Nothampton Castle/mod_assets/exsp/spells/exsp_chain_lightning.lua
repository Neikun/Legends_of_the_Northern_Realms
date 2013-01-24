--[[ 
Spell Plugin for EXSP

Spell Name: Chain Lightning
Spell Author: Diarmuid
Script Version: 1.1

Spell Readme:
This spell creates a standard Chain Lightning effect. When cast, it will generate a greater
lightning bolt which, upon hitting a monster, will split into normal lightning bolts if there 
is another monster near in a straight line (radius of 3 tiles). The lightning bolts will themselves
continue to jump from monster to monster until there aren't any more monsters. Monster ids are stored
along the way so that each branch of the lightning will only hit each monster once.

For runes, I've taken standard lightning bolt runes and added Balance to make it more powerful.

Feel free to tweak runes or skill/mana requirements.

Changelog:
1.1 Updated code for exsp v1.4

]]

defineSpell{
	name = "chain_lightning",
	uiName = "Chain Lightning",
	skill = "air_magic",
	level = 25,
	runes = "CDE",
	manaCost = 60,
	description = "A powerful lightning bolt which jumps from monster to monster.",
	onCast = function(caster,x,y,direction,skill)
		exsp:spellCast("chain_lightning", caster)
	end
}

defineObject{
		name = "scroll_chain_lightning",
		class = "Item",
		uiName = "Scroll of Chain Lightning",
		model = "assets/models/items/scroll_spell.fbx",
		gfxIndex = 113,
		scroll = true,
		spell = "chain_lightning",
		weight = 0.3,
		description = [[
			A greater lightning bolt which when hits a monster, will
			branch out in smaller lightning bolts that will strike nearby monsters.]]
	}
	
-- ****** Define script functions ******

fw_addModule("exsp_chain_lightning",[[
		function autoexec()

		-- Define the main Chain Lightning spell, a clone of Greater Lightning Bolt.

		exsp:cloneSpell('chain_lightning',{
			baseSpell = 'lightning_bolt_greater',
			onMonsterHit = function(self, monster)
			
				-- Get position and ordinal data in shorter variables to make script cleaner.
				local level, x, y = monster.level, monster.x, monster.y
				local facing = self.facing
				
				-- Setup a custom property table to store hit monster ids, to avoid lightning bolt loops.
				-- Bolts will "remember" which monsters they hit and not hit them again.
				self.clMonsters = {}
				table.insert(self.clMonsters, monster.id)
				
				-- Look for next monster in each direction, up to 3 tiles ahead (for help.nextEntityAheadOf syntax see JKos's framework site).
				-- If monster is found, spawn a new (smaller) bolt, passing him the monsters table and ordinal.
				for i = 1,4 do
					local seekTable = {x = x, y = y, level = level, facing = (facing+i)%4}
					local nextMonster = help.nextEntityAheadOf(seekTable,3,'monster', true)
					if nextMonster then
						exsp:spellSpawn("chain_lightning_small", monster.id, (facing+i)%4, {ordinal = ordinal, clMonsters = self.clMonsters})
					end
				end
			end
			}
		)

		-- Define the small Chain Lightnings, clones of Lightning Bolt.

		exsp:cloneSpell('chain_lightning_small',{
			baseSpell = 'lightning_bolt',
			onMonsterHit = function(self, monster)
				
				-- Get position and ordinal data in shorter variables to make script cleaner
				local level, x, y = monster.level, monster.x, monster.y
				local facing = self.facing
								
				-- Add this monster to the list
				table.insert(self.clMonsters, monster.id)

				-- Look for next monster in each direction, up to 3 tiles ahead (for help.nextEntityAheadOf syntax see JKos's framework site).
				-- If monster is found, and is not in table, spawn another bolt, passing him again the monsters table
				for i = 1,4 do
					local seekTable = {x = x, y = y, level = level, facing = (facing+i)%4}
					local nextMonster = help.nextEntityAheadOf(seekTable,3,'monster')
					if nextMonster ~= false and help.tableHasValue(self.clMonsters, nextMonster.id) == false then
						exsp:spellSpawn('chain_lightning_small', monster.id, (facing+i)%4, {ordinal = ordinal, clMonsters = self.clMonsters})
					end	
				end
			end
			}
		)

	end
]])