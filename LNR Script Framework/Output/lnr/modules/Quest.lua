LoadModule("Quest",[[
tQuest = {
	Conditions = {
		Fail = {},
		Success = {},
	},
	Quests = {},
};

tQuestBaseAttributes = {
	Conditions = {
		Fail = 0,
		Success = {},
	},
	Rewards = {
		Exp = 0,
		Loot = {},
		Stats = {
			 "health" = 0,
			 "energy" = 0,
			 "strength" = 0,
			 "dexterity" = 0,
			 "vitality" = 0,
			 "willpower" = 0,
			 "protection" = 0,
			 "evasion" = 0,
			 "resist_fire" = 0,
			 "resist_cold" = 0,
			 "resist_poison" = 0,
			 "resist_shock" = 0,
		},
		Traits = {
			"aggressive" = {Add=false,Remove=false},
			"agile" = {Add=false,Remove=false},
			"athletic" = {Add=false,Remove=false},
			"aura" = {Add=false,Remove=false},
			"cold_resistant" = {Add=false,Remove=false},
			"evasive" = {Add=false,Remove=false},
			"fire_resistant" = {Add=false,Remove=false},
			"fist_fighter" = {Add=false,Remove=false},
			"head_hunter" = {Add=false,Remove=false},
			"healthy" = {Add=false,Remove=false},
			"lightning_speed" = {Add=false,Remove=false},
			"natural_armor" = {Add=false,Remove=false},
			"poison_resistant" = {Add=false,Remove=false},
			"skilled" = {Add=false,Remove=false},
			"strong_mind" = {Add=false,Remove=false},
			"tough" = {Add=false,Remove=false},
		},
	},
};

function Exists(sQuest)
sQuest = string.lower(sQuest);
	
	if tQuest.Quests[sQuest] then
	
	end
	
end


--consider making this multiple functions for ease of use.
function Create(sQuest, tConditions, nExp, tLoot, tStats, tTraits)
sQuest = string.lower(sQuest);
	
	if type(sQuest) == "string" then
	
		if string.gsub(sQuest, " ", "") ~= "" then
			
			if not tQuest.Quests[sQuest] then
			tQuest.Quests[sQuest] = {};
		
				--give the quest all of the base attribtues that every quest has
				for sIndex, vItem in pairs(tQuestBaseAttributes) do
				tQuest.Quests[sQuest][sIndex] = vItem;
				end
				
			
			
			end
			
		true
		end
		
	end

return false
end

function MarkComplete(bComplete, bSuccess)
sQuest = string.lower(sQuest);

end

--type, target, check
function CreateCondition(sType, )


end
]]);