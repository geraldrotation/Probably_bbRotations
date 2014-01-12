-- ProbablyEngine Rotation Packager
-- Custom Protection Paladin Rotation
-- Created on Dec 25th 2013 1:00 am
ProbablyEngine.rotation.register_custom(66, "bbProtectionPaladin", {
-- PLAYER CONTROLLED: Guardian of Ancient Kings, Divine Protection, Divine Shield, Devotion Aura, Light's Hammer (T6)
-- SUGGESTED TALENTS:
-- CONTROLS: Pause - Left Control, Light's Hammer - Left Alt

-- COMBAT
	-- Rotation Utilities
	{ "pause", "modifier.lcontrol" },
	{ "pause", "@bbLib.bossMods" },
	{ "pause", { "toggle.pvpmode", "@bbLib.BGFlag" } },
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "!target.exists" } },
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "target.exists", "target.dead" } },
	
	-- Racials
	{ "Stoneform", "player.health <= 65" },
	{ "Every Man for Himself", "player.state.charm" },
	{ "Every Man for Himself", "player.state.fear" },
	{ "Every Man for Himself", "player.state.incapacitate" },
	{ "Every Man for Himself", "player.state.sleep" },
	{ "Every Man for Himself", "player.state.stun" },
  
	-- OFF GCD
	{ "Word of Glory", {"player.health < 60", "player.holypower > 4" } },
	{ "Word of Glory", {"player.health < 30", "player.holypower > 1" } },
	{ "Shield of the Righteous", "player.holypower > 4" },
	{ "Shield of the Righteous", "player.buff(Divine Purpose)" },
  
	-- Seals
	{ "Seal of Insight", "player.seal != 3" },

	-- Interrupts
	{ "Avenger's Shield", "modifier.interrupts" }, 
	{ "Rebuke", "modifier.interrupts" }, --TODO: Interrupt at 50% cast
	
	-- Survivability
	{ "Hand of Freedom", { "!player.buff", "player.state.root" }, "player" },
	{ "Hand of Freedom", { "!player.buff", "player.state.snare" }, "player" },
	{ "Eternal Flame", "player.buff(Eternal Flame).duration < 3" }, -- T3
	{ "Sacred Shield", "player.buff(Sacred Shield).duration < 3" }, -- T3
	
	-- BossMods
	{ "Reckoning", { "@bbLib.bossTaunt", "toggle.autotaunt" }, "target" },
	{ "Hand of Sacrifice", { "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "mouseover.debuff(Assassin's Mark)" }, "mouseover" },
	
	-- Raid Survivability
	{ "Hand of Protection", { "lowest.exists", "lowest.alive", "lowest.friend", "!lowest.role(tank)", "!lowest.immune.melee", "lowest.health < 25" }, "lowest" },
	--{ "Hand of Sacrifice", { "tank.exists", "tank.alive", "tank.friend", "tank.range <= 40", "tank.health < 75" }, "tank" }, --TODO: !tank.player
	{ "Flash of Light", { "lowest.health < 50", "player.buff(Selfless Healer).count > 2" }, "lowest" }, -- T3
	{ "Flash of Light", { "player.health < 70", "player.buff(Selfless Healer).count > 2", "player.buff(Bastion of Glory)" }, "player" }, -- T3
	
	--Cooldowns
	{{
		{ "Lay on Hands", "player.health < 20" },
		{ "Ardent Defender", "player.health < 20" },
		{ "Avenging Wrath", "target.boss" },
		{ "Holy Avenger", "player.holypower < 2" },  -- T5
	}, {
		"modifier.cooldowns",
	}},
	
	-- Mouseovers
	{ "Light's Hammer", { "modifier.lalt" }, "ground" },
	{{
		{ "Hand of Freedom", { "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "mouseover.state.root", "!mouseover.buff" }, "mouseover" },
		{ "Hand of Freedom", { "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "mouseover.state.snare", "!mouseover.buff" }, "mouseover" },
		{ "Hand of Salvation", { "mouseover.exists", "mouseover.alive", "mouseover.friend", "mouseover.range <= 40", "!mouseover.role(tank)", "@bbLib.highThreatOnPlayerTarget(mouseover)" }, "mouseover" },
	}, {
		"toggle.mouseovers",
	}},
	
	-- DPS Rotation
	{ "Avenger's Shield", { "modifier.multitarget", "modifier.enemies > 9" } },
	{ "Judgment", "player.spell(Sanctified Wrath).exists" },
	{ "Hammer of the Righteous", "modifier.multitarget" },
	{ "Crusader Strike", "!modifier.multitarget" },
	{ "Judgment" },
	{ "Consecration", { "modifier.multitarget", "target.spell(Crusader Strike).range", "!player.buff(Grand Crusader)" } },
	{ "Avenger's Shield" },
	{ "Holy Prism" }, --T6
	{ "Execution Sentence", "player.health < 70", "player" }, --T6
	{ "Execution Sentence", "player.health > 70", "target" }, --T6
	{ "Hand of Purity" },  -- T4
	{ "Holy Wrath", "!toggle.limitaoe" },
	{ "Hammer of Wrath", "!toggle.limitaoe" },
	{ "Consecration", { "target.spell(Crusader Strike).range", "!toggle.limitaoe" } },
	
},{
-- OUT OF COMBAT ROTATION

	-- Pause
	{ "pause", "modifier.lcontrol" },

	-- Blessings
	{ "Blessing of Might", "!player.buff(Blessing of Might).any" },

	-- Stance
	{ "Righteous Fury", "!player.buff(Righteous Fury)" },
  
},
function()
	ProbablyEngine.toggle.create('mouseovers', 'Interface\\Icons\\spell_fire_flameshock', 'Toggle Mouseovers', 'Automatically cast spells on mouseover targets')
	ProbablyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'PvP', 'Toggle the usage of PvP abilities.')
	ProbablyEngine.toggle.create('limitaoe', 'Interface\\Icons\\spell_fire_flameshock', 'Limit AoE', 'Toggle to avoid using CC breaking aoe effects.')
	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
	ProbablyEngine.toggle.create('autotaunt', 'Interface\\Icons\\spell_nature_reincarnation', 'Auto Taunt', 'Automaticaly taunt the boss at the appropriate stacks')
end)
