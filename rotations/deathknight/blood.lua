-- ProbablyEngine Rotation Packager
-- Custom Blood Death Knight Rotation
-- Created on Dec 25th 2013 1:00 am
ProbablyEngine.rotation.register_custom(250, "bbBloodDeathKnight", {
-- PLAYER CONTROLLED: 
-- SUGGESTED TALENTS:
-- CONTROLS: Pause - Left Control, Death Grip Mouseover - Left Alt, Army of the Dead - Left Shift

-- COMBAT
	-- Rotation Utilities
	{ "pause", "modifier.lcontrol" },
	{ "pause", "@bbLib.bossMods" },
	{ "pause", { "toggle.pvpmode", "@bbLib.BGFlag" } },
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "!target.exists" } },
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "target.exists", "target.dead" } },
	
	-- BossMods
	{ "Dark Command", { "toggle.autotaunt", "@bbLib.bossTaunt" } },
	
	-- Racials
	{ "Stoneform", "player.health < 65" },
	{ "Every Man for Himself", "player.state.charm" },
	{ "Every Man for Himself", "player.state.fear" },
	{ "Every Man for Himself", "player.state.incapacitate" },
	{ "Every Man for Himself", "player.state.sleep" },
	{ "Every Man for Himself", "player.state.stun" },
	{ "Gift of the Naaru", "player.health < 70", "player" },
	{ "Escape Artist", "player.state.root" },
	{ "Escape Artist", "player.state.snare" },
	{ "Will of the Forsaken", "player.state.fear" },
	{ "Will of the Forsaken", "player.state.charm" },
	{ "Will of the Forsaken", "player.state.sleep" },

	-- Interrupts
	{ "Mind Freeze", "modifier.interrupts" },
	{ "Strangulate", "modifier.interrupts" },

	-- Buffs
	{ "Bone Shield", "!player.buff" },
	{ "Horn of Winter", "!player.buff(Horn of Winter).any" },
	
	-- Keybound Cooldowns
	{ "Army of the Dead", "modifier.lshift" },
	{ "Death Grip", { "modifier.lalt", "mouseover.threat < 100", "target.range > 10", "!target.boss" }, "mouseover" },
	-- Chains of Ice Mouseover
	-- Anti-Magic Zone Ground
	-- Raise Dead
	-- Plague Leech Talent
	-- Death's Advance
	-- Blood Presence
	
	-- Blood Tap
	{ "Blood Tap", { "player.buff(Blood Charge).count > 5", "player.runes(death).count < 2" } },
	
	-- Survival
	{ "Anti-Magic Shell", { "player.health <= 70", "target.casting" } },
	{ "Dancing Rune Weapon", "player.health <= 75" },
	{ "Conversion", "player.health <= 60" }, -- Nobody should ever use this talent, but just in case.
	{ "Vampiric Blood", "player.health <= 55" },
	{ "Icebound Fortitude", { "modifier.cooldowns", "player.health <= 50" } },
	{ "Rune Tap", "player.health <= 40" },
	{ "Empower Rune Weapon", { "modifier.cooldowns", "player.health <= 40" } },
	{ "/cast Raise Dead\n/cast Death Pact", { "modifier.cooldowns", "player.health < 35", "player.spell(Death Pact).cooldown", "player.spell(Raise Dead).cooldown", "player.spell(Death Pact).usable" } },

	-- Diseases
	{ "Outbreak", { "!target.debuff(Frost Fever)", "!target.debuff(Blood Plague)" } },
	{ "Blood Boil", { "player.runes(blood).count > 1","target.debuff(Frost Fever).duration < 3", "target.debuff(Blood Plague).duration <3", "target.range <= 10" } },
	{ "Blood Boil", { "player.runes(death).count > 1","target.debuff(Frost Fever).duration < 3", "target.debuff(Blood Plague).duration <3", "target.range <= 10" } },  
	{ "Icy Touch", "target.debuff(Frost Fever).duration < 3" },
	{ "Plague Strike", "target.debuff(Blood Plague).duration < 3" },
	
	-- Rotation
	{ "Heart Strike", { "modifier.multitarget", "player.runes(blood).count > 0", "modifier.enemies < 4" } },
	{ "Pestilence", { "modifier.multitarget", "target.debuff(Blood Plague)", "target.debuff(Frost Fever)", "modifier.timeout(Pestilence, 30)", "modifier.enemies > 2", "!player.spell(Roiling Blood).exists" } },
	{ "Blood Boil", { "modifier.multitarget", "target.range <= 10", "modifier.enemies > 3"  } },
	{ "Death and Decay", { "modifier.multitarget", "!player.moving", "!target.moving" }, "ground" },
	{ "Death Strike", "!modifier.last(Death Strike)" },
	{ "Soul Reaper", {"player.runes(blood).count > 0", "target.health < 35" } },
	{ "Heart Strike", "player.runes(blood).count > 0" },
	{ "Rune Strike", "player.runicpower > 40" },
	{ "Horn of Winter", "player.runicpower < 90" },
	{ "Death and Decay", { "player.buff(Crimson Scourge)", "!player.moving", "!target.moving" }, "ground" },
	{ "Blood Boil", { "player.buff(Crimson Scourge)", "target.range <= 10" } },
	
},{
-- OUT OF COMBAT ROTATION
	-- Buffs
	{ "Horn of Winter", "!player.buff(Horn of Winter).any" },
	{ "Path of Frost", "!player.buff(Path of Frost).any" },
	{ "Bone Shield", "!player.buff(Bone Shield)" },

	-- Keybound Cooldowns
	{ "Army of the Dead", "modifier.lshift" },
	{ "Death Grip", "modifier.lalt" },
},
function ()
	ProbablyEngine.toggle.create('mouseovers', 'Interface\\Icons\\inv_pet_lilsmoky', 'Toggle Mouseovers', 'Automatically cast spells on mouseover targets')
	ProbablyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'PvP', 'Toggle the usage of PvP abilities.')
	ProbablyEngine.toggle.create('limitaoe', 'Interface\\Icons\\spell_fire_flameshock', 'Limit AoE', 'Toggle to avoid using CC breaking aoe effects.')
	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
	ProbablyEngine.toggle.create('autotaunt', 'Interface\\Icons\\spell_nature_reincarnation', 'Auto Taunt', 'Automaticaly taunt the boss at the appropriate stacks')
end)
