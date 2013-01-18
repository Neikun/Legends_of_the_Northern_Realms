tUtil = {
	--used in util.table_toString
	escapeChars = {
		[1] = {
			Char = "\\",
			Relacement_char = "\\\\",
		},
		[2] = {
			Char = "\a",
			Relacement_char = "\\a",
		},
		[3] = {
			Char = "\b",
			Relacement_char = "\\b",
		},
		[4] = {
			Char = "\f",
			Relacement_char = "\\f",
		},
		[5] = {
			Char = "\r\n",
			Relacement_char = "\\r\\n",
		},
		[6] = {
			Char = "\t",
			Relacement_char = "\\t",
		},
		[7] = {
			Char = "\v",
			Relacement_char = "\\v",
		},
		[8] = {
			Char = "\"",
			Relacement_char = "\\\"",
			},
		[9] = {
			Char = "\'",
			Relacement_char = "\\'",
		},	
		[10] = {
			Char = "%[",
			Relacement_char = "%%[",
			},
		[11] = {
			Char = "%]",
			Relacement_char = "%%]",
		},	
	},
};


--================================================================================
--								<<<All Util Methods>>>
--================================================================================


--[[
------------------------------
util.varIsValid(table, string)
Return Type: boolean
Method Type: external
------------------------------
This will check the validity
of a variable's type. The first
arguement is a numerically-indexed
table whose values are strings all
of the allowed variable types.
For Example:
util.varIsValid({"string","number","nil"}, v_myVar)
]]
function varIsValid(t_types, v_var)
--a list of all usable variable inputs
local t_validTypes = {
	b = "boolean",
	f = "funciton",
	l = "nil",
	n = "number",
	s = "string",
	t = "table",
};
	
	--make sure the table containing the allowed types exists
	if type(t_types) == "table" then
	--get the type of variable that was input
	local s_varType = type(v_var);
		
		--for each item in the allowed variable types table...
		for n_typeID, s_typeID in pairs(t_types) do		
		s_typeID = string.lower(s_typeID);
		
			---check that the input type exists
			if t_validTypes[s_typeID] then
				
				--check to see if the input variable meets one of the allowed types input
				if s_varType == t_validTypes[s_typeID] then				
				return true
				end
		
			end			
			
		end		
			
	end
	
return false
end


--================================================================================
--									<<<DUNGEON>>>
--================================================================================


--[[
-------------------------------------------------------------------
util.dungeon_adjacentCellIsWall(Integer, Integer, Integer, Integer)
Return Type: boolean
Method Type: external
-------------------------------------------------------------------
Used to determine if a cell adjacent to the input cell is a wall.
This is, of course, relative to the input facing.
]]
function dungeon_adjacentCellIsWall(n_level, n_facing, n_x, n_y)

	if n_facing == 0 then
	n_y = n_y - 1;
	
	elseif n_facing == 1 then
	n_x = n_x + 1;
	
	elseif n_facing == 2 then
	n_y = n_y + 1;
	
	elseif n_facing == 3 then
	n_x = n_x - 1;
	
	end
	
	if n_x > -1 and n_x < 32 and n_y > -1 and n_y < 32 then
	return isWall(n_level, n_x, n_y)
	end
	
return true
end


--================================================================================
--									<<<MATH>>>
--================================================================================


--[[
-------------------------
util.math_getAlternator()
Return Type: number
Method Type: external
-------------------------
Gets a random number:
either 1 or -1. This is
used for randomaly converting
a positive number to negative
and vice versa.
]]
function math_getAlternator()
-- (-1 ^ 1 == -1 and -1 ^ 2 == 1)
return (-1) ^ math.random(1,2)
end


--[[
--------------------------
util.math_upOrDown(number)
Return Type: number
Method Type: external
--------------------------
A utility function that
returns an integer value to
the (randomly chosen) nearest
high or low value of the
input number.
]]
function math_upOrDown(n_value)
		
	if math.random() < 0.5 then
	return math.floor(n_value)
	else
	return math.ceil(n_value)
	end

end


--================================================================================
--									<<<POSITION>>>
--================================================================================


--[[
---------------------------------------
util.position_getOppositeFacing(number)
Return Type: number
Method Type: external
---------------------------------------
Given a facing, this function will return
a facing that is opposite.
Note: if the facing value is invalid, 0
is returned.
]]
function position_getOppositeFacing(n_facing)
	
	if util.VarIsValid({"number"}, n_facing) then
		--input north, output south
		if n_facing == 0 then
		return 2
		
		--input east, output west
		elseif n_facing == 1 then
		return 3
		
		--input south, output north
		elseif n_facing == 2 then
		return 0
		
		--input west, output east
		elseif n_facing == 3 then	
		return 1
		end
	
	end

--default return value
return 0
end


--================================================================================
--									<<<STRING>>>
--================================================================================


--[[
--------------------------------
util.string_generateUUID(string)
Return Type: number
Method Type: external
--------------------------------
Creates a Universal Unique
Identifier that may contain
a prefix.
]]
function string_generateUUID(s_prefix)
local t_chars = {"x","3","y","1","b","2","p","e","8","f","v","t","g","9","h","7","u","4","i","z","a","j","0","c","k","l","5","m","n","w","o","q","r","s","d","6"};
local t_sequence = {1,4,4,4,12};
local s_UUID = "";
local n_maxPrefixLength = 6; --range from 0 to 8
local s_delimiter = "-";

if type(s_prefix) == "string" then
local nLength = string.len(s_prefix);
	
	if nLength > n_maxPrefixLength then
	s_prefix = string.sub(s_prefix, 1, n_maxPrefixLength);
	end
	
	if string.gsub(s_prefix, " ", "") ~= "" then
	s_UUID = s_prefix..s_delimiter;
	end
	
	if nLength < n_maxPrefixLength then
	t_sequence[1] = t_sequence[1] + (n_maxPrefixLength - nLength);
	end
	
else
t_sequence[1] = 8;
end

for n_index, n_sequence in pairs(t_sequence) do
	
	for x = 1, n_sequence do
	s_UUID = s_UUID..t_chars[math.random(1, 36)];
	end

s_UUID = s_UUID.."-";
end

--fixes the extra - at the end
return string.sub(s_UUID, 1, string.len(s_UUID) - 1)
end


--================================================================================
--									<<<TABLE>>>
--================================================================================


--[[
----------------------------------
util.table_toString(table, integer)
Return Type: string
Method Type: internal
----------------------------------
Does just what it says and more!
Will return the entire table and
all its contents, recursivley as
a string value (with tags).
Note: In this version of the
function (LoG versions)it cannot
store functions if they are values
in the table. This is due to the
fact that the 'getfenv' lua function
is not accessable from inside LoG.
A few Notes:
1. This function creates tags for
a mark-up system used with the
util.StringToTable() function. It
is not intended to be used for any
other purpose.
2. This will handle indices
of only types string and number.
3. This will handle values of
only types string, number, boolean,
nil and table.
4. The number(argument #2) MUST be
exluded.
]]
function table_toString(t_input, n_count)
--the string to return
local s_ret = "";
local n_count = n_count;

	--initialize the count variable if it's not
	if type(n_count) ~= "number" then
	n_count = 0;
	end
	
--step the count variable
n_count = n_count + 1;
--convert to string for use with the tags
local s_count = tostring(n_count);
	
	--if the input type is a table...
	if type(t_input) == "table" then
	s_ret = s_ret.."<t"..s_count..">";
		
		--process each item in the table
		for v_index, v_item in pairs(t_input) do
		local s_indexType = type(v_index);
		local s_itemType = type(v_item);
		local s_index = "";
				
			--write the index to string
			local s_myType = "n";
			if s_indexType == "string" then
			s_myType = "s";
			end
			
			--set up the key, value pair start tag
			s_ret = s_ret.."<p"..s_count..">"..s_myType;
			
			--write the	item to string
			if s_itemType == "number" then
			s_ret = s_ret.."n<k>"..v_index.."</k><v>"..v_item.."</v>";
			
			elseif s_itemType == "string" then
			
				for n_index, t_char in pairs(tutil.escapeChars) do
				v_item = string.gsub(v_item, t_char.Char, t_char.Relacement_char);
				end
			
			s_ret = s_ret.."s<k>"..v_index.."</k><v>"..v_item.."</v>";
			
			elseif s_itemType == "boolean" then
			
				if v_item then
				s_ret = s_ret.."b<k>"..v_index.."</k><v>".."true</v>";
				else
				s_ret = s_ret.."b<k>"..v_index.."</k><v>".."false</v>";
				end
			
			elseif s_itemType == "nil" then
			s_ret = s_ret.."l<k>"..v_index.."</k><v>".."nil</v>";
						
			elseif s_itemType == "function" then
			--Can't use this, don't have access to the getfenv function in LoG
									
			elseif s_itemType == "userdata" then
			--do the userdata stuff here...
			
			elseif s_itemType == "table" then
			s_ret = s_ret.."t<k>"..v_index.."</k><v>"..util_tableToString(v_item, n_count).."</v>";
			
			end
		
		--finish this key, value pair
		s_ret = s_ret.."</p"..s_count..">";
		end
			
	end

s_ret = s_ret.."</t"..s_count..">";

return s_ret
end


--[[
--------------------------
util.table_fromString(string)
Return Type: table
Method Type: internal
--------------------------
Converts a table, previously
created by the above-listed
util.TableToString() function
back into a table.
A Few Notes:
1. This works ONLY with the
format provided by the above-
named function. The results of
using a string not generated by
that function are unpredictable.
2. This will handle indices
of only types string and number.
3. This will handle values of
only types string, number, boolean,
nil and table.
4. The number(argument #2) MUST be
excluded when called.
]]
function table_fromString(sInput, n_count)
local n_count = n_count;

	--initialize the count variable if it's not
	if type(n_count) ~= "number" then
	n_count = 0;
	end
	
--step the count variable
n_count = n_count + 1;
--convert to string for use with the tags
local s_count = tostring(n_count);

--the table that will be returned
local t_ret = {};
--used for simplicity
local t_types = {
	b = "boolean",
	l = "nil",
	n = "number",
	s = "string",
	t = "table",
};
--a list of the tags being used
local t_tags = {
	KVP = {
		Open = {
			Length = 0,
			String = "<p"..s_count..">",
		},
		Close = {
			Length = 0,
			String = "</p"..s_count..">",
		},
	},
	Key = {
		Open = {
			Length = 0,
			String = "<k>",
		},
		Close = {
			Length = 0,
			String = "</k>",
		},
	},
	Value = {
		Open = {
			Length = 0,
			String = "<v>",
		},
		Close = {
			Length = 0,
			String = ">v/<", --reversed to accommodate the reverse-string search for the last close tag
		},
	},
};

	--get the length of all of the tags
	for sTagClass, tTag in pairs(t_tags) do
	t_tags[sTagClass].Open.Length = string.len(tTag.Open.String);
	t_tags[sTagClass].Close.Length = string.len(tTag.Close.String);
	end

--where the last search ended (and the next search wil start)
local nSearch_E = 1;
local bContinue = true;
local nSearchKVP_S, nSearchKVP_E = 0, 0;
	
	--this loop will continue until no more key, value pairs are found
	while bContinue do
	--make sure no loopy happens
	bContinue = false;
	--find the point where the next key,value pair open tag begins
	nSearchKVP_S, nSearchKVP_E = string.find(sInput, t_tags.KVP.Open.String, nSearch_E);
		
		if nSearchKVP_S and nSearchKVP_E then
		--get the start point of the key tag
		local nKeyStart = nSearchKVP_E + 3;
		--get the index type
		local sKeyType = t_types[string.sub(sInput, nSearchKVP_E + 1, nSearchKVP_E + 1)];
		--get the item type
		local sValueType = t_types[string.sub(sInput, nSearchKVP_E + 2, nSearchKVP_E + 2)];
		--find the start of the close tag in this key, value pair
		local nMyEnd = string.find(sInput, t_tags.KVP.Close.String, nKeyStart);
			
			if nMyEnd then
			--get the string containing the type strings, index and item of the key, value pair
			local sKVPRaw = string.sub(sInput, nKeyStart, nMyEnd - 1);
			--get the start and end points for the key open tag
			local nKeyOpen_S, nKeyOpen_E = string.find(sKVPRaw, t_tags.Key.Open.String, 1);
				
				if nKeyOpen_S and nKeyOpen_E then
				--get the start and end points for the key close tag
				local nKeyClose_S, nKeyClose_E = string.find(sKVPRaw, t_tags.Key.Close.String, 1);
					
					if nKeyClose_S and nKeyClose_E then
					--get the start and end points for the value open tag
					local n_valueOpen_S, n_valueOpen_E = string.find(sKVPRaw, t_tags.Value.Open.String, 1);
					
						if n_valueOpen_S and n_valueOpen_E then
						--reverse the string to ensure the last value close tag is found
						local sReverse = string.reverse(sKVPRaw);
						--get the start and end points for the value close tag
						local n_valueClose_S, n_valueClose_E = string.find(sReverse, t_tags.Value.Close.String, 1);
							
							if n_valueClose_S and n_valueClose_E then
							--get the key
							local vKey = string.sub(sKVPRaw, nKeyOpen_E + 1, nKeyClose_S - 1);
							--get the value
							local vValue = string.sub(sKVPRaw, n_valueOpen_E + 1, string.len(sKVPRaw) - n_valueClose_E);
							--store the info to be returned
								
								-- the modified key (to be)
								local vModKey = "_PLACEHOLDER_KEY_";
								
								--set the key according to its type
								if sKeyType == "number" then
								vModKey = tonumber(vKey);
								elseif sKeyType == "string" then
								vModKey = tostring(vKey);
								end
							
								--the modified value (to be)
								local vModValue = "_PLACEHOLDER_VALUE_"
								
								--set the value according to its type
								if sValueType == "boolean" then
									
									if vValue == "true" then
									vModValue = true;
									
									elseif vValue == "false" then
									vModValue = false;
									
									end
								
								elseif sValueType == "nil" then
								vModValue = nil;
								
								elseif sValueType == "number" then
								vModValue = tonumber(vValue);
								
								elseif sValueType == "string" then
								vModValue = tostring(vValue);
								
								elseif sValueType == "table" then
								vModValue = util.StringToTable(vValue, n_count);
								
								end								
								
								--set the table item
								t_ret[vModKey] = vModValue;
								
							--mark the start of the next search (and the end of this one)
							nSearch_E = nMyEnd - 1;
							bContinue = true;
							end
							
						end
						
					end
					
				end
				
			end
		
		end
	
	end

return t_ret
end