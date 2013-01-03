tUtil = {
	
	
};

--used in TableToString
tEscapeChars = {
	[1] = {
		Char = "\\",
		RelacementChar = "\\\\",
	},
	[2] = {
		Char = "\a",
		RelacementChar = "\\a",
	},
	[3] = {
		Char = "\b",
		RelacementChar = "\\b",
	},
	[4] = {
		Char = "\f",
		RelacementChar = "\\f",
	},
	[5] = {
		Char = "\r\n",
		RelacementChar = "\\r\\n",
	},
	[6] = {
		Char = "\t",
		RelacementChar = "\\t",
	},
	[7] = {
		Char = "\v",
		RelacementChar = "\\v",
	},
	[8] = {
		Char = "\"",
		RelacementChar = "\\\"",
		},
	[9] = {
		Char = "\'",
		RelacementChar = "\\'",
	},
	--This version is for use with
		 pure lua as oppossed to AMS lua.
	[10] = {
		Char = "%[",
		RelacementChar = "%%[",
		},
	[11] = {
		Char = "%]",
		RelacementChar = "%%]",
	},
	--[[
	[10] = {
		Char = "%[",
		RelacementChar = "\\[",
		},
	[11] = {
		Char = "%]",
		RelacementChar = "\\]",
		},]]
};


--[[
----------------------------------
Util.TableToString(table, integer)
Return Type: string
----------------------------------
The number(argument #2) tells
the function how many indents
we want from the start. This
is required but can be 0.
]]
function TableToString(tInput, nCount)
local sRet = "";

local sTab = "";

for x = 1, nCount do
sTab = sTab.."\t";
end

local sIndexTab = sTab.."\t";

nCount = nCount + 1;

	if type(tInput) == "table" then
	sRet = sRet.."{\r\n";
				
		for vIndex, vItem in pairs(tInput) do
		local sIndexType = type(vIndex);
		local sItemType = type(vItem);
		local sIndex = "";
				
			--write the index to string
			if sIndexType == "number" then
			sRet = sRet..sTab.."["..vIndex.."] = ";
					
			elseif sIndexType == "string" then
							
				if string.find(vIndex, '%W', 1) then
				sIndex = sIndexTab.."[\""..vIndex.."\"] = ";
				else
				local sEqual = " = ";
				
					if sItemType == "function" then
					sEqual = ""
					end
					
				sIndex = sIndexTab..vIndex..sEqual;
				end
			
			end
			
			--write the	item to string
			if sItemType == "number" then
			sRet = sRet..sIndex..vItem..",\r\n"
			
			elseif sItemType == "string" then
			
				for nIndex, tChar in pairs(tEscapeChars) do
				vItem = string.gsub(vItem, tChar.Char, tChar.RelacementChar);
				end
			
			sRet = sRet..sIndex.."\""..vItem.."\",\r\n";
			
			elseif sItemType == "boolean" then
			
				if vItem then
				sRet = sRet..sIndex.."true,\r\n";
				else
				sRet = sRet..sIndex.."false,\r\n";
				end
			
			elseif sItemType == "nil" then
			sRet = sRet..sIndex.."nil,\r\n"
			
			elseif sItemType == "function" then				
			--sRet = sRet..sIndex..",\r\n"; --Can't do this now, don't have access to the getfenv function
									
			elseif sItemType == "userdata" then
			--do the userdata stuff here...
			
			elseif sItemType == "table" then
			sRet = sRet..sIndex..table.tostring(vItem, nCount)..",\r\n";			
			
			end
			
		end
			
	end

sRet = sRet..sTab.."}"

return sRet
end