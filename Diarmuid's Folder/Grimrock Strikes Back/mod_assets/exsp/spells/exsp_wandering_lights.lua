--[[ 
Spell Plugin for EXSP

Spell Name: Wandering Lights
Spell Author: Diarmuid
Script Version: 1.1

Spell Readme:
This spell is intended to be used by spawners as a "trap". It creates balls of lightning which will slowly "wander" around
in the dungeon, avoid walls and obstacles (they will only hit the party or a monster).

The Wandering Lights will fly straight and turn around corners if in a narrow corridor. If they have an opening either left or right, 
they have a 20% chance each of turning in that direction. So in an open space, they have 20% left, 20% right, 60% ahead. If they
arrive in front of a wall, they have a 50% chance of turning left or right, if the way is clear of course. If they arrive in
a dead end, they'll turn back.

To intelligently spawn these, use the provided function:
exsp_wandering_lights.spawnLight(spawner, room, maxLights, [power])

spawner: the id of the spawner object from which to launch
room: a string identifying a unique space for a set of lights (ex: "treasure_room_1" or "mazeOfShadows"...)
maxLights: the maximum number of wandering lights to spawn in that "room". The spells will remember in which "room" they were spawned,
	and when they explode, they will free their spot for another light. So, whether from a pressure plate, timer, or something else, the
	call to spawnLight won't degenerate into endless spells.
power: an optional argument if you wish to override the default power of the lights (40).

Notice that Wandering Lights also deflect from blocker objects like monsters, so you can use these also to restrict them to a section of
your dungeon.

Changelog:
1.1 Updated for exsp 1.4, bugfix
]]

-- ****** Define particle systems and sounds ******
defineParticleSystem{
	name = "wandering_lights",
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
			color0 = {3.0,0.5,2.5},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.125, 1.0},
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
			color0 = {3.0,0.5,2.5},
			opacity = 1,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {0.2, 0.7},
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
			color0 = {0.65,0.32,0.5},
			opacity = 0.3,
			fadeIn = 0.1,
			fadeOut = 0.1,
			size = {1.0, 1.0},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
			objectSpace = true,
		},
		
		-- trail
		{
			--spawnBurst = true,
			emissionRate = 100,
			emissionTime = 0,
			maxParticles = 100,
			sprayAngle = {0,360},
			--velocity = {0.1,0.5},
			velocity = {0,0},
			texture = "assets/textures/particles/glow.tga",
			lifetime = {0.2, 0.3},
			colorAnimation = false,
			color0 = {2.5, 0.5, 1.8},
			opacity = 0.7,
			fadeIn = 0.01,
			fadeOut = 0.3,
			size = {0.15, 0.3},
			gravity = {0,0,0},
			airResistance = 1,
			rotationSpeed = 2,
			blendMode = "Additive",
			objectSpace = true,
		},
	}
}

defineParticleSystem{
	name = "wandering_lights_hit",
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
			color0 = {3.0,0.5,2.5},
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
			color0 = {1.25, 0.5, 1},
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
			color0 = {1, 0.2, 0.8},
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

-- ****** Define Object ******

defineObject{
	name = "wandering_lights",
	class = "ProjectileSpell",
	particleSystem = "wandering_lights",
	hitParticleEffect = "wandering_lights_hit",
	lightColor = vec(1.0, 0.2, 0.8),
	lightBrightness = 15,
	lightRange = 5,
	lightHitBrightness = 20,
	lightHitRange = 8,
	castShadow = true,
	launchSound = "silence",
	projectileSound = "lightning_bolt",
	hitSound = "lightning_bolt_hit_small",
	projectileSpeed = 2.5,
	attackPower = 40,
	damageType = "shock",
	--cameraShake = true,
	tags = { "spell" },
}

-- ****** Define script functions ******

fw_addModule("exsp_wandering_lights",[[
	wanderingLights = {}

	function autoexec()
		exsp:defineSpell("wandering_lights",{
			-- Basic information
			spawnObject = "wandering_lights",
			projectileSpeed = 2.5,
			attackPower = 40,
			damageType = "shock",
			
			-- Particle Systems
			particleSystem = "wandering_lights",
			hitParticleEffect = "wandering_lights_hit",

			-- Light properties
			lightColor = {1.0, 0.2, 0.8},
			lightBrightness = 15,
			lightRange = 5,
			lightHitBrightness = 20,
			lightHitRange = 8,
			castShadow = true,
			
			-- Sounds
			launchSound = "lightning_bolt_launch",
			projectileSound = "lightning_bolt",
			hitSound = "lightning_bolt_hit_small",
			
			-- Hooks
			onPass = function(self)
				local facing = self.facing
				local newDir = facing
		

				changeDir = math.random()
				
				if changeDir < 0.2 and checkCollision(self, (newDir - 1)%4) == false then
					newDir = (newDir - 1)%4
				elseif changeDir < 0.4 and checkCollision(self, (newDir + 1)%4) == false then
					newDir = (newDir + 1)%4
				end
				
				if checkCollision(self, newDir) then
					local turn = (math.random(0,1)*2)+1
					newDir = (newDir+turn)%4
					if checkCollision(self, newDir) then
						newDir = (newDir + 2)%4
					end
					if checkCollision(self, newDir) then
						newDir = (newDir + 1)%4
					end
					if checkCollision(self, newDir) then
						newDir = (newDir + 2)%4
					end			
				end
				
				if newDir ~= facing then
					self:changeDirection(newDir)		
					return false
				end
			end,
			onHit = function(self)
				room = self.room
				wanderingLights[room] = wanderingLights[room] - 1
			end
			}
		)	
	end

	function spawnLight(spawner, room, maxLights, power)
		if wanderingLights[room] == nil then
			wanderingLights[room] = 0
		end
		if wanderingLights[room] < maxLights then
			exsp:spellSpawn("wandering_lights", spawner, nil, {power = power, room = room})
			wanderingLights[room] = wanderingLights[room] + 1
		end
	end

	function checkCollision(spell, facing)
		local hitType = spell:getCollisionAhead(facing)
		if hitType == "door" or hitType == "wall" or hitType == "object" or checkBlocker(spell, facing) == true then
			return true
		else
			return false
		end
	end

	function checkBlocker(spell, facing)
		local level, x, y = spell:getPosition()
		local dx, dy = getForward(facing)
		for i in entitiesAt(level, x+dx, y+dy) do
			if i.class == "Blocker" then
				return true
			end
		end
		return false
	end
]])