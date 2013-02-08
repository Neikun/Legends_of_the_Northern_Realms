-- This file has been generated by Dungeon Editor 1.3.7

--- level 1 ---

mapName("Unnamed")
setWallSet("dungeon")
playStream("assets/samples/music/dungeon_ambient.ogg")
mapDesc([[
################################
################################
################################
################################
################################
################################
################################
################################
################################
################################
################################
################################
################.###############
################.###############
##############...###############
##############......############
##############......############
##############....##############
################################
################################
################################
################################
################################
################################
################################
################################
################################
################################
################################
################################
################################
################################
]])
spawn("starting_location", 15,14,2, "starting_location")
spawn("torch_holder", 15,14,0, "torch_holder_1")
	:addTorch()
spawn("script_entity", 2,0,0, "gw_debug")
	:setSource("-- this is just a placeholder for debugging purposes.\
-- When debugging a script entity you can rename this script entity for example to gw and copy paste \
-- the script entity part from mod_assets/grimwidgets/gw.lua here. \
-- so the framwork will not load the script from that lua file.\
-- Same works with any dynamically loaded script entities.\
-- Problem with the dynamically loaded script enetites is that you can't see any errors in editor they might cause\
-- so you have to copy paste them to dungeon for debugging.\
\
\
")
spawn("script_entity", 12,15,3, "debug")
	:setSource("\
-- draws size*size grid and shows mouse coordinates in upper left corner\
-- you can enable it by calling debug.grid(100), disable: debug.grid() \
-- currently works only in fullscreen mode because of g.width g.height bug\
\
function grid(size)\
\9if not size then\
\9\9gw.removeElement('grid')\
\9\9return\
\9end\
\9size = size or 100\
\9local grid = {}\
\9grid.id = 'grid'\
\9grid.size = size\
\9grid.draw = function(self,g)\
\9\9local h = math.ceil(g.height/self.size)\
\9\9local w = math.ceil(g.width/self.size)\
\9\9for x = 0,w do\
\9\9\9g.drawRect(x*self.size,0,1,g.height)\
\9\9end\
\9\9for y = 0,h do\
\9\9\9g.drawRect(0,y*self.size,g.width,1)\
\9\9end\9\9\
\9\9g.drawText('x: '..g.mouseX..', y:'..g.mouseY,20,20)\
\9\9g.drawText('g.width - '..g.width - g.mouseX..', g.height - '..g.height - g.mouseY,20,40)\
\9end\
\9gw.addElement(grid)\
end\
\
function debugGrid()\
\9grid(100)\
end\
\
function disableGrid()\
\9grid()\
end")
spawn("dungeon_wall_text", 14,15,3, "dungeon_wall_text_1")
	:setWallText("Enable mouse grid")
spawn("gw_event", 16,12,2, "wounded_dwarf")
	:setSource("-- is this event enabled?\
--enabled = true\
\
-- name of the imeage to show\
image = \"mod_assets/images/example-image.dds\"\
image_width = 177\
image_hieght = 180\
\
\
-- Defines states. Each entry must have exactly two columns:\
-- first is state, the second is description shown.\
-- Event will start from the first state on the list.\
-- There is also one special state called \"end\". Once moved\
-- to state \"end\", the whole event ends.\
\
states = {\
  { \"init\",     \"An injured dwarf lies on the ground before\\nyou, nearly unconscious from his wounds.\" }, \
  { \"fainting\", \"The dwarf gasps out, \\\"Drow... save the\\nking... Prince is gone\\\". He falls unconscious.\" },\
  { \"fainted\",  \"And injured dwarf lies on the ground\\nbefore you. He is unconscious.\" },\
  { \"healed\",   \"Having regained his strength, the dwarf\\nthanks you \\\"I thought I had met my death\\n\" ..\
                \"at the blade of that drow. In battle our\\nking was grievously wounded, and the\\n\" ..\
                \"young prince kidnapped. I tried to stop\\nthe drow, but alas, I was overcome.\\n\\n\" ..\
                \"\\\"You have saved me from death! I wish\\nthere was some way to thank you, but \" ..\
                \"I have nothing. I am alone,\\nseparate from my people during the battle. May I \" ..\
                \"join you,\\nso that together we can search for my people?\" },\
  { \"join\",     \"As Taghor joins your party he says,\\n\\\"During the battle, I chased my enemy up\\n\" ..\
                \"a staircase, to this level. My people should\\nbe on the level just below us.\\\"\" },\
  { \"nojoin\",   \"I thank you, but I will find my own way\\nback. A warning: beware the stone\\ndoorways \" ..\
                \"set into these walls. They are\\nportal entrances, which become active with\\nthe \"..\
                \"right key. My party encamped near\\nsuch a portal, and was easily ambushed.\\\"\\n\" ..\
                \"Thanking you again, the dwarf wanders off.\"}\
}\
\
function onFaint()\
\9hudPrint(\"Taghor faints\")\
\9-- return \"nojoin\"\
end\
\
-- defines possible actions in each state. Each entry has\
-- 4 values. First is a state in which you can take that action. \
-- Second is a state name to which player will transition if that\
-- action is taken. Third is a text printed on the action button.\
-- Fourth defines function callback. It is optional. This function\
-- may not return anything and the state specified in value 2 will \
-- be used. The function may also return a name of the state, thus\
-- overriding default transition. One of the transitions must\
-- transit to \"end\" state (a dummy state that concludes the whole\
-- event).\
actions = {\
  { \"init\",      \"healed\",   \"Tend his wounds\"},\
  { \"init\",      \"fainting\", \"Talk\", onFaint },\
  { \"init\",      \"abort\",    \"Leave\" },\
  { \"fainting\",  \"fainted\",  \"Continue\"},\
  { \"fainted\",   \"healed\",   \"Tend his wounds\"},\
  { \"fainted\",   \"abort\",    \"Leave\" },\
  { \"healed\",    \"join\",     \"Yes\" },\
  { \"healed\",    \"nojoin\",   \"No\" },\
  { \"join\",      \"end\",      \"Continue\", onJoin},\
  { \"nojoin\",    \"end\",      \"Continue\", onNojoin}\
}\
\
")
spawn("script_entity", 29,31,2, "spell_book")
	:setSource("-- For testing/developement purposes\
-- I hope that this case is complex enough to show the possible flaws on grimwigets.\
\
spells = {}\
\
function getRuneImage(runeChar)\
\9local runeMap = {\
\9\9A='rune1_fire',\
\9\9B='rune2_death',\
\9\9C='rune3_air',\
\9\9D='rune4_spirituality',\
\9\9E='rune5_balance',\
\9\9F='rune6_physicality',\
\9\9G='rune7_earth',\
\9\9H='rune8_life',\
\9\9I='rune9_water'\
\9}\
\
\9return 'mod_assets/textures/'..runeMap[runeChar]..'.tga'\
end\
\
function getRunePosition(runeChar)\
\9local  positions = {\
\9\9A = {1,1},\
\9\9B = {2,1},\
\9\9C = {3,1},\
\9\9D = {1,2},\
\9\9E = {2,2},\
\9\9F = {3,2},\
\9\9G = {1,3},\
\9\9H = {2,3},\
\9\9I = {3,3}\9\9\9\9\9\9\
\9}\
\9return positions[runeChar]\
end\
\
function setSpells(pspells)\
\9spells = {}\
\9i = 1\
\9for spellName,def in pairs(pspells) do\
\9\9table.insert(spells,i,def)\
\9\9i = i + 1\
\9end\
end\
\
function createSpellBook()\
\9local book = gw_image.create('spell_book',20,20,900,800,'mod_assets/textures/book_900.tga')\
\9book.onDraw = function(self,ctx,champion) \
\9\9if champion and champion:getClass() ~= 'Mage' then\
\9\9\9return false\
\9\9end\9\9\
\9end\
\9\
\9local page1 = book:addChild('element','page1',20,20,350,500)\
\9local page2 = book:addChild('element','page2',490,30,350,500)\
\9\
\9for _,spell in ipairs(spells) do\
\9\9addSpell(book,spell)\
\9end\
\9\
\9return book\
\
end\
\
function addSpell(book,spell)\
\9page1 = book:getChild('page1')\
\9\
\9local line = page1:addChild('element',spell.name,0,20,200,30)\
\9\
\9line.marginLeft = 20\
\
\9line:setRelativePosition('below_previous')\
\9local bmemorize = line:addChild('button',spell.name..'_memo',0,0,' ')\
\9bmemorize.width = 10\
\9bmemorize.color = {0,0,0,100}\
\9local text = line:addChild('text',spell.name..'_text',0,0,300,20,spell.uiname)\
\9text.marginLeft = 10\
\9text.textColor = {150,150,150,200}\
\9text:setRelativePosition('after_previous')\
\9\
\9text.onClick = _turnPage\
\9\
\9local page2 = book:getChild('page2')\
\9\
\9local spellDescr = page2:addChild('element','runes_'..spell.name,0,0,350,400)\
\9spellDescr:deactivate()\
\9text.spellDescr = spellDescr\
\9\
\9local runes = spellDescr:addChild('element','runes_'..spell.name,0,0,240,240)\
\9runes:setRelativePosition{'top','center'}\
\9\
\9for _,runeChar in ipairs({'A','B','C','D','E','F','G','H','I'}) do\
\9\9\
\9\9local runeImg = runes:addChild('image','rune_'..runeChar,0,0,100,100,spell_book.getRuneImage(runeChar))\
\9\9local pos = spell_book.getRunePosition(runeChar)\
\9\9runeImg.x = pos[1] * 80 - 80\
\9\9runeImg.y = pos[2] * 80 - 80\
\9\9if not string.find(spell.runes,runeChar) then\
\9\9\9runeImg.color = {100,100,100,150}\
\9\9end\
\9end\9\9\
\9\
\9local spellText = spellDescr:addChild('text','spell_text_'..spell.name,0,250,350,200,spell.description)\
\9spellText.textColor = {150,150,150,200}\
\9spellText.textSize = 'medium'\
\
\9\
end\
\
function _turnPage(self)\
\9for i, elem in ipairs(self:getAncestor():getChild('page2').children) do\
\9\9elem:deactivate()\
\9end\
\9self.spellDescr:activate()\
end\
\
\
function autoexec()\
\9-- testing\
\9local testDescription = [[This is a testing spell definition.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin iaculis pretium velit,\
commodo molestie augue adipiscing ac. In hac habitasse platea dictumst.\
Maecenas massa diam, accumsan sed mattis in, volutpat non elit. Maecenas ut ullamcorper nisi.]]\
\9\
\9setSpells{\
\9\9{name='fireburst',uiname='Fireburst',runes='A',description='Caster creates a quick burst of fire in front of him'},\
\9\9{name='ice_shards',uiname='Ice Shards',runes='GI',description='Caster shoots a flurry of ice shards in front of him'},\
\9\9{name='all_runes',uiname='test runes',runes='ABCDEFGHI',description=testDescription}\
\9}\
\9\
\9\9\
\9local book = spell_book.createSpellBook()\
\9gw.addElement(book,'skills')\
end\
")
spawn("script_entity", 28,31,2, "compass")
	:setSource("-- This example draws a compass as a GUI element. Depending on which\
-- activation mode is chosen, it can be visible all time, toggled\
-- with 'c' key or shown only when 'c' is pressed.\
\
-- draws actual compass\
-- this function is called when compass is visible all time\
function drawCompass(self, g)\
\9local x = 10\
\9local y = g.height - 200\
\9\
\9local dir = string.sub(\"NESW\", party.facing + 1, party.facing + 1)\
\9g.drawImage(\"mod_assets/textures/compass_full_\"..dir..\".tga\", x, y)\
end\
\
-- this is a simple wrapper function that is called as key press\
-- hook. It calls drawCompass function.\
function callback(g)\
\9drawCompass(self, g)\
end\
\
function autoexec()\
\9local e = {}\
\9e.id = 'compass'\
\9e.draw = drawCompass\
\9e.callback = callback\
\9\
\9-- uncomment this to enabled/disable compass by pressing C\
\9gw.setKeyHook('c', true, e.callback)\
\9\
\9-- Uncomment this to show compass by pressing C\
\9-- gw.setKeyHook('c', false, e.callback)\
\9\
\9-- Uncomment this to have compass permanently visible\
\9-- gw.addElement(e,'gui')\
end")
spawn("wall_button", 14,16,3, "wall_button_2")
	:addConnector("toggle", "gui_demo", "drawExample")
spawn("script_entity", 12,16,2, "gui_demo")
	:setSource("-- This function showcases how gwElements may be stacked together\
function drawExample()\
\
\9gw.setDefaultColor({200,200,200,255})\
\9gw.setDefaultTextColor({255,255,255,255})\
\
\9-- background yellow image\
\9local rect1 = gw_rectangle.create('rect1', 100, 50, 600, 350)\
\9rect1.color = {255, 255, 0}\
\9gw.addElement(rect1, 'gui')\
\9\
\9-- Example of image within \
\9local img1 = gw_image.create('image1', 0, 0, 177, 190, 'mod_assets/images/example-image.dds')\
\9rect1:addChild(img1)\
\9img1:setRelativePosition({'right','bottom'})\
\9\
\9local button1 = gw_button3D.create('button1', 70, 10, \"3D-ABCDEFGHIJKLMNOPQRSTUVWXYZ\")\
\9button1.textColor = {200,100,0}\
\9\
\9button1.onClick = function(self) print(self.id..' clicked') end\
\9rect1:addChild(button1)\
\9button1:setRelativePosition({'left','bottom'})\
\9\
\9local button2 = gw_button.create('button2', 70, 40, \"abcdefghijklmnopqrstuvwxyz\")\
\9button2.onPress = function(self) print(self.id..' clicked') end\
\9rect1:addChild(button2)\
\
\9\
\9local button3 = gw_button.create('button3', 70, 70, \"1234567890\")\9\
\9button3.color = button1.color\
\9button3.onPress = function(self) print(self.id..' clicked') end\
\9rect1:addChild(button3)\
\9\9\
\
\9-- Create directly to parent example\
\9local button4 = rect1:addChild('button','button4', 70, 100, \"!@#$%^&*()-,.'\")\
\9button4.color = button1.color\
\9button4.onPress = function(self) print(self.id..' clicked') end\
\
\9local button5 = rect1:addChild('button','button5', 70, 100, \"After element position\")\
\9button5.color = button1.color\
\9button5:setRelativePosition({'after','button4'})\
\9button5.marginLeft = 10\
\9\
\9local button6 = rect1:addChild('button','button6', 70, 100, \"Below element position\")\
\9button6:setRelativePosition{'below','button5'}\
\9button6.marginLeft = 10\
\9button6.marginTop = 15\
\9\
\9local button7 = rect1:addChild('button','button7', 70, 100, \"After button5\")\
\9button7.color = button1.color\
\9button7:setRelativePosition({'after','button5'})\
\9button7.marginLeft = 10\9\
\9\
\9rect2 = rect1:addChild('rectangle','rect2', 0, 0, 50, 50)\
\9rect2.color={0, 0, 255}\
\9rect2:setRelativePosition{'left','top'}\
\9\
\9local rect3 = rect2:addChild('rectangle','rect3', 0, 0, 30, 40) -- rect3 in rect2, which is in rect1\
\9rect3:setRelativePosition{'top','left'}\
\9rect3.marginTop = 5\
\9rect3.marginLeft = 10\
\9rect3.color = {255, 0, 0}\
\9rect3.onPress = function(self) \
\9\9print('rectangles can be clicked too')\
\9end\
\
\9local text1 = rect1:addChild('text','text1',0,0,200,180)\
\9text1:setRelativePosition{'bottom','center'}\
\9\
\9text1.text = \"Long text should be wrapped automatically. Does\\nit\\nwork? Some more words here for testing purposes\"\
\9text1.textColor = {0,255,255}\
\9\
\9local closeButton = rect1:addChild('button3D','close_rect_1',20,20,'X',30,20)\
\9closeButton.onPress = function(self)\
\9\9gw.removeElement('rect1')\
\9end\
\9closeButton:setRelativePosition({'top','right'})\
\9\
\9\
\9\
end\
")
spawn("dungeon_wall_text_long", 14,16,3, "dungeon_wall_text_long_1")
	:setWallText("Shows gwElements (several gui elements\
that are hierarchically organized)")
spawn("script_entity", 0,0,1, "logfw_init")
	:setSource("spawn(\"LoGFramework\", party.level,1,1,0,'fwInit')\
fwInit:open() \
function main()\
   fw.debug.enabled = false\
   fwInit:close()\
end")
spawn("dungeon_door_portcullis", 18,16,3, "dungeon_door_portcullis_1")
spawn("dungeon_door_portcullis", 18,15,3, "dungeon_door_portcullis_2")
spawn("snail", 19,15,0, "snail_1")
spawn("wall_button", 14,14,3, "wall_button_3")
	:addConnector("toggle", "new_champion", "newChampion")
spawn("dungeon_wall_text", 14,14,3, "dungeon_wall_text_2")
	:setWallText("Use this button to get someone new\
in your party! The more the merrier!")
spawn("script_entity", 12,14,2, "new_champion")
	:setSource("function newChampion()\
\9newguy = {\
\9\9name = \"Taghor\",    -- just a name\
\9\9race = \"Insectoid\", -- must be one of: Human, Minotaur, Lizardman, Insectoid\
\9\9class = \"Mage\",     -- must be one of: Figther, Rogue, Mage or Ranger\
\9\9sex = \"male\", \9\9-- must be one of: male, female\
\9\9level = 3,          -- character's level\
\9\9portrait = \"mod_assets/textures/portraits/taghor.dds\", -- must be 128x128 dds file\
\9\9\
\9\9-- allowed skills: air_magic, armors, assassination, athletics, axes, daggers, \
\9\9-- dodge, earth_magic, fire_magic, ice_magic, maces, missile_weapons, spellcraft,\
\9\9-- staves, swords, throwing_weapons and unarmed_combat\
\9\9skills = { fire_magic = 10, earth_magic = 20, air_magic = 30, ice_magic = 40 },\
\9\9\9\9\
\9\9-- allowed traits: aggressive, agile, athletic, aura, cold_resistant, evasive, \
\9\9-- fire_resistant, fist_fighter, head_hunter, healthy, lightning_speed,\
\9\9-- natural_armor, poison_resistant, skilled, strong_mind, tough\
\9\9-- Traits must be specified in quotes.\
\9\9-- Typically each character has 2 traits, but you can specify more or less.\
\9\9traits = { \"lightning_speed\", \"tough\", \"skilled\", \"head_hunter\", \"aura\" },\
\9\9\
\9\9health = 80, \9\9  -- Maximum health\
\9\9current_health = 70,  -- Current health\
\9\9\
\9\9energy = 300,         -- Maximum energy\
\9\9current_energy = 250, -- Current energy\
\
\9\9strength = 12,        -- Strength\
\9\9dexterity = 11,       -- Dexterity\
\9\9vitality = 10,        -- Vitality\
\9\9willpower = 9,        -- Willpower\
\9\9\
\9\9protection = 25,      -- protection\
\9\9evasion = 30, \9\9  -- evasion\
\9\9\9\9\
\9\9-- Resist fire/cold/poison/shock (remember that those values will be modified by bonuses\
\9\9-- from fire, cold, poison or shock magic\
\9\9resist_fire = 11,\
\9\9resist_cold = 22,\
\9\9resist_poison = 33,\
\9\9resist_shock = 44,\
\9\9\
\9\9-- items: Notation item_name = slot. Slots numbering: 1 (head), 2 (torso), 3 (legs), 4 (feet), \
\9\9-- 5 (cloak), 6 (neck), 7 (left hand), 8 (right hand), 9 (gaunlets), 10 (bracers), 11-31 (backpack\
\9\9-- slots) or 0 (any empty slot in backpack)\
\9\9-- Make sure you put things in the right slot. Wrong slot (e.g. attempt to try boots on head)\
\9\9-- will make the item spawn to fail.\
\9\9items = { battle_axe = 0, lurker_hood = 1, lurker_vest = 2, lurker_pants = 3, lurker_boots = 4 },\
\9\9\
\9\9-- food: 0 (starving) to 1000 (just ate the whole cow)\
\9\9food = 100\
\9\9\
\9}\
\
\9-- Call addChampion method. It will add new guy to the party if there are suitable slots and will\
\9-- display a GUI prompt selecting a party member to drop if your party is already 4 guys\
\9gw_party.addChampion(newguy)\
end\
\
")
spawn("lightning_rod", 14,14,3, "lightning_rod_1")
spawn("sack", 14,14,2, "sack_1")
spawn("rock", 14,14,1, "rock_1")
spawn("rock", 14,14,0, "rock_2")
spawn("lever", 14,15,3, "lever_1")
	:addConnector("activate", "debug", "debugGrid")
	:addConnector("deactivate", "debug", "disableGrid")
spawn("script_entity", 14,19,2, "quickDialog_demo")
	:setSource("--\
-- Example of the Dialog.quickDialog() function\
-- \
-- It enables you to start a dialog with a close button by starting one function.\
-- Tip: use [[ and ]] to define a multiple-line-string.\
--\
\
function press()\
\9Dialog.quickDialog([[This is an example of the dialog system.\
\
Dialog code was written by Mahric for Legends\
of the Northern Realms mod. It is being merged\
with grimwidgets by Thomson. This is a work\
in progress.\
\
Features:\
 - Grimrock style interface\
 - Automatically resizing window and buttons\
 - Text appears on screen, as if being told\
 - Optional portrait of npc you talk to\
\
Check the wiki for more info how to use it,\
But first see if you can get out of here...]], clicked)\
end\
\
function clicked()\
\9hudPrint(\"Why did you close this awesome looking dialog?\")\
end")
spawn("wall_button", 14,17,2, "wall_button_1")
	:addConnector("toggle", "quickDialog_demo", "press")
spawn("wall_button", 15,17,2, "wall_button_4")
	:addConnector("toggle", "quickDialog_simple", "clickOgre")
spawn("script_entity", 15,19,1, "quickDialog_simple")
	:setSource("--\
-- Example on how to build your own dialog\
-- \
-- This example uses all features:\
--  * Shows portrait of the npc\
--  * Defines buttons with custom text\
--  * Uses a callback function to process the result\
--\
\
s_challenge = \"Right, make me!\"\
s_agree = \"I'm going already!\"\
\
function clickOgre()\
\9local s_npcId = \"\" -- \"npc_guard\"\
\9local s_text = [[Hey, you!\
\9\9\9\9\9What are you doing here? Why are you pressing\
\9\9\9\9\9this button?\
\
\9\9\9\9\9You're not supposed to be here.\
\9\9\9\9\9Leave while you can!]]\
\
\9local s_dlgId = Dialog.new(s_text, s_agree, nil) --s_npcId)\
\9Dialog.addButton(s_dlgId, s_challenge)\
\9Dialog.activate(s_dlgId, ogreCallBack)\
end\
\
function ogreCallBack(s_caption)\
\9if s_caption == s_challenge then\
\9\9hudPrint(\"Oh oh... Now you've done it!\")\
\9end\
\9if s_caption == s_agree then\
\9\9hudPrint(\"Party is full of chickens!\")\
\9end\
end")
spawn("wall_button", 16,17,2, "wall_button_5")
	:addConnector("toggle", "quickDialog_yesno", "yesNoQuestion")
spawn("script_entity", 16,19,1, "quickDialog_yesno")
	:setSource("--\
-- Example on how to build your own yes/now dialog\
-- \
\
s_challenge = \"Right, make me!\"\
s_agree = \"I'm going already!\"\
\
function yesNoQuestion()\
\9local s_text = [[Hey, you! Are you brave?]]\
\
\9local s_dlgId = Dialog.quickYesNoDialog(s_text, answerCallBack, nil)\
\9Dialog.activate(s_dlgId, answerCallback)\
end\
\
function answerCallBack(s_caption)\
\9if s_caption == \"Yes\" then\
\9\9hudPrint(\"Yeah, right...\")\
\9end\
\9if s_caption == \"No\" then\
\9\9hudPrint(\"Run for your life! There's killer snail after you\")\
\9end\
end")
spawn("wall_button", 17,17,2, "wall_button_6")
	:addConnector("toggle", "MergedDemo", "drawExample")
spawn("script_entity", 17,19,0, "MergedDemo")
	:setSource("function drawExample()\
\
\9gw.setDefaultColor({200,200,200,255})\
\9gw.setDefaultTextColor({255,255,255,255})\
\
\9-- background yellow image\
\9local rect1 = Dialog.create(-1, -1, 600, 150)\
\9rect1.dialog.text = \"This is a slow appearing text\"\
\9\
\9local img1 = gw_button3D.create('img', 10, 10, \"Awesome!\", 300, 40)\
\9rect1:addChild(img1)\
\9img1:setRelativePosition({'center','bottom'})\
\9img1.onClick = click\
\9\
\9gw.addElement(rect1, 'gui')\
end\
\
function click()\
\9gw.removeElement(\"Dialog\")\
end")
spawn("script_entity", 17,13,0, "gw_book_test")
	:setSource("function autoexec()\
\
\9fw.setHook('test_book_1.gw_book_testing.onUseItem',function()\
\9\9\9local book = gw_book.create('test_book_1')\
\9\9\9book.textColor = {100,100,100,210}\
\9\9\9book:addPageHeader(1,'This is the header of the 1st page.')\
\9\9\9\
\9\9\9\
\9\9\9book:addPageText(1,\
[[Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin iaculis pretium velit,\
commodo molestie augue adipiscing ac. In hac habitasse platea dictumst.Maecenas massa diam, accumsan sed mattis in, volutpat non elit. Maecenas ut ullamcorper nisi.]]\
)\
\9\9\
\9\9\9book:addPageHeader(1,'Another header')\
\9\9\9book:addPageText(1,\"And a bit more text. It is possible to add as many paragraphs and headers as you like.\\nNew lines should work too. Multiple new lines should work also\\n\\n\\n\\nas you can see\")\
\9\9\9\
\9\9\9book.textColor = {200,200,200,210}\
\9\9\9book:addPageHeader(2,'Different font color for this page.')\
\9\9\9book:addPageText(2,'Lets and an image here')\
\9\9\9book:addPageImage(2,'mod_assets/textures/compass_full_E.tga',200,200)\
\9\9\9book:addPageText(2,'and some text below it')\
\9\9\9local text = book:addPageText(2,\"It's possible to change the position of the text like this\")\
\9\9\9text.x = text.x + 40\
\9\9\9\
\9\9\9local col1 = book:addPageText(2,'Want multiple columns?')\
\9\9\9col1.width = 100\
\9\9\9col1:calculateHeight()\
\9\9\9local col2 =book:addPageText(2,'Here you go')\
\9\9\9col2:setRelativePosition('after_previous')\
\9\9\9col2.width = text.width - 100\
\9\9\9\
\9\9\9book:addPageText(3,'Another page')\
\9\9\9book:addPageText(4,'4th page')\
\9\9\9book:addPageText(5,'5th page')\
\9\9\9book:openPagePair(1)\
\9\9\9\
\9\9\9gw.addElement(book)\
\9\9\9return false\
\9\9end\
\9)\
\
end")
spawn("tome_wisdom", 15,14,2, "test_book_1")
