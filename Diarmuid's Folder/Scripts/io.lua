data = {}

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

-- Dungeon Import/Export
-- =====================

function autoexec()
	load()
end

function load()
	local sData = importData()
	if sData then
		data = {}
		data = sData
		loadDungeonState()
		hudPrint("LotNR game data loaded from dungeon"..data.system.originName)
	end
end

function save()
	saveDungeonState()
	exportData()
	hudPrint("You have reached an exit zone. LotNR game data is now stored; if you")
	hudPrint("wish, you can save your game and import the save in another dungeon.")
end

function saveDungeonState()
	savePartyData()
	saveSystemData()
	if not(data[dungeon.id]) then data[dungeon.id] = {} end
	saveItemsData()
end

function loadDungeonState()
	if data[dungeon.id] then
		if data[dungeon.id].items then
			loadItemsData()
		end
	end
	if data.party then
		loadPartyData()
	end
end

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
				party:getChampion(i):insertItem(slot, loadItem(item))
			else
				party:getChampion(i):removeItem(slot)
			end
		end
	end
	-- Load mouse item
	local item = data.party.mouse 
	if item ~= "nil" then
		setMouseItem(loadItem(item))
	else
		setMouseItem(nil)
	end
end

function saveSystemData()
	if not(data.system) then data.system = {} end
	local system = data.system
	system.originId = dungeon.id
	system.originName = dungeon.name
	system.originSaveLevel = party.level
	system.originSaveX = party.x
	system.originSaveY = party.y
end

function saveItemsData()
	-- Save Torchholders Data
	data[dungeon.id].torchHolders = {}
	for level = 1, getMaxLevels() do
		for i in allEntities(level) do
			if i.class == "TorchHolder" then
				if i:hasTorch() then
					for j in entitiesAt(i.level, i.x, i.y) do
						if j.name == "torch" then
							if not(data[dungeon.id].torchHolders[i.id]) then
								data[dungeon.id].torchHolders[i.id] = {j.id, j:getFuel()}
							end
						end
					end
				else
					table.insert(data[dungeon.id].torchHolders, {i.id, "nil"})
				end
			end
		end
	end
	-- Save Alcoves & Altars data
	data[dungeon.id].alcoves = {}
	for level = 1, getMaxLevels() do
		for i in allEntities(level) do
			if i.class == "Alcove" or i.class == "Altar" then
				if i:getItemCount() > 0 then
					data[dungeon.id].alcoves[i.id] = {}
					for j in i:containedItems() do
						table.insert(data[dungeon.id].alcoves[i.id], saveItem(j))
					end
				end
			end
		end
	end
	-- Save Items Data
	data[dungeon.id].items = {}
	local items = data[dungeon.id].items
	for level = 1, getMaxLevels() do
		for i in allEntities(level) do
			if i.class == "Item" then
				local contained = false
				for _, v in ipairs(data[dungeon.id].torchHolders) do
					if v[2] == i.id then
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
	end
end

function loadItemsData()
	-- Destroy existing items
	for level = 1, getMaxLevels() do
		for i in allEntities(level) do
			if i.class == "Item" then
				i:destroy()
			end
		end
	end
	-- Load Torches Data
	local torches = data[dungeon.id].torchHolders
	for id, t in pairs(torches) do
		findEntity(id):addItem(spawn("torch"):setFuel(t[2]))
	end	
	-- Load Alcoves Data
	local alcoves = data[dungeon.id].alcoves
	for id, a in pairs(alcoves) do
		for _, i in ipairs(a) do
			findEntity(id):addItem(loadItem(i))
		end
	end	
	-- Load Items Data
	local items = data[dungeon.id].items
	for _, i in ipairs(items) do
		loadItem(i.i, i.l, i.x, i.y, i.f)
	end
end

function saveObjectsData()
	-- Save Doors Data
	data[dungeon.id].doors = {}
	for level = 1, getMaxLevels() do
		for i in allEntities(level) do
			if grimq.isDoor(i) then
				local state
				if i:isOpen() then
					state = "o"
				else
					state = "c"
				end
				table.insert(data[dungeon.id].doors, state)
			end
		end
	end
end

function loadObjectsData()
	-- Load Doors Data
	local doors = data[dungeon.id].doors
	for id, state in ipairs(doors) do
		if state == "o" then
			findEntity(id):setDoorState("open")
		else
			findEntity(id):setDoorState("closed")
		end
	end	
end



-- grimQ item functions, based on Xanathar code
-- =======================

-- saves an item into the table
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

-- loads an item from the table
function loadItem(itemTable, level, x, y, facing, id)
   local spitem = nil
   	id = id or itemTable.i
	
    -- if id is numeric then create a new unique id for item
    -- for some reason numeric id's are not allowed as a spawn-function argument
   if (id and string.find(id, "^%d+$")) then
      id = nil
   end
   if (level ~= nil) then
	  spitem = spawn(itemTable.n, level, x, y, facing,id)
   else
	  spitem = spawn(itemTable.n,nil,nil,nil,nil,id)
   end
   if itemTable.s > 0 then
	  spitem:setStackSize(itemTable.s)
   end
   if itemTable.c > 0 then
	  spitem:setCharges(itemTable.c)
   end            
   
   if itemTable.t ~= nil then
	  spitem:setScrollText(itemTable.t)
   end
   
   spitem:setFuel(itemTable.f)
   
   if (itemTable.sI ~= nil) then
	  for _, subTable in pairs(itemTable.sI) do
		 local subItem = loadItem(subTable)
		 spitem:addItem(subItem, false)
	  end
   end
   
   return spitem
end
