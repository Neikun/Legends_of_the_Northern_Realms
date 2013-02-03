-- WARRIOR SKILL TOMES
cloneObject {
   name = "tome_athletics",
   baseObject = "tome_health",
   uiName = "Tome of Might",
   gameEffect = "Gain Athletics +3 and Strength +1",
   description = "Written by forgotten instructors from an ancient era, this book describes how to advance one's might and muscle through progressively more difficult excercises.",
   skill = "athletics",
   requiredLevel = 5,
   onUseItem = function(self,champion)
              champion:trainSkill("athletics", 3, true)
            champion:modifyStatCapacity("strength", 1)
            champion:modifyStat("strength", 1)
              playSound("level_up")
              return true 
         end
}

cloneObject {
   name = "tome_armors",
   baseObject = "tome_health",
   uiName = "Manual of Deflection",
   gameEffect = "Gain Armors +3 and Protection +1",
   description = "This valuable training manual gives the reader insights on how subtle changes in movement can help armor more effectively turn aside incoming blows.",
   skill = "armors",
   requiredLevel = 5,
   onUseItem = function(self,champion)
              champion:trainSkill("armors", 3, true)
            champion:modifyStatCapacity("protection", 1)
            champion:modifyStat("protection", 1)
              playSound("level_up")
              return true 
         end
}

cloneObject {
   name = "tome_axes",
   baseObject = "tome_health",
   uiName = "Tome of Hearty Hewing",
   gameEffect = "Gain Axes +4 and Health +5",
   description = "These appears to be the memoirs of a crazed axe-wielding warrior whose bloody recounts reveal surprisingly deadly methods of chopping at things well into one's golden years.",
   skill = "axes",
   requiredLevel = 5,
   onUseItem = function(self,champion)
              champion:trainSkill("axes", 4, true)
            champion:modifyStatCapacity("health", 5)
            champion:modifyStat("health", 5)
              playSound("level_up")
              return true 
         end
}

cloneObject {
   name = "tome_maces",
   baseObject = "tome_health",
   uiName = "Codex of Relentless Pummeling",
   gameEffect = "Gain Maces +5",
   description = "The dented metal covers of this ancient codex on hammering indicate its previous owner was a hard hitter.",
   skill = "maces",
   requiredLevel = 5,
   onUseItem = function(self,champion)
              champion:trainSkill("maces", 5, true)
              playSound("level_up")
              return true 
         end
}

cloneObject {
   name = "tome_swords",
   baseObject = "tome_health",
   uiName = "Tome of Swordsmanship",
   gameEffect = "Gain Swords +3 and Energy +10",
   description = "Written by a hedge knight claiming to have won every melee in every tournament he's ever entered, through mastery of his favored weapon and the stamina to keep swinging it.",
   skill = "swords",
   requiredLevel = 5,
   onUseItem = function(self,champion)
              champion:trainSkill("swords", 3, true)
            champion:modifyStatCapacity("energy", 10)
            champion:modifyStat("energy", 10)
              playSound("level_up")
              return true 
         end
}


-- MAGE SKILL TOMES

cloneObject {
   name = "tome_air",
   baseObject = "tome_health",
   uiName = "Tome of Air",
   gameEffect = "Gain Air Magic +4 and Resist Shock +5",
   description = "At first glance a simple-looking book on the subject of weather. But when opened, its pages rustle like leaves in the wind.",
   skill = "spellcraft",
   requiredLevel = 5,
   onUseItem = function(self,champion)
              champion:trainSkill("air_magic", 4, true)
            champion:modifyStatCapacity("resist_shock", 5)
            champion:modifyStat("resist_shock", 5)
              playSound("level_up")
              return true 
         end
}

cloneObject {
   name = "tome_earth",
   baseObject = "tome_health",
   uiName = "Tome of Earth",
   gameEffect = "Gain Resist Poison +15 and Earth Magic +2",
   description = "This dusty book contains the pooled knowledge of a secretive sect of arachnophobic druids.",
   skill = "spellcraft",
   requiredLevel = 5,
   onUseItem = function(self,champion)
              champion:trainSkill("earth_magic", 2, true)
            champion:modifyStatCapacity("resist_poison", 15)
            champion:modifyStat("resist_poison", 15)
              playSound("level_up")
              return true 
         end
}

cloneObject {
   name = "tome_ice",
   baseObject = "tome_health",
   uiName = "Grimoire of Endless Winter",
   gameEffect = "Gain Ice Magic +5",
   description = "Engraved with ice-blue runes that glow with power, this ancient codex's chilling texts are rife with the arcane theories of the cold-hearted Frost Lords.",
   skill = "spellcraft",
   requiredLevel = 5,
   onUseItem = function(self,champion)
              champion:trainSkill("ice_magic", 5, true)
              playSound("level_up")
              return true 
         end
}

cloneObject {
   name = "tome_spellcraft",
   baseObject = "tome_health",
   uiName = "Manual of Battle Mages",
   gameEffect = "Gain SpellCraft +4 and Energy +5",
   description = "A guide to the practical practitioner on how to have a lasting magical presence on the battlefield.",
   skill = "spellcraft",
   requiredLevel = 5,
   onUseItem = function(self,champion)
              champion:trainSkill("spellcraft", 4, true)
            champion:modifyStatCapacity("energy", 5)
            champion:modifyStat("energy", 5)
              playSound("level_up")
              return true 
         end
}

cloneObject {
   name = "tome_staff_defense",
   baseObject = "tome_health",
   uiName = "Tome of Sticks",
   gameEffect = "Gain Staff Defense +3 and Evasion +2",
   description = "A book on revolutionary methods of staff fighting. It is written in short but effective sets of easy to understand instructions.",
   skill = "staves",
   requiredLevel = 2,
   onUseItem = function(self,champion)
              champion:trainSkill("staves", 3, true)
            champion:modifyStatCapacity("evasion", 2)
            champion:modifyStat("evasion", 2)
              playSound("level_up")
              return true 
         end
}

-- ROGUE SKILL TOMES
cloneObject {
   name = "tome_assassination",
   baseObject = "tome_health",
   uiName = "Tome of Merciless Murder",
   gameEffect = "Gain Assassination +5",
   description = "The blood-red cover of the book is adorned with a grinning silver skull. Its pages are filled with murderous instructions, ideal for the cold-hearted killer.",
   skill = "assassination",
   requiredLevel = 5,
   onUseItem = function(self,champion)
              champion:trainSkill("assassination", 5, true)
              playSound("level_up")
              return true 
         end
}

cloneObject {
   name = "tome_daggers",
   baseObject = "tome_health",
   uiName = "Booklet of Shanking",
   gameEffect = "Gain Daggers +3 and Energy +10",
   description = "A short but practical instruction booklet, written by a convicted criminal, on how to maximize damage by sticking short, sharp objects into the opposing guys.",
   skill = "daggers",
   requiredLevel = 3,
   onUseItem = function(self,champion)
              champion:trainSkill("daggers", 3, true)
            champion:modifyStatCapacity("energy", 10)
            champion:modifyStat("energy", 10)
              playSound("level_up")
              return true 
         end
}

cloneObject {
   name = "tome_dodge",
   baseObject = "tome_health",
   uiName = "Tome of Avoidance",
   gameEffect = "Gain Dodge +3 and Dexterity +1",
   description = "A riveting tale of skullduggery about a scoundrel with a knack for getting into trouble and a gift for emerging unscathed.",
   skill = "dodge",
   requiredLevel = 5,
   onUseItem = function(self,champion)
              champion:trainSkill("dodge", 3, true)
            champion:modifyStatCapacity("dexterity", 1)
            champion:modifyStat("dexterity", 1)
              playSound("level_up")
              return true 
         end
}

cloneObject {
   name = "tome_missile_weapons",
   baseObject = "tome_health",
   uiName = "Manual of Archery",
   gameEffect = "Gain Missile Weapons +4 and Energy +5",
   description = "The chief instructor of the Royal Marksmen demands perfection of his pupils even at the very end of a grueling training session. This training manuel describes how he accomplishes just that.",
   skill = "missile_weapons",
   requiredLevel = 5,
   onUseItem = function(self,champion)
              champion:trainSkill("missile_weapons", 3, true)
            champion:modifyStatCapacity("energy", 5)
            champion:modifyStat("energy", 5)
              playSound("level_up")
              return true 
         end
}

cloneObject {
   name = "tome_throwing_weapons",
   baseObject = "tome_health",
   uiName = "Tome of Hurling",
   gameEffect = "Gain Throwing Weapons +3 and Strength +1",
   description = "And old, plain-looking book whose moldy pages give expert opinion on how to build the strength and momentum necessary for tossing objects at distant targets.",
   skill = "throwing_weapons",
   requiredLevel = 5,
   onUseItem = function(self,champion)
              champion:trainSkill("throwing_weapons", 3, true)
            champion:modifyStatCapacity("strength", 1)
            champion:modifyStat("strength", 1)
              playSound("level_up")
              return true 
         end
}

-- COMMON SKILL TOMES
cloneObject {
   name = "tome_unarmed_combat",
   baseObject = "tome_health",
   uiName = "Tome of Brawling",
   gameEffect = "Gain Unarmed Combat +3 and Evasion +2",
   description = "This tome describes training methods capable of turning a man's very limbs into weapons.",
   skill = "unarmed_combat",
   requiredLevel = 5,
   onUseItem = function(self,champion)
              champion:trainSkill("unarmed_combat", 3, true)
            champion:modifyStatCapacity("evasion", 2)
            champion:modifyStat("evasion", 2)
              playSound("level_up")
              return true 
         end
}

-- MISCELLANEOUS TOMES
cloneObject {
   name = "tome_strength",
   baseObject = "tome_health",
   uiName = "Tome of Bodybuilding",
   gameEffect = "Gain Strength +2 and Health +5",
   description = "You groan at the unnatural weight of this book, which describes how a group of men trained to build the strength and size needed to catch the eye of the famed sculptor from the Isle of Volcanoes.",
   weight = 10,
   onUseItem = function(self,champion)
            champion:modifyStatCapacity("strength", 2)
            champion:modifyStat("strength", 2)
            champion:modifyStatCapacity("health", 5)
            champion:modifyStat("health", 5)
              playSound("level_up")
              return true 
         end
}

cloneObject {
   name = "tome_dexterity",
   baseObject = "tome_health",
   uiName = "Tome of Agility",
   gameEffect = "Gain Dexterity +2 and Evasion +1",
   description = "The secret texts of this tome relays to the user how a ninja understands that true invisibility is a question of patience and agility.",
   onUseItem = function(self,champion)
            champion:modifyStatCapacity("dexterity", 2)
            champion:modifyStat("dexterity", 2)
            champion:modifyStatCapacity("evasion", 1)
            champion:modifyStat("evasion", 1)
              playSound("level_up")
              return true 
         end
}

cloneObject {
   name = "tome_vitality",
   baseObject = "tome_health",
   uiName = "Chronicle of Hardiness",
   gameEffect = "Gain Vitality +2 and Resist Poison +5",
   description = "Written by a man whose name bears an odd resemblance to a toxic beverage, this book's pages detail how men of the enigmatic tribes of the south have learned to run for days without tiring.",
   onUseItem = function(self,champion)
            champion:modifyStatCapacity("vitality", 2)
            champion:modifyStat("vitality", 2)
            champion:modifyStatCapacity("resist_poison", 5)
            champion:modifyStat("resist_poison", 5)
              playSound("level_up")
              return true 
         end
}

cloneObject {
   name = "tome_willpower",
   baseObject = "tome_health",
   uiName = "Almanac of Defiance",
   gameEffect = "Gain Willpower +2 and Energy +5",
   description = "This book reveals the closely-guarded secrets of an order of monks infamous for their aggravating stubbornness.",
   onUseItem = function(self,champion)
              champion:modifyStatCapacity("willpower", 2)
            champion:modifyStat("willpower", 2)
            champion:modifyStatCapacity("energy", 5)
            champion:modifyStat("energy", 5)
              playSound("level_up")
              return true 
         end
}

cloneObject {
   name = "tome_experience",
   baseObject = "tome_health",
   uiName = "Tome of Learning",
   gameEffect = "Gain Experience +2500",
   description = "Shuffling through the pages of this thick book takes you through exciting places and situations. The phenomenal writing makes you actually feel like you were actually there...",
   onUseItem = function(self,champion)
              champion:gainExp(2500)
              playSound("level_up")
              return true 
         end
}

cloneObject {
   name = "tome_protection",
   baseObject = "tome_health",
   uiName = "Tome of Defense",
   gameEffect = "Gain Protection +2 and Health +5",
   description = "A wonderfully illustrated book, revealing the secrets of Grandmaster Xonas, whose impressive feats include taking hammer blows to his gut without flinching.",
   onUseItem = function(self,champion)
              champion:modifyStatCapacity("protection", 2)
            champion:modifyStat("protection", 2)
            champion:modifyStatCapacity("health", 5)
            champion:modifyStat("health", 5)
              playSound("level_up")
              return true 
         end
}

cloneObject {
   name = "tome_energy",
   baseObject = "tome_health",
   uiName = "Manual of Energy",
   gameEffect = "Gain Energy +25",
   description = "Clearly written by a sadist, this manual provides various rigorous excercise routines capable of tremendously boosting your stamina.",
   onUseItem = function(self,champion)
              champion:modifyStatCapacity("energy", 25)
            champion:modifyStat("energy", 25)
              playSound("level_up")
              return true 
         end
}

cloneObject {
   name = "tome_resist",
   baseObject = "tome_health",
   uiName = "Tome of Adaptability",
   gameEffect = "Gain Resist Cold +5, Resist Fire +5, Resist Poison +5 and Resist Shock +5",
   description = "This journal, kept by the renowned explorer Ygvirr, tells how the human body is capable of adapting to the harshest environments.",
   onUseItem = function(self,champion)
              champion:modifyStatCapacity("resist_cold", 5)
            champion:modifyStat("resist_cold", 5)
              champion:modifyStatCapacity("resist_fire", 5)
            champion:modifyStat("resist_fire", 5)
              champion:modifyStatCapacity("resist_poison", 5)
            champion:modifyStat("resist_poison", 5)
              champion:modifyStatCapacity("resist_shock", 5)
            champion:modifyStat("resist_shock", 5)
              playSound("level_up")
              return true 
         end
}

cloneObject {
   name = "tome_evasion",
   baseObject = "tome_health",
   uiName = "Tome of Reflexes",
   gameEffect = "Gain Evasion +5",
   description = "This volume is written by a frustrated scholar who wanted to write the biography of the elusive princess Arinna. Despite years of effort, he never managed to even speak with the princess. The myriad methods by which Arinna avoided the scholar are highly inspirational, however.",
   onUseItem = function(self,champion)
              champion:modifyStatCapacity("evasion", 5)
            champion:modifyStat("evasion", 5)
              playSound("level_up")
              return true 
         end
}
