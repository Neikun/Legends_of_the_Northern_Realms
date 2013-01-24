--[[ 
Spell Plugin for EXSP

Spell Name: EXSP Presents: Portal for Grimrock
Spell Author: Diarmuid
Script Version: 1.0

Spell Readme:
This spell activates buttons and levers from a distance.

]]

-- ===========================================================================================
--                               DEFINE PARTICLE SYSTEMS
-- ===========================================================================================

defineParticleSystem{
	name = "portal_bolt_orange",
	emitters = {
		{
			emissionRate = 15,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = { 0,0,0 },
			boxMax = { 0,0,0 },
			sprayAngle = {0,360},
			velocity = {0,0},
			objectSpace = true,
			texture = "assets/textures/particles/lightning01.tga",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {0.1,0.3},
			color0 = {4.0,1.0,0},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.05, .6},
			gravity = {0,0,0},
			airResistance = 5,
			rotationSpeed = 1,
			blendMode = "Additive",
		},

		-- core
		{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = { 0,0,0 },
			boxMax = { 0,0,0 },
			sprayAngle = {0,360},
			velocity = {0,0},
			objectSpace = true,
			texture = "assets/textures/particles/lightning01.tga",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {0.1,0.3},
			color0 = {4.0,2.0,0},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.1, 0.4},
			gravity = {0,0,0},
			airResistance = 5,
			rotationSpeed = 1,
			blendMode = "Additive",
		},

		-- glow
		{
			spawnBurst = true,
			emissionRate = 1,
			emissionTime = 0,
			maxParticles = 1,
			boxMin = {0,0,0.0},
			boxMax = {0,0,0.0},
			sprayAngle = {0,30},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {1000000, 1000000},
			colorAnimation = false,
			color0 = {1.0,0.4,0.0},
			opacity = 0.1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.6, 0.6},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
			objectSpace = true,
		}
	}
}

defineParticleSystem{
	name = "portal_bolt_orange_hit",
	emitters = {
		-- sparks
		{
			emissionRate = 80,
			emissionTime = 0.3,
			maxParticles = 50,
			boxMin = {-0.5, -0.5, -0.5},
			boxMax = { 0.5,  0.5,  0.5},
			sprayAngle = {0,360},
			velocity = {0,0},
			objectSpace = false,
			texture = "assets/textures/particles/lightning01.tga",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {0.2,0.4},
			color0 = {6.0,3.0,0},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.3,
			size = {0.1, 1.5},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 0,
			blendMode = "Additive",
		},

		-- fog
		{
			spawnBurst = true,
			maxParticles = 30,
			sprayAngle = {0,360},
			velocity = {0,3},
			objectSpace = true,
			texture = "assets/textures/particles/fog.tga",
			lifetime = {0.4,0.6},
			color0 = {4.0,2.0,0},
			opacity = 0.7,
			fadeIn = 0.1,
			fadeOut = 0.3,
			size = {1, 2},
			gravity = {0,0,0},
			airResistance = 0.5,
			rotationSpeed = 1,
			blendMode = "Additive",
		},

		-- glow
		{
			spawnBurst = true,
			emissionRate = 1,
			emissionTime = 0,
			maxParticles = 1,
			boxMin = {0,0,-0.1},
			boxMax = {0,0,-0.1},
			sprayAngle = {0,30},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {0.5, 0.5},
			colorAnimation = false,
			color0 = {1, 0.4, 0},
			opacity = 1,
			fadeIn = 0.01,
			fadeOut = 0.5,
			size = {1, 1},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
		}
	}
}

defineParticleSystem{
	name = "portal_bolt_blue",
	emitters = {
		{
			emissionRate = 15,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = { 0,0,0 },
			boxMax = { 0,0,0 },
			sprayAngle = {0,360},
			velocity = {0,0},
			objectSpace = true,
			texture = "assets/textures/particles/lightning01.tga",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {0.1,0.3},
			color0 = {1.0,1.0,4.0},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.05, .6},
			gravity = {0,0,0},
			airResistance = 5,
			rotationSpeed = 1,
			blendMode = "Additive",
		},

		-- core
		{
			emissionRate = 10,
			emissionTime = 0,
			maxParticles = 1000,
			boxMin = { 0,0,0 },
			boxMax = { 0,0,0 },
			sprayAngle = {0,360},
			velocity = {0,0},
			objectSpace = true,
			texture = "assets/textures/particles/lightning01.tga",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {0.1,0.3},
			color0 = {1.0,1.0,4.0},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.1, 0.4},
			gravity = {0,0,0},
			airResistance = 5,
			rotationSpeed = 1,
			blendMode = "Additive",
		},

		-- glow
		{
			spawnBurst = true,
			emissionRate = 1,
			emissionTime = 0,
			maxParticles = 1,
			boxMin = {0,0,0.0},
			boxMax = {0,0,0.0},
			sprayAngle = {0,30},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {1000000, 1000000},
			colorAnimation = false,
			color0 = {0.2,0.2,1.0},
			opacity = 0.1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.6, 0.6},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
			objectSpace = true,
		}
	}
}

defineParticleSystem{
	name = "portal_bolt_blue_hit",
	emitters = {
		-- sparks
		{
			emissionRate = 80,
			emissionTime = 0.3,
			maxParticles = 50,
			boxMin = {-0.5, -0.5, -0.5},
			boxMax = { 0.5,  0.5,  0.5},
			sprayAngle = {0,360},
			velocity = {0,0},
			objectSpace = false,
			texture = "assets/textures/particles/lightning01.tga",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {0.2,0.4},
			color0 = {2.0,2.0,6.0},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.3,
			size = {0.1, 1.5},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 0,
			blendMode = "Additive",
		},

		-- fog
		{
			spawnBurst = true,
			maxParticles = 30,
			sprayAngle = {0,360},
			velocity = {0,3},
			objectSpace = true,
			texture = "assets/textures/particles/fog.tga",
			lifetime = {0.4,0.6},
			color0 = {1.0,1.0,4.0},
			opacity = 0.7,
			fadeIn = 0.1,
			fadeOut = 0.3,
			size = {1, 2},
			gravity = {0,0,0},
			airResistance = 0.5,
			rotationSpeed = 1,
			blendMode = "Additive",
		},

		-- glow
		{
			spawnBurst = true,
			emissionRate = 1,
			emissionTime = 0,
			maxParticles = 1,
			boxMin = {0,0,-0.1},
			boxMax = {0,0,-0.1},
			sprayAngle = {0,30},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {0.5, 0.5},
			colorAnimation = false,
			color0 = {0.2, 0.3, 1},
			opacity = 1,
			fadeIn = 0.01,
			fadeOut = 0.5,
			size = {1, 1},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
		}
	}
}

defineParticleSystem{
	name = "portal_orange",
	emitters = {
		-- sparks
		{
			emissionRate = 30,
			emissionTime = 0.3,
			maxParticles = 60,
			boxMin = {-0.5,0.9,-0.1},
			boxMax = {0.5,-0.8,0.1},
			sprayAngle = {0,360},
			velocity = {0.1,0.1},
			objectSpace = false,
			texture = "mod_assets/exsp/spells/portal/lightning_blur.tga",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {1000000,1000000},
			color0 = {6.0,1.0,0},
			opacity = 0.1,
			fadeIn = 0.1,
			fadeOut = 4,
			size = {0.1, 0.8},
			gravity = {0,0,0},
			airResistance = 10,
			rotationSpeed = 1,
			blendMode = "Additive",
		},
	}
}

defineParticleSystem{
	name = "portal_blue",
	emitters = {
		-- sparks
		{
			emissionRate = 30,
			emissionTime = 0.3,
			maxParticles = 60,
			boxMin = {-0.5,0.9,-0.1},
			boxMax = {0.5,-0.8,0.1},
			sprayAngle = {0,360},
			velocity = {0.1,0.1},
			objectSpace = false,
			texture = "mod_assets/exsp/spells/portal/lightning_blur.tga",
			frameRate = 4,
			frameSize = 256,
			frameCount = 4,
			lifetime = {1000000,1000000},
			color0 = {1.0,1.0,4.0},
			opacity = 0.1,
			fadeIn = 0.1,
			fadeOut = 4,
			size = {0.1, 0.8},
			gravity = {0,0,0},
			airResistance = 10,
			rotationSpeed = 1,
			blendMode = "Additive",
		},
	}
}
	
-- ===========================================================================================
--                                DEFINE PORTAL OBJECTS
-- ===========================================================================================

-- ********************************* Temple Wallset ******************************************

defineMaterial{
	name = "portal_orange_temple",
	diffuseMap = "mod_assets/exsp/spells/portal/portal_orange_temple.tga",
	specularMap = "mod_assets/exsp/spells/portal/portal_temple_spec.tga",
	normalMap = "mod_assets/exsp/spells/portal/portal_temple_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 30,
	depthBias = 0,
}

cloneObject {
    name = "portal_orange_temple",
    baseObject = "temple_mosaic_wall_1",
    model = "mod_assets/exsp/spells/portal/portal_orange_temple.fbx",
}

defineMaterial{
	name = "portal_orange_temple_closed",
	diffuseMap = "mod_assets/exsp/spells/portal/portal_orange_temple_closed.tga",
	specularMap = "mod_assets/exsp/spells/portal/portal_temple_spec.tga",
	normalMap = "mod_assets/exsp/spells/portal/portal_temple_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 30,
	depthBias = 0,
}

cloneObject {
    name = "portal_orange_temple_closed",
    baseObject = "temple_mosaic_wall_1",
    model = "mod_assets/exsp/spells/portal/portal_orange_temple_closed.fbx",
}

defineMaterial{
	name = "portal_blue_temple",
	diffuseMap = "mod_assets/exsp/spells/portal/portal_blue_temple.tga",
	specularMap = "mod_assets/exsp/spells/portal/portal_temple_spec.tga",
	normalMap = "mod_assets/exsp/spells/portal/portal_temple_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 30,
	depthBias = 0,
}

cloneObject {
    name = "portal_blue_temple",
    baseObject = "temple_mosaic_wall_1",
    model = "mod_assets/exsp/spells/portal/portal_blue_temple.fbx",
}

defineMaterial{
	name = "portal_blue_temple_closed",
	diffuseMap = "mod_assets/exsp/spells/portal/portal_blue_temple_closed.tga",
	specularMap = "mod_assets/exsp/spells/portal/portal_temple_spec.tga",
	normalMap = "mod_assets/exsp/spells/portal/portal_temple_normal.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 30,
	depthBias = 0,
}

cloneObject {
    name = "portal_blue_temple_closed",
    baseObject = "temple_mosaic_wall_1",
    model = "mod_assets/exsp/spells/portal/portal_blue_temple_closed.fbx",
}

-- ===========================================================================================
--                                DEFINE PORTAL RODS
-- ===========================================================================================

defineMaterial{
	name = "portal_rod_orange",
	diffuseMap = "mod_assets/exsp/spells/portal/portal_rod_orange.tga",
	specularMap = "assets/textures/items/shaman_staff_spec.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,
}

defineMaterial{
	name = "portal_rod_blue",
	diffuseMap = "mod_assets/exsp/spells/portal/portal_rod_blue.tga",
	specularMap = "assets/textures/items/shaman_staff_spec.tga",
	doubleSided = false,
	lighting = true,
	alphaTest = false,
	blendMode = "Opaque",
	textureAddressMode = "Wrap",
	glossiness = 20,
	depthBias = 0,
}

cloneObject{
	name = "portal_rod_orange",
	baseObject = "power_weapon",
	uiName = "Portal Rod (Orange)",
	model = "mod_assets/exsp/spells/portal/portal_rod_orange.fbx",
	description = "This enchanted rod fires a bolt of magical energy that opens an orange portal on a wall.",
	gfxAtlas = "mod_assets/exsp/spells/portal/items.tga",
	gfxIndex = 0,
	spell = "portal_bolt_orange",
}

cloneObject{
	name = "portal_rod_blue",
	baseObject = "power_weapon",
	uiName = "Portal Rod (Blue)",
	model = "mod_assets/exsp/spells/portal/portal_rod_blue.fbx",
	description = "This enchanted rod fires a bolt of magical energy that opens a blue portal on a wall.",
	gfxAtlas = "mod_assets/exsp/spells/portal/items.tga",
	gfxIndex = 1,
	spell = "portal_bolt_blue",
}

-- ===========================================================================================
--                                DEFINE PORTAL SPELLS
-- ===========================================================================================

cloneObject{
	name = "portal_bolt_orange",
	baseObject = "lightning_bolt",
	particleSystem = "portal_bolt_orange",
	hitParticleEffect = "portal_bolt_orange_hit",
	lightColor = vec(4.0, 2.0, 0.0),
}

cloneObject{
	name = "portal_bolt_blue",
	baseObject = "lightning_bolt",
	particleSystem = "portal_bolt_blue",
	hitParticleEffect = "portal_bolt_blue_hit",
	lightColor = vec(1.0, 1.0, 4.0),
}

defineSpell{
	name = "portal_bolt_orange",
	uiName = "Portal Bolt (Orange)",
	skill = "air_magic",
	level = 0,
	runes = nil,
	manaCost = 0,
	onCast = function(caster,x,y,direction,skill)
		exsp:spellCast("portal_bolt_orange", caster)
	end
}

defineSpell{
	name = "portal_bolt_blue",
	uiName = "Portal Bolt (Blue)",
	skill = "air_magic",
	level = 0,
	runes = nil,
	manaCost = 0,
	onCast = function(caster,x,y,direction,skill)
		exsp:spellCast("portal_bolt_blue", caster)
	end
}
	
-- ===========================================================================================
--                               LOAD EXSP SCRIPT MODULE
-- ===========================================================================================

fw_addModule("exsp_portal",[[
	function autoexec()
		exsp:defineSpell("portal_bolt_orange",{
			-- Basic properties
			spawnObject = "portal_bolt_orange",
			projectileSpeed = 10,
			damageType = "none",
			
			-- Particle Systems
			particleSystem = "portal_bolt_orange",
			hitParticleEffect = "portal_bolt_orange_hit",
					
			-- Light properties
			lightColor = {4.0, 3.0, 0},
			lightBrightness = 15,
			lightRange = 7,
			lightHitBrightness = 40,
			lightHitRange = 10,
			castShadow = true,
			
			-- Sounds
			launchSound = "lightning_bolt_launch",
			projectileSound = "lightning_bolt",
			hitSound = "lightning_bolt_hit_small",
			
			-- Hooks
			onHit = function(self, level, x, y, hitType, subType)
				if hitType == "wall" then
					print(subType)
					if not(subType) or subType == "Decoration" or subType == "WallText" then
						exsp_portal.createPortal("orange", level, x, y, self.facing)
					end
				end
			end
			}
		)
		
		exsp:defineSpell("portal_bolt_blue",{
			-- Basic properties
			spawnObject = "portal_bolt_blue",
			projectileSpeed = 10,
			damageType = "none",
			
			-- Particle Systems
			particleSystem = "portal_bolt_blue",
			hitParticleEffect = "portal_bolt_blue_hit",
					
			-- Light properties
			lightColor = {1.0, 1.0, 4.0},
			lightBrightness = 15,
			lightRange = 7,
			lightHitBrightness = 40,
			lightHitRange = 10,
			castShadow = true,
			
			-- Sounds
			launchSound = "lightning_bolt_launch",
			projectileSound = "lightning_bolt",
			hitSound = "lightning_bolt_hit_small",
			
			-- Hooks
			onHit = function(self, level, x, y, hitType, subType)
				if hitType == "wall" then
					if not(subType) or subType == "Decoration" or subType == "WallText" then
						exsp_portal.createPortal("blue", level, x, y, self.facing)
					end
				end
			end
			}
		)
		
		-- Define portal Fx, with 4 different translations, one for each direction, to make sure effect is on wall
		exsp:defineFx("portal_orange", {
			particleSystem = "portal_orange",
			color = {4.0, 2.0, 0.5},
			brightness = 30,
			range = 4,
			castShadow = true,
			time = 10000,
			translation = {{0,1.3,1.2},{1,1.3,0},{0,1.3,-1},{-1,1.3,0}}
			}
		)
		
		exsp:defineFx("portal_blue", {
			particleSystem = "portal_blue",
			color = {1.0, 1.0, 4.0},
			brightness = 30,
			range = 4,
			castShadow = true,
			time = 10000,
			translation = {{0,1.3,1.2},{1,1.3,0},{0,1.3,-1},{-1,1.3,0}}
			}
		)
		
		exsp:addSpellHooks("allSpells", {
			onPass = function(self)
				local level, x, y = self:getPosition()
				for i in entitiesAt(level, x, y) do
					if i.facing == self.facing and grimq.strstarts(i.id, "exsp_portal") then
						local otherPortal
						if grimq.strstarts(i.id, "exsp_portal_orange") then
							otherPortal = exsp_portal.portals.blue
						else
							otherPortal = exsp_portal.portals.orange						
						end
						if otherPortal.active then
							local newFacing = (otherPortal.facing+2)%4
							local dx, dy = getForward(newFacing)
							exsp:spellSpawn(self.name, otherPortal.level, otherPortal.x-dx, otherPortal.y-dy, newFacing, {spawnAhead = true})
							self:playSpellProjectileFx(self.level, self.x, self.y, self.facing, 1, true)
							self:destroy()
							return false
						end
					end
				end
			end,
			}
		)
		
		fw.addHooks("party","portal",{
			onMove = function(self, dir)
				for i in entitiesAt(self.level, self.x, self.y) do
					if i.facing == dir and grimq.strstarts(i.id, "exsp_portal") then
						local otherPortal
						if grimq.strstarts(i.id, "exsp_portal_orange") then
							otherPortal = exsp_portal.portals.blue
						else
							otherPortal = exsp_portal.portals.orange						
						end
						if otherPortal.active then
							local newFacing = ((otherPortal.facing+2)%4 - dir + party.facing)%4
							local teleporterId = exsp.randomId("portal")
							spawn("teleporter", self.level, self.x, self.y, newFacing, teleporterId)
								:setTeleportTarget(otherPortal.x, otherPortal.y, newFacing, otherPortal.level)
								:setTriggeredByParty(true)
								:setTriggeredByMonster(false)
								:setTriggeredByItem(false)
								:setChangeFacing(true)
								:setInvisible(true)
								:setSilent(true)
								:setHideLight(true)
								:setScreenFlash(false)
							exsp.delay(0.1,
								function(self, teleporterId)
									if findEntity(teleporterId) ~= nil then
										findEntity(teleporterId):destroy()
									end
								end,
								{teleporterId}
							)
							return false
						end
					end
				end
			end,
			}
		)
	end
	
	wallsets = {}
	portals = {}
	portals.orange = {}
	portals.blue = {}
	
	function defineWallsets(setDefs)
		for i, v in ipairs(setDefs) do
			exsp_portal.wallsets[i] = v
		end
	end
	
	function getOther(color)
		if color == "orange" then
			return "blue" 
		else
			return "orange"
		end
	end
	
	function createPortal(color, level, x, y, facing)
		local otherColor = exsp_portal.getOther(color)
		local portal = exsp_portal.portals[color]
		local otherPortal = exsp_portal.portals[otherColor]

		if not(otherPortal.active) then
			portal.spawnObject = "portal_"..color.."_"..exsp_portal.wallsets[level].."_closed"
			portal.id = "exsp_portal_"..color.."_closed"
			portal.open = false
		else
			portal.spawnObject = "portal_"..color.."_"..exsp_portal.wallsets[level]
			portal.id = "exsp_portal_"..color
			portal.open = true
			if not(otherPortal.open) then
				if findEntity(otherPortal.id) then
					findEntity(otherPortal.id):destroy()
					findEntity(otherPortal.fx):destroy()
				end
				otherPortal.spawnObject = "portal_"..otherColor.."_"..exsp_portal.wallsets[level]
				otherPortal.id = "exsp_portal_"..otherColor
				spawn(otherPortal.spawnObject, otherPortal.level, otherPortal.x, otherPortal.y, otherPortal.facing, otherPortal.id)
				otherPortal.fx = exsp:playFx("portal_"..otherColor, otherPortal.level, otherPortal.x, otherPortal.y, otherPortal.facing)
				otherPortal.open = true
			end
		end
		
		portal.active = true
		portal.level = level
		portal.x = x
		portal.y = y
		portal.facing = facing

		if findEntity(portal.id) then
			findEntity(portal.id):destroy()
			if findEntity(portal.fx) then
				findEntity(portal.fx):destroy()
			end
		end
		spawn(portal.spawnObject, level, x, y, facing, portal.id)
		portal.fx = exsp:playFx("portal_"..color, level, x, y, facing)
	end
]])


