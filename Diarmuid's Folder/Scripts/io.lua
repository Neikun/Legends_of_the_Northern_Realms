-- ================================================================================
--                                SAVE IO SCRIPT
-- ================================================================================

-- Main Data Object
data = {}


-- ===================================================================================================
--                                GLOBAL SAVE/LOAD FUNCTIONS
-- ===================================================================================================

function onSavePoint()
	hudPrint("You have reached an exit zone. LotNR game data is now stored; if you")
	hudPrint("wish, you can save your game and import the save in another dungeon.")
	save()
	data.system.savePoint = true
end

function offSavePoint()
	data.system.savePoint = false
end

function autoexec()
	data[dungeon.id] = {}
	data.system = {}
	data[dungeon.id].mod = {}
	load()
	data.system.savePoint = false
	save()
end

function load()
	local sData = importData()
	if sData then
		data = {}
		data = sData
		loadDungeonState()
		hudPrint("LotNR game data loaded from dungeon "..data.system.origin.name)
	end
end

function save()
	saveDungeonState()
	exportData()
end

function saveDungeonState()
	savePartyData()
	saveSystemData()
	if not(data[dungeon.id]) then data[dungeon.id] = {} end
	saveItemsData()
	saveObjectsData()
	saveMonstersData()
end

function loadDungeonState()
	if data[dungeon.id] then
		if data[dungeon.id].items then
			loadItemsData()
		end
		loadMonstersData()
		loadObjectsData()
	end
	if data.party then
		loadPartyData()
	end
end

-- ===================================================================================================
--                                DUNGEON IMPORT/EXPORT FUNCTIONS
-- ===================================================================================================

function savePartyData()
	data.party = {}
	-- Save inventory items
	if not(data.party.items) then data.party.items = {} end
	for i = 1,4 do
		data.party.items[i] = {}
		for j = 1, 31 do
			local item = party:getChampion(i):getItem(j)
			if item then
				data.party.items[i][j] = saveItem(item)
			else
				data.party.items[i][j] = "nil"
			end
		end
	end
	-- Save mouse item
	local item = getMouseItem()
	if item then
		data.party.mouse = saveItem(item)
	else
		data.party.mouse = "nil"
	end
end

function loadPartyData()
	-- Load inventory items
	local items = data.party.items
	for i, v in ipairs(items) do
		for slot, item in pairs(v) do
			if item ~= "nil" then
				if checkItemName(item.n) then
					party:getChampion(i):insertItem(slot, loadItem(item))
				else
					print("Warning, "..item.n.." is not defined in this Dungeon")
				end
			else
				party:getChampion(i):removeItem(slot)
			end
		end
	end
	-- Load mouse item
	local item = data.party.mouse 
	if item ~= "nil" then
		if checkItemName(item.n) then
			setMouseItem(loadItem(item))		
		else
			print("Warning, "..item.n.." is not defined in this Dungeon")
		end
	else
		setMouseItem(nil)
	end
end

function saveSystemData()
	if not(data.system) then data.system = {} end
	local system = data.system
	system.origin = {}
	system.origin.id = dungeon.id
	system.origin.name = dungeon.name
	system.origin.version = dungeon.version
	system.origin.saveLevel = party.level
	system.origin.saveX = party.x
	system.origin.saveY = party.y
	system.origin.saveFacing = party.facing
end

function saveItemsData()
	-- Save Torchholders Data
	data[dungeon.id].torchHolders = {}
	for i in grimq.fromAllEntitiesInWorld():where("class", "TorchHolder"):toIterator() do
		if i:hasTorch() then
			for j in entitiesAt(i.level, i.x, i.y) do
				if j.name == "torch" then
					if not(data[dungeon.id].torchHolders[i.id]) then
						data[dungeon.id].torchHolders[i.id] = {j.id, j:getFuel()}
					end
				end
			end
		end
	end
	-- Save Alcoves & Altars data
	data[dungeon.id].alcoves = {}
	for i in grimq.fromAllEntitiesInWorld():toIterator() do
		if i.class == "Alcove" or i.class == "Altar" then
			if i:getItemCount() > 0 then
				data[dungeon.id].alcoves[i.id] = {}
				for j in i:containedItems() do
					table.insert(data[dungeon.id].alcoves[i.id], saveItem(j))
				end
			end
		end
	end
	-- Save Items Data
	data[dungeon.id].items = {}
	local items = data[dungeon.id].items
	for i in grimq.fromAllEntitiesInWorld():where("class", "Item"):toIterator() do
		local contained = false
		for _, v in pairs(data[dungeon.id].torchHolders) do
			if v[1] == i.id then
				contained = true
			end
		end
		for _, alcoveItems in pairs(data[dungeon.id].alcoves) do
			for _, w in ipairs(alcoveItems) do
				if w.i == i.id then
					contained = true
				end
			end
		end
		if not(contained) then
			table.insert(items, {
				i = saveItem(i),
				l = i.level, 
				x = i.x,
				y = i.y,
				f = i.facing
				}
			)
		end
	end
end

function loadItemsData()
	-- Destroy existing items
	for i in grimq.fromAllEntitiesInWorld():where("class", "Item"):toIterator() do
		i:destroy()
	end
	-- Load Torches Data
	local torches = data[dungeon.id].torchHolders
	for id, t in pairs(torches) do
		findEntity(id):addItem(spawn("torch"):setFuel(t[2]))
	end	
	-- Load Alcoves Data
	local alcoves = data[dungeon.id].alcoves
	for id, alcove in pairs(alcoves) do
		for _, item in ipairs(alcove) do
			if checkItemName(item.n) then
				findEntity(id):addItem(loadItem(item))
			else
				print("Warning, "..item.n.." is not defined in this Dungeon")
			end
			
		end
	end	
	-- Load Items Data
	local items = data[dungeon.id].items
	for _, item in ipairs(items) do
		if checkItemName(item.n) then
			loadItem(item.i, item.l, item.x, item.y, item.f)
		else
			print("Warning, "..item.n.." is not defined in this Dungeon")
		end
		
	end
end

function saveObjectsData()
	-- Save Levers Data
	data[dungeon.id].levers = {}
	for i in grimq.fromAllEntitiesInWorld():where("class", "Lever"):toIterator() do
		local state
		if i:getLeverState() == "activated" then
			state = "a"
		else
			state = "d"
		end
		data[dungeon.id].levers[i.id] = state
	end
	-- Save Teleporters Data
	data[dungeon.id].tel = {}
	for i in grimq.fromAllEntitiesInWorld():where("class", "Teleporter"):toIterator() do
		local state
		if i:isActivated() then
			state = "a"
		else
			state = "d"
		end
		data[dungeon.id].tel[i.id] = state
	end
	-- Save Timers Data
	data[dungeon.id].timers = {}
	for i in grimq.fromAllEntitiesInWorld():where("class", "Timer"):toIterator() do
		local state
		if i:isActivated() then
			state = "a"
		else
			state = "d"
		end
		data[dungeon.id].timers[i.id] = state
	end
	-- Save Counters Data
	data[dungeon.id].counters = {}
	for i in grimq.fromAllEntitiesInWorld():where("class", "Counter"):toIterator() do	
		data[dungeon.id].counters[i.id] = i:getValue()
	end
	-- Save WallText Data
	data[dungeon.id].wTexts = {}
	for i in grimq.fromAllEntitiesInWorld():where("class", "WallText"):toIterator() do	
		data[dungeon.id].wTexts[i.id] = i:getWallText()
	end
	-- Save Doors Data
	data[dungeon.id].doors = {}
	for i in grimq.fromAllEntitiesInWorld():where(grimq.isDoor):toIterator() do
		local state
		if i:isOpen() then
			state = "o"
		else
			state = "c"
		end
		data[dungeon.id].doors[i.id] = state
	end
	-- Save Pits Data
	data[dungeon.id].pits = {}
	for i in grimq.fromAllEntitiesInWorld():where("class","Pit"):toIterator() do
		local state
		if i:isOpen() then
			state = "o"
		else
			state = "c"
		end
		data[dungeon.id].pits[i.id] = state
	end
end

function loadObjectsData()
	-- Load Levers Data
	if data[dungeon.id].levers then
		for id, state in pairs(data[dungeon.id].levers) do
			if findEntity(id) then
				if state == "a" then
					findEntity(id):setLeverState("activated")
				else
					findEntity(id):setLeverState("deactivated")
				end
			end
		end
	end
	-- Load Teleporters Data
	if data[dungeon.id].tel then
		for id, state in pairs(data[dungeon.id].tel) do
			if findEntity(id) then
				if state == "a" then
					findEntity(id):activate()
				else
					findEntity(id):deactivate()
				end
			end
		end
	end
	-- Load Timers Data
	if data[dungeon.id].timers then
		for id, state in pairs(data[dungeon.id].timers) do
			if findEntity(id) then
				if state == "a" then
					findEntity(id):activate()
				else
					findEntity(id):deactivate()
				end
			end
		end	
	end
	-- Load Counters Data
	if data[dungeon.id].counters then
		for id, value in pairs(data[dungeon.id].counters) do
			if findEntity(id) then
				findEntity(id):setValue(value)
			end
		end	
	end
	-- Load Wall Texts Data
	if data[dungeon.id].wTexts then
		for id, value in pairs(data[dungeon.id].wTexts) do
			if findEntity(id) then
				findEntity(id):setWallText(value)
			end
		end
	end
	-- Load Doors Data
	if data[dungeon.id].doors then
		for id, state in pairs(data[dungeon.id].doors) do
			if findEntity(id) then
				if state == "o" then
					findEntity(id):setDoorState("open")
				else
					findEntity(id):setDoorState("closed")
				end
			end
		end
	end
	-- Load Pits Data
	if data[dungeon.id].pits then
		for id, state in pairs(data[dungeon.id].pits) do
			if findEntity(id) then
				if state == "o" then
					findEntity(id):setPitState("open")
				else
					findEntity(id):setPitState("closed")
				end
			end
		end
	end
end

function saveMonstersData()
	data[dungeon.id].monsters = {}
	local monsters = data[dungeon.id].monsters
	for i in grimq.fromAllEntitiesInWorld():where("class", "Monster"):toIterator() do
		table.insert(monsters, {
			i = i.id,
			n = i.name,
			l = i.level, 
			x = i.x,
			y = i.y,
			f = i.facing,
			v = i:getLevel(),
			h = i:getHealth(),
			}
		)
	end
end

function loadMonstersData()
	-- Destroy existing monsters
	for i in grimq.fromAllEntitiesInWorld():where("class", "Monster"):toIterator() do
		i:destroy()
	end
	-- Load monsters data
	local monsters = data[dungeon.id].monsters
	for _, i in ipairs(monsters) do
		spawn(i.n, i.l, i.x, i.y, i.f, i.id):setLevel(i.v):setHealth(i.h)
	end
end

-- Tracking functions
-- =====================

function initSecrets()
	--ToDO
end

function trackSecrets()
	--ToDO
end

-- Table serialization code
-- ========================

tags = {
	data = {"<data>","</data>"},
	var = {"<@","@>"},
	table = "@t",
	array = "@a",
}

function exportData()
	local save = party:getChampion(1):getName()
	save = string.sub(save, 0, string.find(save, "     "))
	save = save..voidLines..tags.data[1]
	for i, v in pairs(data) do
		save = save..serialize(i, v)
	end
	save = save..tags.data[2]
	print("Data lenght:",#save)
	party:getChampion(1):setName(save)
end

function importData()
	local sData = {}
	local load = party:getChampion(1):getName()
	if not(string.find(load, tags.data[1])) then
		return false
	end
	load = splitTags(load, tags.data[1], tags.data[2])
	load = splitTags(load[1], tags.var[1],tags.var[2])
	for i, v in ipairs(load) do
		local var, value = unserialize(v)
		sData[var] = value
	end
	return sData
end

function serialize(var, value)
	local resultString = ""
	if type(value) == "table" then
		resultString = resultString..tags.var[1]..var.."="
		local isArray = false
		for i, v in ipairs(value) do
			if i then
				isArray = true
			end
		end
		if isArray then
			resultString = resultString..tags.array
			for i, v in pairs(value) do
				resultString = resultString..serialize(i, v)
			end
		else
			resultString = resultString..tags.table
			for i, v in pairs(value) do
				resultString = resultString..serialize(i, v)
			end
		end
		resultString = resultString..tags.var[2]
	else
		resultString = resultString..tags.var[1]..tostring(var).."="..tostring(value)..tags.var[2]
	end
	return resultString
end

function unserialize(str)
	local var, value
	local equal = string.find(str, "=")
	var = string.sub(str, 0, equal-1)
	value = string.sub(str, equal+1)
	if grimq.strstarts(value, tags.table) then
		local tableValue = {}
		local tableData = string.sub(value, #tags.table+1)
		local tableData = splitTags(tableData, tags.var[1], tags.var[2])
		for i, v in ipairs(tableData) do
			local tVar, tValue = unserialize(v)
			if tonumber(tValue) then
				tValue = tonumber(tValue)
			end
			if tValue ~= "nil" then
				--print(tVar, tValue)
			end
			tableValue[tVar] = tValue
		end
		return var, tableValue
	elseif grimq.strstarts(value, tags.array) then
		local tableValue = {}
		local tableData = string.sub(value, #tags.array+1)
		local tableData = splitTags(tableData, tags.var[1], tags.var[2])
		for i, v in ipairs(tableData) do
			local tVar, tValue = unserialize(v)
			if tonumber(tValue) then
				tValue = tonumber(tValue)
			end
			if tValue ~= "nil" then
				--print(tVar, tValue)
			end
			table.insert(tableValue, tValue)
		end
		return var, tableValue
	else
		if tonumber(value) then
			value = tonumber(value)
		end
		return var, value
	end	
end

function splitTags(str, startTag, endTag)
	local t = {}
	local currentPos, startPos, endPos, nest = 0, 0, 0, 0
	local sTagStart, sTagEnd, eTagStart, eTagEnd
	local ctr, ctr2 = 0, 0
	while string.find(str, startTag, endPos) do
		sTagStart, sTagEnd = string.find(str, startTag, currentPos)
		eTagStart, eTagEnd = string.find(str, endTag, currentPos)
		if sTagStart < eTagStart then
			nest = nest + 1
			startPos = sTagEnd + 1
			currentPos = sTagEnd + 1
			endPos = eTagStart - 1
		else
			return ""
		end
		while nest > 0 do
			sTagStart, sTagEnd = string.find(str, startTag, currentPos)
			eTagStart, eTagEnd = string.find(str, endTag, currentPos)
			if sTagStart and sTagStart < eTagStart then
				nest = nest + 1
				currentPos = sTagEnd + 1 
			else
				nest = nest - 1
				currentPos = eTagEnd + 1
				if string.sub(str, currentPos, currentPos + #startTag) == startTag then
					currentPos = eTagEnd + 1 + #startTag
				end
				endPos = eTagStart - 1
			end
		end
		table.insert(t, string.sub(str, startPos, endPos))
	end
	return t
end
	
voidLines = [[      








































]]

-- ===================================================================================================
--                               ITEM FUNCTIONS (Based on Xanathar's Code)
-- ===================================================================================================

function saveItem(item)
   local itemTable = { }
   itemTable.i = item.id
   itemTable.n = item.name
   itemTable.s = item:getStackSize()
   itemTable.f = item:getFuel()
   itemTable.c = item:getCharges()
   itemTable.t = item:getScrollText()
   
   local idx = 0
   for subItem in item:containedItems() do
	  if (idx == 0) then
		 itemTable.sI = { }
	  end
	  
	  itemTable.sI[idx] = saveItem(subItem)
	  idx = idx + 1
   end
   
   return itemTable
end

function loadItem(itemTable, level, x, y, facing, id)
	local itemToSpawn = nil
	id = id or itemTable.i
	
	id = checkItemId(id)
	
	if (level ~= nil) then
		itemToSpawn = spawn(itemTable.n, level, x, y, facing,id)
	else
		itemToSpawn = spawn(itemTable.n,nil,nil,nil,nil,id)
	end
	if itemTable.s > 0 then
		itemToSpawn:setStackSize(itemTable.s)
	end
	if itemTable.c > 0 then
		itemToSpawn:setCharges(itemTable.c)
	end            
   
	if itemTable.t ~= nil then
		itemToSpawn:setScrollText(itemTable.t)
	end
	
	if type(itemTable.f) ~= "string" then
		itemToSpawn:setFuel(itemTable.f)
	end

	if (itemTable.sI ~= nil) then
		for _, subTable in pairs(itemTable.sI) do
			local subItem = loadItem(subTable)
			itemToSpawn:addItem(subItem, false)
		end
	end
   
	return itemToSpawn
end

function checkItemId(id)
	if findEntity(id) then
		return nil
	end
	for i = 1,4 do
		for j = 1, 31 do
			if party:getChampion(i):getItem(j).id == id then
				return nil
			end
		end
	end
	if getMouseItem().id == id then
		return nil
	end
	if string.find(id, "^%d+$") then
		return nil
	end
	return id
end

function checkItemName(name)
	for _, items in pairs(io_items.ioItemList) do
		for _,item in ipairs(items) do
			if name == item then
				return true
			end
		end
	end
	return false
end

