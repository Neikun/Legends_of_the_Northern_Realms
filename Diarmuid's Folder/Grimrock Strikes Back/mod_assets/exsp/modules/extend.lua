fw_addModule("extend",[[
-- Universal Object Extender

objects = {}

-- create methods Table and define default Grimrock Methods
methods = {
	Monster = {
		setAIState = function(self, state)
			findEntity(self.id):setAIState(state)
		end,
		setHealth = function(self, health)
			findEntity(self.id):setHealth(health)
		end,
		getHealth = function(self)
			return findEntity(self.id):getHealth()
		end,
		setLevel = function(self, level)
			findEntity(self.id):setLevel(level)
		end,
		getLevel = function(self)
			return findEntity(self.id):getLevel()
		end,
		setPosition = function(self, x, y, level, facing)
			findEntity(self.id):setPosition(x, y, level, facing)
		end,
		addItem = function(self, item)
			findEntity(self.id):addItem(item)
		end,
		destroy = function(self)
			findEntity(self.id):destroy()
		end,	
	},
}

function entity(self, entity)
	if not(entity) then return nil end
	if not(self.methods[entity.class]) then return entity end
	if self.objects[entity.id] then return self.objects[entity.id] end
	self.objects[entity.id] = {}
	local object = self.objects[entity.id]
	object.name = entity.name
	object.id = entity.id
	object.level = entity.level
	object.x = entity.x
	object.y = entity.y
	object.facing = entity.facing
	object.class = entity.class
	return addMethods(object)
end

function addMethods(object)
	if not(extend.methods[object.class]) then return nil end
	for k, v in pairs(extend.methods[object.class]) do
		object[k] = v
	end
	return object
end

function entities(self,t)
	for i, v in ipairs(t) do
		v = self:entity(v)
		t[i] = t		
	end
	return t
end

function find(self,id)
	return self.entity(findEntity(id))
end

function refresh(self)
	self.level = findEntity(self.id).level
	self.x = findEntity(self.id).x
	self.y = findEntity(self.id).y
	self.facing = findEntity(self.id).facing
end

function registerMethods(self, class, methods)
	if not(self.methods[class]) then self.methods[class] = {} end
	for k, v in pairs(methods) do
		self.methods[class][k] = v
	end
end

-- Optional Object Detector
function objectDetector()
	for id, object in pairs(objects) do
		if object.class == "Monster" and findEntity(id) then
			object.level = findEntity(id).level
			object.x = findEntity(id).x
			object.y = findEntity(id).y
			object.facing = findEntity(id).facing
		else
			object = nil
		end
	end
end
]])