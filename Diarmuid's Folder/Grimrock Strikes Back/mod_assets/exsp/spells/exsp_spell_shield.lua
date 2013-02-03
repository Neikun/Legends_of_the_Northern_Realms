--[[ 
Spell Plugin for EXSP

Spell Name: Spell Shield
Spell Author: Diarmuid
Script Version: 1.2

Spell Readme:
This spell creates a shield which protects the party against spells, stopping them one tile away from the party, or on the party tile if
monster is next to the party.

It's duration is 5s + 1s for every 3 points of Staff Defense skill.

Feel free to tweak runes, skill or mana cost.

Changelog
1.2 Updated code for exsp 1.4
1.1 Bugfixes

]]

-- ****** Define particle systems and sounds ******

defineParticleSystem{
	name = "spell_shield",
	emitters = {
		-- stars
		{
			spawnBurst = true,
			maxParticles = 1000,
			sprayAngle = {0,360},
			velocity = {0,0.3},
			boxMin = {-1.1,-0.9,1},
			boxMax = {1.1,0.9,1},
			objectSpace = true,
			texture = "assets/textures/particles/glitter_silver.tga",
			frameRate = 35,
			frameSize = 32,
			frameCount = 50,
			lifetime = {0.3, 0.5},
			color0 = {0.8, 0.8, 1},
			opacity = 1,
			fadeIn = 0.001,
			fadeOut = 0.15,
			size = {0.005, 0.25},
			gravity = {0,0,0},
			airResistance = 0.5,
			rotationSpeed = 2,
			blendMode = "Additive",
		},

		-- glow
		{
			spawnBurst = true,
			emissionRate = 1,
			emissionTime = 0,
			maxParticles = 1,
			boxMin = {0,0,1},
			boxMax = {0,0,1},
			sprayAngle = {0,30},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {0.5, 0.5},
			colorAnimation = false,
			color0 = {0.8, 0.8, 0.8},
			opacity = 0.8,
			fadeIn = 0.001,
			fadeOut = 0.1,
			size = {4.5, 4.1},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
			objectSpace = true,
		}
	}
}

-- ****** Define spell & spell scroll ******

defineSpell{
	name = "spell_shield",
	uiName = "Spell Shield",
	skill = "staves",
	level = 15,
	runes = "BDF",
	manaCost = 30,
	onCast = function(caster,x,y,direction,skill)
		exsp_spell_shield.shieldCast(skill)
	end
}

defineObject{
	name = "scroll_spell_shield",
	class = "Item",
	uiName = "Scroll of Spell Shield",
	model = "assets/models/items/scroll_spell.fbx",
	gfxIndex = 113,
	scroll = true,
	spell = "spell_shield",
	weight = 0.3,
	description = "Creates a shield which surrounds the party, preventing spells to enter its field.",
}
	
-- ****** Define script functions ******

fw_addModule("exsp_spell_shield",[[

	-- Create Shield Timer, which simply decreases shieldDuration by 1 each second, and
	-- deactivates itself with a message to the player when shieldDuration reaches 0.

	shieldDuration = 0

	function initShieldTimer()
		local shieldTimer = timers:create("spell_shield_timer")
		shieldTimer:setTimerInterval(1)
		shieldTimer:setConstant()
		shieldTimer:addCallback(
			function(self)
				exsp_spell_shield.setShieldDuration(exsp_spell_shield.shieldDuration - 1)
				if exsp_spell_shield.shieldDuration == 0 then
					hudPrint("Spell Shield has expired.")
					playSound("goromorg_shield_break")
					self:deactivate()
				end
			end,
			{}
		)
	end

	function setShieldDuration(duration)
		shieldDuration = duration
	end

	-- Define spell function called by party onCast hook

	function shieldCast(skill)
		-- Set shield duration to 5s + 1s for every 3 points of Staff Defense skill.
		shieldDuration = 5 + math.floor(skill/3)
		playSound("generic_spell")
		
		-- Activate shield timer
		local shieldTimer = timers:find("spell_shield_timer")
		if shieldTimer.active == false then
			shieldTimer:activate()	
		end
		hudPrint("Spell Shield active.")
	end

	function autoexec()

		-- Add an onPass hook to all spells to check for the shield

		exsp:addSpellHooks("allSpells",{
			onPass = function(self)
			
				-- Checks if the shield is active
				
				if exsp_spell_shield.shieldDuration > 0 then

					-- Checks if spell is one square before hitting the party, and if yes, explode the
					-- spell (without hitSound) and play shield screen effect.
					
					if self:getCollisionAhead() == "party" then
						self:explode(false)
						party:playScreenEffect("spell_shield")
						playSound("goromorg_shield_hit")
						return false
					end
				end
			end
			}
		)

		-- Add an onPartyHit hook to all spells. This is required because the onPass hook above will stop
		-- spells one tile away from the party. But it the monster is right next to the party, the spell will be 
		-- "in" the shield sphere and not deflected. This hook acts as a failsafe.

		exsp:addSpellHooks("allSpells",{
			onPartyHit = function(self)
			
				-- Checks if the shield is active
				
				if exsp_spell_shield.shieldDuration > 0 then
					party:playScreenEffect("spell_shield")
					playSound("goromorg_shield_hit")
					return false
				end
			end
			}
		)
			
		initShieldTimer()

	end
]])