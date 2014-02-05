-- ProbablyEngine Rotation Packager
-- Custom Elemental Shaman Rotation
-- Created on Dec 25th 2013 1:00 am
ProbablyEngine.rotation.register_custom(262, "bbElementalShaman", {
-- PLAYER CONTROLLED:
-- SUGGESTED TALENTS:
-- CONTROLS: Pause - Left Control

-- COMBAT
	-- Rotation Utilities
	{ "pause", "modifier.lcontrol" },
	{ "pause", "@bbLib.bossMods" },
	{ "pause", { "toggle.pvpmode", "@bbLib.BGFlag" } },
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "!target.exists" } },
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "target.exists", "target.dead" } },
	
	-- Racials 
	{ "Stoneform", "player.health <= 65" },
	{ "Gift of the Naaru", "player.health <= 70", "player" },
	{ "Rocket Barrage", "player.moving" },
	{ "Quaking Palm", "modifier.interrupts" },
	{ "Berserking", "modifier.cooldowns" },

	-- Interrupt
	{ "Wind Shear", "modifier.interrupt" },

	-- Mouseovers
	{ "Flame Shock", { "mouseover.enemy", "mouseover.alive", "mouseover.deathin > 15", "mouseover.debuff(Flame Shock).duration <= 3", "toggle.mouseovers" }, "mouseover" },

	-- Moving Rotation
	{ "Lightning Bolt", { "player.moving", "!player.buff(Spiritwalker's Grace)" } },

	-- Cooldowns
	{ "Stormlash Totem", { "modifier.cooldowns", "target.boss" } },
	{ "Fire Elemental Totem", { "modifier.cooldowns", "target.boss" } },
	{ "Earth Elemental Totem", { "modifier.cooldowns", "target.boss", "!player.totem(Fire Elemental Totem)" } },
	{ "Elemental Mastery", { "modifier.cooldowns", "target.boss" } },
	{ "Ascendance", { "modifier.cooldowns", "target.boss", "!player.buff(Ascendance)" } },
	
	
	-- AoE
	{ "Chain Lightning", { "modifier.enemies >= 4", "modifier.multitarget" } },
	{ "Thunderstorm", { "modifier.enemies >= 6", "modifier.multitarget" } },

	-- Totems
	{ "Searing Totem", { "!player.totem(Fire Elemental Totem)", "!player.totem(Searing Totem)" } },
	{ "Healing Stream", "!totem(Healing Stream)"},

	-- Rotation
	{ "Flame Shock", "target.debuff(Flame Shock).duration <= 3" },
	{ "Lava Beam", "modifier.multitarget" },
	{ "Lava Burst", "!modifier.multitarget" },
	{ "Elemental Blast" },
	{ "Earth Shock", { "player.buff(Lightning Shield)", "player.buff(Lightning Shield).count >= 6" } },
	{ "Chain Lightning", { "modifier.enemies > 2", "modifier.multitarget" } },

	-- Filler
	{ "Lightning Bolt" },
	
}, {
-- OUT OF COMBAT ROTATION
	-- Pause
	{ "pause", "modifier.lcontrol" },
	
	-- Buffs
	{ "Flametongue Weapon", "!player.enchant.mainhand" },
	{ "Lightning Shield", "!player.buff(Lightning Shield)" },

	-- Heal
	{ "Healing Stream Totem", "player.health < 80" },
},
function()
	ProbablyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'PvP', 'Toggle the usage of PvP abilities.')
	ProbablyEngine.toggle.create('mouseovers', 'Interface\\Icons\\spell_fire_flameshock', 'Toggle Mouseovers', 'Automatically cast spells on mouseover targets')
	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
end)
