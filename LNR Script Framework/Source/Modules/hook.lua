t_hook = {};

function Add(sModule, sFunctionToHook, fHook, nPriority)
	
	if varIsValid({"string"}, sModule) and varIsValid({"string"}, sFunctionToHook) and varIsValid({"function"}, fHook) varIsValid({"number","nil"}, nPriority) then
		
		if string.gsub(sFunctionToHook, " ", "") ~= "" then
		
			if not t_hook[sModule] then
			t_hook[sModule] = {};
			end
				
			if not t_hook[sModule][sFunctionToHook] then
			
			end
			
		local nHooksInModule = #t_hook[sModule];
			
			if not nPriority then
			nPriority = nHooksInModule;
			end
			
			if nPriority > nHooksInModule then
			nPriority = nHooksInModule + 1;
			end
			
			table.insert(t_hook[sModule], nPriority, fHook);
		
		return true
		end
		
	end

return false
end

function Remove(sModule, fHook)

end

function GetList(sModule)

end

function GetAll()


end