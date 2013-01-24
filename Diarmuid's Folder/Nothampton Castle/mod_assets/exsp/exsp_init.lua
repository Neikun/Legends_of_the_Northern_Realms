-- ***************************************************
--  Diarmuid's Extended Spells framework, Version 1.4
-- ***************************************************

-- IMPORT EXSP MODULES AND DEFAULT SPELLS
-- ==========================================

function exsp_loadSpell(name)
	import("mod_assets/exsp/spells/"..name..".lua")
end
import("mod_assets/exsp/modules/exsp.lua")
import("mod_assets/exsp/modules/extend.lua")
import("mod_assets/exsp/modules/exsp_monsters.lua")
exsp_loadSpell("exsp_default_log_spells")


-- LOAD CUSTOM SPELL PLUGINS HERE
-- ==============================

-- <<<< Grimwold's Magic Pack >>>>
exsp_loadSpell("exsp_grimwoldsMagicPack")

-- <<<< Wandering Lights >>>>
exsp_loadSpell("exsp_wandering_lights")

-- <<<< Diarmuid's Offensive Spells >>>>
exsp_loadSpell("exsp_chain_lightning")
exsp_loadSpell("exsp_elemental_storm")
exsp_loadSpell("exsp_flame_carpet")
exsp_loadSpell("exsp_energy_beam")

-- <<<< Diarmuid's Utility Spells >>>>
exsp_loadSpell("exsp_zo_spell")
exsp_loadSpell("exsp_reach_spell")
exsp_loadSpell("exsp_spell_shield")

-- <<<< Portal >>>>
exsp_loadSpell("exsp_portal")







