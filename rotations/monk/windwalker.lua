-- ProbablyEngine Rotation Packager
-- Custom Protection Warrior Rotation
-- Created on Dec 25th 2013 1:00 am
ProbablyEngine.rotation.register_custom(269, "bbWindwalkerMonk", {
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
	{ "Will of the Forsaken", "player.state.fear" },
	{ "Will of the Forsaken", "player.state.charm" },
	{ "Will of the Forsaken", "player.state.sleep" },
	{ "Quaking Palm", "modifier.interrupts" },

	-- Off GCD
	{ "Touch of Death", "player.buff(Death Note)" },

	-- Interrupts
	{ "Spear Hand Strike", "modifier.interrupts" },
	{ "Grapple Weapon", "modifier.interrupts" },
	{ "Leg Sweep", "modifier.interrupts", "target.range <= 5" },

	-- Survival
	{ "Fortifying Brew", "player.health <= 30" },
	{ "Touch of Karma", "player.health <= 50" },
	{ "Nimble Brew", "player.state.fear" },
	{ "Nimble Brew", "player.state.stun" },
	{ "Nimble Brew", "player.state.root" },
	{ "Nimble Brew", "player.state.horror" },
	{ "Dampen Harm", "player.health <= 45" },
	{ "Diffuse Magic", "player.health <= 45" },

	-- Keybinds
	{ "Paralysis", "modifier.shift", "mouseover" },
	{ "Healing Sphere", "modifier.alt", "ground" }, 
	{ "Crackling Jade Lightning", "modifier.control", "target" },

	-- Cooldowns
	{ "Invoke Xuen: The White Tiger", "modifier.cooldowns" },

	-- Talents

	{ "Zen Sphere", "!player.buff(Zen Sphere)", "player" },
	{ "Chi Burst" },
	{ "Invoke Xuen, the White Tiger" },
	{ "Tiger's Lust", "target.range >= 15" },

	-- Multi-Target
	{ "Rushing Jade Wind", "modifier.multitarget" },
	{ "Spinning Crane Kick", "modifier.multitarget" },
	{ "Fists of Fury", "modifier.multitarget", "player.energy < 30", "target.range <= 8", "player.chi >= 3" },

	--Brews
	{ "Energizing Brew", "player.energy <= 45" },
	{ "Tigereye Brew", "player.buff(Tigereye Brew).count >= 10" },


	-- Chi Builders
	-- Expel Harm
	-- Jab
	-- Chi Brew ( Always keep one charge reloading )

	-- Rotation
	-- Chi Finishers
	{ "Tiger Palm", "player.buff(Tiger Power).duration <= 2" },
	{ "Tiger Palm", "player.buff(Combo Breaker: Tiger Palm)" },
	{ "Rising Sun Kick" },
	{ "Fists of Fury", "player.energy < 30", "target.range <= 8" }, -- dont clip RSK, dont reach max energy while channeling, Tiger Power time > 5 sec, not moving
	{ "Blackout Kick", "player.buff(Combo Breaker: Blackout Kick)" },
	{ "Chi Wave" }, -- dont reach max energy
	{ "Blackout Kick", { "player.chi >= 2", "target.debuff(Rising Sun Kick)", "player.buff(Tiger Power)"} },

	-- Chi Builders
	{ "Expel Harm", "player.health < 80" },
	{ "Jab" },
	{ "Chi Brew", "player.chi <= 1" },

},{
-- OUT OF COMBAT
  	-- Pause
	{ "pause", "modifier.lcontrol" },

	{ "Expel Harm", "player.health < 80" },
	{ "Fortifying Brew", "player.health <= 30" },
	{ "Touch of Karma", "player.health <= 50" },

	-- Keybinds
	{ "Paralysis", "modifier.shift", "mouseover" },
	{ "Healing Sphere", "modifier.alt", "ground" }, 
	{ "Crackling Jade Lightning", "modifier.control", "target" },

	-- Buffs
	{ "Legacy of the White Tiger", "!player.buff(Legacy of the White Tiger)" },
	{ "Legacy of the Emperor", "!player.buff(Legacy of the Emperor)" },

},
function()
	ProbablyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'PvP', 'Toggle the usage of PvP abilities.')
	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
end)
