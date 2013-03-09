	skySphereId = nil
	currentAmbiance = nil
	skyLightId = nil
	skyAmbiances = {}
	skyClouds = {}
	starsObjects = {}
	weatherObjects = {}

	-- ***************************************************************************************
	--                                       Party onMove hook
	-- ***************************************************************************************


	autohook =
	{
		party =
		{
			onMove = function(self, dir)
				skyScript.onMove(dir)
			end,
		}
	}

	function onMove(dir)

		local ambianceDefs = skyAmbiances[currentAmbiance]

		if getCollisionAhead(party.level, party.x, party.y, dir) then
			return false
		end

		if ambianceDefs.skySphere then
			moveSkySphere(dir)
		end

		moveSkyLight(dir)

		if getAmbiance().weather then
			moveWeather(dir)
		end
	end



	-- ***************************************************************************************
	--                                       SkySphere functions
	-- ***************************************************************************************


	function createSkySphere(level, x, y)

		if getAmbiance().skySphere then

			skySphereId = shootProjectileWithId(getAmbiance().skySphere, level, x, y, 0, 0, 0, 0, 0, 3, 0, 1, party, true)

		end

	end


	function destroySkySphere()

		if skySphereId and findEntity(skySphereId) then

			findEntity(skySphereId):destroy()

		end

	end


	function moveSkySphere(dir)

		local dx, dy = getForward(dir)
		local newX = party.x+dx
		local newY = party.y+dy

		destroySkySphere()

		skySphereId = shootProjectileWithId(getAmbiance().skySphere, party.level, party.x, party.y, dir, 6.7, 0, 0, -dx*0.6, 3, dy*0.6, 1, party, true)

		delay(0.5,
			function(self, newX, newY)

				if skySphereId then
					findEntity(skySphereId):destroy()
					skyScript.setSkySphereId(nil)
				end

				createSkySphere(party.level, newX, newY)

			end,
			{newX, newY}
		)

	end


	function setSkySphereId(id)
		skySphereId = id
	end




	-- ***************************************************************************************
	--                                       SkyLight functions
	-- ***************************************************************************************


	function createSkyLight(level, x, y)

		spawn("fx", level, x, y, 0, "skyLight")

		local skyLight = findEntity("skyLight")

		if getAmbiance().skyLightParticleSystem then
			skyLight:setParticleSystem(getAmbiance().skyLightParticleSystem)
		else
			skyLight:setParticleSystem("dx_none")
		end

		local rColor, gColor, bColor = unpack(getAmbiance().skyLightColor)
		local brightness = getAmbiance().skyLightBrightness
		skyLight:setLight(rColor, gColor, bColor, brightness, 80, 1000000, false)
		skyLight:translate(3,20,-3)

	end


	function moveSkyLight(dir)

		local dx, dy = getForward(dir)
		local interval = 0.3

		dx = dx * interval
		dy = dy * interval

		local fxTimer = timers:create(randomTimerId("lightTimer"))
		fxTimer:setTimerInterval(0.05)
		fxTimer:setTickLimit(10, true)
		fxTimer:addCallback(
			function(self, dx, dy)
				local skyLight = findEntity("skyLight")
				if skyLight then
					skyLight:translate(dx,0,-dy)
				end
			end,
			{dx, dy}
		)
		fxTimer:activate()

	end


	function destroySkyLight()

		local skyLight = findEntity("skyLight")
		if skyLight then
			skyLight:destroy()
		end

	end


	-- ***************************************************************************************
	--                                       Clouds functions
	-- ***************************************************************************************


	function createClouds()

		local cloudsGrid = math.ceil(getAmbiance().cloudsFrequence)

		for x = 0, cloudsGrid do

			for y = 0, cloudsGrid do

				local cloudsInterval = math.ceil(32/cloudsGrid)
				local cloudsX = clampCoord(x * cloudsInterval + math.random(5) - 3)
				local cloudsY = clampCoord(y * cloudsInterval + math.random(5) - 3)
				local clouds = shootProjectileWithId(getAmbiance().clouds, party.level, cloudsX, cloudsY, 2, 0, 0, 0, 0, 9 + math.random() * 2, 0, 1, party, true)

				table.insert(skyClouds,clouds)

			end

		end

	end


	function destroyClouds()

		for _, cloudsId in ipairs(skyClouds) do

			local clouds = findEntity(cloudsId)
			if clouds then
				clouds:destroy()
			end

		end

		skyClouds = {}

	end

	-- ***************************************************************************************
	--                                       Stars functions
	-- ***************************************************************************************


	function createStars()

		for x = 0, 6 do

			for y = 0,6 do

				local starsX = x * 5 + 1
				local starsY = y * 5 + 1
				local starsId = "stars."..starsX.."."..starsY

				spawn("fx", party.level, starsX, starsY, 0, starsId)

				local stars = findEntity(starsId)
				stars:setParticleSystem(getAmbiance().stars)
				stars:setLight(0, 0, 0, 1, 0, 1000000, false)
				stars:translate(0,8,0)

				table.insert(starsObjects, starsId)

			end

		end

	end


	function destroyStars()

		for _, starsId in ipairs(starsObjects) do

			local stars = findEntity(starsId)
			if stars then
				stars:destroy()
			end

		end

		starsObjects = {}

	end


	-- ***************************************************************************************
	--                                       Weather functions
	-- ***************************************************************************************


	function createWeather()

		for x = 0, 6 do

			for y = 0,6 do

				local weatherId = "weather."..x.."."..y

				spawn("fx", party.level, party.x + x - 3, party.y + y - 3, 0, weatherId)

				local weather = findEntity(weatherId)
				weather:setParticleSystem(getAmbiance().weather)
				weather:setLight(0, 0, 0, 1, 0, 1000000, false)
				weather:translate(0,2,0)

				table.insert(weatherObjects, weatherId)

			end

		end

	end


	function destroyWeather()

		for _, weatherId in ipairs(weatherObjects) do

			local weather = findEntity(weatherId)
			if weather then
				weather:destroy()
			end

		end

		weatherObjects = {}

	end

	function moveWeather(dir)

		local dx, dy = getForward(dir)
		local interval = 0.3

		dx = dx * interval
		dy = dy * interval

		local fxTimer = timers:create(randomTimerId("weatherTimer"))
		fxTimer:setTimerInterval(0.05)
		fxTimer:setTickLimit(10, true)
		fxTimer:addCallback(
			function(self, dx, dy)
				for _, weatherId in ipairs(weatherObjects) do

					local weather = findEntity(weatherId)
					if weather then
						weather:translate(dx,0,-dy)
					end

				end
			end,
			{dx, dy}
		)
		fxTimer:activate()

	end

	-- ***************************************************************************************
	--                                       Ambiance functions
	-- ***************************************************************************************


	function getAmbiance()
		return skyAmbiances[currentAmbiance]
	end


	function setAmbiance(newAmbiance)

		if currentAmbiance == newAmbiance then
			return false
		end

		currentAmbiance = newAmbiance

		destroySkySphere()
		createSkySphere(party.level, party.x, party.y)

		destroySkyLight()
		createSkyLight(party.level, party.x, party.y)

		destroyClouds()
		createClouds()

		destroyStars()
		if getAmbiance().stars then createStars() end

		destroyWeather()
		if getAmbiance().weather then createWeather() end

	end


	function defineAmbiance(defs)

		if not(skyAmbiances[defs.name]) then

			skyAmbiances[defs.name] = {}
			local ambiance = skyAmbiances[defs.name]
			for property,_ in pairs(defs) do
				if property ~= "name" then
					ambiance[property] = defs[property]
				end
			end

		end

	end


	-- ***************************************************************************************
	--                                       Helper functions
	-- ***************************************************************************************

	function delay(delay, funct, args)

		local delayId = skyScript.randomTimerId("delay")
		local delayTimer = timers:create(delayId)

		delayTimer:setTimerInterval(delay)
		delayTimer:addCallback(funct,args)
		delayTimer:setTickLimit(1,true)
		delayTimer:activate()

		return delayId

	end


	function randomTimerId(prefix)

		local numId = math.random(10000,99999)

		while timers:find(prefix.."."..numId) do
			numId = math.random(10000,99999)
		end

		return prefix.."."..numId

	end


	function getCollisionAhead(level, x, y, facing)

		local dx, dy = getForward(facing)
		local monsters = {}

		-- Check for entities on current tile
		for i in entitiesAt(level, x, y) do
			if grimq.isDoor(i) and i:isClosed() and i.facing == facing then
				return "door", nil, i
			end
			if (i.class == "Alcove" or i.class == "Button" or i.class == "Decoration"
					or i.class == "Lever" or i.class == "Lock" or i.class == "Receptor"
					or i.class == "TorchHolder" or i.class == "WallText") and i.facing == facing and isWall(level, x+dx, y+dy) then
				return "wall", i.class, i
			end
		end

		-- Check for entities on next tile
		for i in entitiesAt(level, x+dx, y+dy) do
			if grimq.isDoor(i) and i:isClosed() and (i.facing+2)%4 == facing then
				return "door", nil, i
			end
			if i.class == "Monster" then
				table.insert(monsters, i)
			end
			if i.class == "Party" then
				return "party", nil, i
			end
			if i.class == "Blockage" or i.class == "Crystal" then
				return "object", i.class, i
			end
		end

		if isWall(level, x+dx, y+dy) then
			return "wall", nil, nil
		end
		if #monsters > 0 then
			return "monster", nil, monsters
		else
			return nil, nil, nil
		end
	end


	function shootProjectileWithId(projName,level,x,y,dir,speed,gravity,velocityUp,offsetX,offsetY,offsetZ,attackPower, ignoreEntity,fragile,championOrdinal)

		local pIds = {}

		for i in entitiesAt(level, x, y) do
			if i.class == "Item" and string.find(i.id, "^%d+$") then
				pIds[i.id] = i.name
			end
		end

		shootProjectile(projName,level,x,y,dir,speed,gravity,velocityUp,offsetX,offsetY,offsetZ,attackPower, ignoreEntity,fragile,championOrdinal)

		for i in entitiesAt(level, x, y) do
			if i.class == "Item" and string.find(i.id, "^%d+$") and not(pIds[i.id]) then
				return i.id
			end
		end

	end


	function clampCoord(val)

		if val < 0 then
			val = 0
		elseif val > 31 then
			val = 31
		end

		return val
	end

	-- ***************************************************************************************
	--                                       Initialization
	-- ***************************************************************************************

	defineAmbiance{
		name = "day",
		skySphere = "dx_skysphere_blue",
		skyLightColor = {1.0, 0.9, 0.7},
		skyLightBrightness = 12,
		skyLightParticleSystem = "dx_sun",
		clouds = "dx_clouds_01",
		cloudsFrequence = 5,
	}

	defineAmbiance{
		name = "night",
		stars = "dx_stars",
		skyLightColor = {0.6, 0.7, 1.1},
		skyLightBrightness = 1.5,
		clouds = "dx_clouds_dark",
		cloudsFrequence = 3,
	}

	defineAmbiance{
		name = "dark_night",
		stars = "dx_dark_stars",
		skyLightColor = {0.6, 0.7, 1.0},
		skyLightBrightness = 0.3,
		clouds = "dx_clouds_dark",
		cloudsFrequence = 5,
	}

	defineAmbiance{
		name = "rainy_day",
		skySphere = "dx_skysphere_grey",
		skyLightColor = {0.9, 0.9, 0.9},
		skyLightBrightness = 8,
		skyLightParticleSystem = "dx_sun_clouds",
		weather = "dx_rain",
		clouds = "dx_clouds_grey",
		cloudsFrequence = 9,
	}

	setAmbiance("rainy_day")


	-- ***************************************************************************************
	--                                       Test scrolls
	-- ***************************************************************************************

	party:getChampion(1):insertItem(28, spawn("scroll_day"))
	party:getChampion(1):insertItem(29, spawn("scroll_rainy_day"))
	party:getChampion(1):insertItem(30, spawn("scroll_night"))
	party:getChampion(1):insertItem(31, spawn("scroll_dark_night"))