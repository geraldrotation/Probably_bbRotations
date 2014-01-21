-- ProbablyEngine Rotation Packager
-- Custom Brewmaster Monk Rotation
-- Created on Dec 25th 2013 1:00 am
ProbablyEngine.rotation.register_custom(268, "bbBrewmasterMonk", {
-- PLAYER CONTROLLED:
-- SUGGESTED TALENTS:
-- CONTROLS: Pause - Left Control

-- COMBAT
	-- Rotation Utilities
	{ "pause", "modifier.lcontrol" },
	{ "pause", "@bbLib.bossMods" },
	{ "pause", "player.buff(5384)" }, -- Feign Death
	{ "pause", { "toggle.pvpmode", "@bbLib.BGFlag" } },
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },

	-- Racials
	{ "Stoneform", "player.health <= 65" },
	{ "Every Man for Himself", "player.state.charm" },
	{ "Every Man for Himself", "player.state.fear" },
	{ "Every Man for Himself", "player.state.incapacitate" },
	{ "Every Man for Himself", "player.state.sleep" },
	{ "Every Man for Himself", "player.state.stun" },

	-- Off GCD
	{ "Touch of Death", "player.buff(Death Note)" },

	{ "Provoke", { "toggle.autotaunt", "@bbLib.bossTaunt" } },

	-- Survival
	{ "Expel Harm", "player.health < 95" },
	{ "Fortifying Brew", "player.health <= 50" },
	{ "Nimble Brew", "player.state.fear" },
	{ "Nimble Brew", "player.state.stun" },
	{ "Nimble Brew", "player.state.root" },
	{ "Nimble Brew", "player.state.horror" },
	{ "Dampen Harm", "player.health <= 60" },
	{ "Diffuse Magic", "player.health <= 60" },

	-- Multitarget
	{ "Rushing Jade Wind", { "modifier.multitarget", "!player.buff(Rushing Jade Wind)", "!player.buff(Rushing Jade Wind).duration < 2" } },
	{ "Spinning Crane Kick", "modifier.multitarget" },

	-- Ground Stuff
	{ "Dizzying Haze", "modifier.shift", "ground" },
	{ "Summon Black Ox Statue", "modifier.control", "ground" },
	{ "Healing Sphere", "modifer.alt", "ground" },

	-- Interrupts
	{ "Spear Hand Strike", "modifier.interrupts" },
	{ "Grapple Weapon", "modifier.interrupts" },
	{ "Leg Sweep", "modifier.interrupts", "target.range <= 10" },

	-- Talents
	{ "Chi Wave" },
	{ "Zen Sphere", "!player.buff(Zen Sphere)", "player" },
	{ "Chi Burst" },
	{ "Invoke Xuen, the White Tiger" },
	{ "Tiger's Lust", "target.range >= 15" },

	-- Brews
	{ "Purifying Brew", "player.debuff(Moderate Stagger)" },
	{ "Purifying Brew", "player.debuff(Heavy Stagger)" },
	{ "Elusive Brew", "player.buff(Elusive Brew).count >= 10" },

	-- Rotation
	{ "Keg Smash" },
	{ "Guard", "player.buff(Power Guard)" },

	{ "Breath of Fire", { "target.debuff(Dizzying Haze)", "!target.debuff(Breath of Fire)" } },

	{ "Tiger Palm", "player.buff(Tiger Power).duration < 4" },
	{ "Blackout Kick" },
	{ "Jab" },
	{ "Tiger Palm" },

  },{
-- OUT OF COMBAT
	-- Buffs
	{ "Legacy of the Emperor", "!player.buff(Legacy of the Emperor).any" },

	-- Ground Stuff
	{ "Dizzying Haze", "modifier.shift", "ground" },
	{ "Summon Black Ox Statue", "modifier.control", "ground" },

},
function()
	ProbablyEngine.toggle.create('mouseovers', 'Interface\\Icons\\inv_pet_lilsmoky', 'Use Mouseovers', 'Automatically cast spells on mouseover targets')
	ProbablyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'Enable PvP', 'Toggle the usage of PvP abilities.')
	ProbablyEngine.toggle.create('limitaoe', 'Interface\\Icons\\spell_fire_flameshock', 'Limit AoE', 'Toggle to avoid using CC breaking aoe effects.')
	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
	ProbablyEngine.toggle.create('autotaunt', 'Interface\\Icons\\spell_nature_reincarnation', 'Auto Taunt', 'Automaticaly taunt the boss at the appropriate stacks')
end)
