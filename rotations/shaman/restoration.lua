-- ProbablyEngine Rotation Packager
-- Custom Restoration Shaman Rotation
-- Created on Dec 25th 2013 1:00 am
ProbablyEngine.library.register('coreHealing', {
	needsHealing = function(percent, count)
		return ProbablyEngine.raid.needsHealing(tonumber(percent)) >= count
	end,
	needsDispelled = function(spell)
		for _, unit in pairs(ProbablyEngine.raid.roster) do
			if UnitDebuff(unit.unit, spell) then
				ProbablyEngine.dsl.parsedTarget = unit.unit
				return true
			end
		end
	end,
})

ProbablyEngine.rotation.register_custom(264, "bbRestorationShaman", {
-- PLAYER CONTROLLED:
-- SUGGESTED TALENTS:
-- CONTROLS: Pause - Left Control, Healing Rain - Left Shift
-- NOTE: Set Focus target to tank, for: Earth Shield, Riptide, Lightning Bolt

-- COMBAT
	-- Rotation Utilities
	{ "pause", "modifier.lcontrol" },
	{ "pause", "@bbLib.bossMods" },
	{ "pause", { "toggle.pvpmode", "@bbLib.BGFlag" } },
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },
	{ "/follow focus", { "toggle.autofollow", "focus.exists", "focus.alive", "focus.friend", "focus.spell(Water Walking).range", "!focus.spell(Primal Strike).range" } }, -- TODO: NYI: isFollowing()
	
	-- Racials 
	{ "Stoneform", "player.health <= 65" },
	{ "Gift of the Naaru", "player.health <= 70", "player" },
	{ "Rocket Barrage", "player.moving" },
	{ "Quaking Palm", "modifier.interrupts" },
	{ "Lifeblood", { "modifier.cooldowns", "player.spell(Lifeblood).cooldown < 1" }, "player" },
	
	-- Buffs
	{ "Earthliving Weapon", "!player.enchant.mainhand" },
	{ "Water Shield", "!player.buff" },

	-- Interrupt
	{ "Wind Shear", "modifier.interrupt" },

	-- Mouseovers
	--{ "Flame Shock", { "mouseover.enemy", "mouseover.alive", "mouseover.deathin > 15", "mouseover.debuff(Flame Shock).duration <= 3", "toggle.mouseovers" }, "mouseover" },

	-- Cooldowns
	{ "Elemental Mastery", { "modifier.cooldowns", "target.boss" } }, -- T4

	-- Tank
	{ "Earth Shield", "!focus.buff(Earth Shield).any", "focus" },
	{ "Riptide", "!focus.buff(Riptide)", "focus" },
	{ "Riptide", "!tank.buff(Riptide)", "tank" },
	
	-- Oh Shit
	{ "Ancestral Swiftness", "lowest.health < 25" },
	{ "Greater Healing Wave", { "lowest.health < 25", "player.buff(Ancestral Swiftness)" }, "lowest" },

	-- Cooldowns
	{ "#gloves", { "modifier.cooldowns", "player.totem(Healing Tide Totem)" } },
	{ "#gloves", { "modifier.cooldowns", "player.totem(Spirit Link Totem)" } },
	{ "#gloves", { "modifier.cooldowns", "player.buff(Ascendance)" } },
	{ "Spirit Walker's Grace", { "modifier.cooldowns", "player.buff(Ascendance)" } },
	{ "Healing Stream Totem", { "!player.totem(Healing Tide Totem)", "!player.totem(Mana Tide Totem)" } },
	{ "Mana Tide Totem", { "modifier.cooldowns", "!player.totem(Healing Tide Totem)", "!player.totem(Healing Stream Totem)", "player.mana < 30" } },
	{ "Healing Tide Totem", { "modifier.cooldowns", "!player.totem(Mana Tide Totem)", "!player.totem(Spirit Link Totem)", "!player.buff(Ascendance)", "@coreHealing.needsHealing(50, 5)" } },
	{ "Spirit Link Totem", { "modifier.cooldowns", "!player.totem(Healing Tide Totem)", "!player.buff(Ascendance)", "@coreHealing.needsHealing(45, 4)" } },
	{ "Ascendance", { "modifier.cooldowns", "!player.totem(Spirit Link Totem)", "!player.totem(Healing Tide Totem)", "@coreHealing.needsHealing(40, 5)" } },

	-- Dispel
	{ "Purify Spirit", "@coreHealing.needsDispelled('Aqua Bomb')" },

	-- AoE
	{ "Unleash Elements", "modifier.lshift" },
	{ "Healing Rain", "modifier.lshift", "ground" },

	-- Unleash Life
	{ "Greater Healing Wave", { "lowest.health < 50", "player.buff(Unleash Life)" }, "lowest" },
	{ "Unleash Elements", "lowest.health < 50" }, -- Use before direct heals

	-- regular healing
	{ "Healing Surge", "lowest.health < 40", "lowest" }, -- only if you feel that the target will die before you have a chance to complete a Greater Healing Wave Icon Greater Healing Wave cast on them. If you suspect that a player may be in danger of dying in the near future, apply Riptide Icon Riptide on them, this will give them a bit of healing and, thanks to Tidal Waves Icon Tidal Waves, this will increase the critical strike chance of Healing Surge Icon Healing Surge.
	{ "Riptide", { "!lowest.buff(Riptide)", "lowest.health < 99" }, "lowest" },
	{ "Greater Healing Wave", { "lowest.health < 70", "player.buff(Tidal Waves).count = 2" }, "lowest" },
	{ "Chain Heal", { "modifier.multitarget", "@coreHealing.needsHealing(80, 3)" }, "lowest" }, --Therefore, you should always cast Chain Heal Icon Chain Heal on targets with an active Riptide Icon Riptide. 
	{ "Healing Wave", "lowest.health < 85", "lowest" },

	-- DPS
	{ "Lightning Bolt", { "toggle.dpsmode", "focus.exists", "focustarget.exists", "focustarget.enemy", "focustarget.range < 40", "player.glyph(Glyph of Telluric Currents)", "!modifier.last(Lightning Bolt)" }, "focustarget" },
	{{
		{ "Fire Elemental Totem", { "modifier.cooldowns", "target.boss", "target.range < 40"  } },
		{ "Stormlash Totem", { "modifier.cooldowns", "target.boss", "target.range < 40" } },
		{ "Searing Totem", { "!player.totem(Magma Totem)", "!player.totem(Fire Elemental Totem)", "!player.totem(Searing Totem)" } },
		{ "Flame Shock", { "focustarget.exists", "!focustarget.debuff(Flame Shock)" }, "focustarget" },
		{ "Lava Burst", { "focustarget.exists", "focustarget.debuff(Flame Shock)" }, "focustarget" },
	}, {
		"toggle.dpsmode",
		"player.mana > 70",
	}},
	
}, {
-- OUT OF COMBAT ROTATION
	-- Pause
	{ "pause", "modifier.lcontrol" },

	-- Buffs
	{ "Earthliving Weapon", "!player.enchant.mainhand" },
	{ "Water Shield", "!player.buff" },
	{ "Ghost Wolf", { "!player.buff(Ghost Wolf)", "player.moving" } },
	
	-- Auto Follow
	{ "/follow focus", { "toggle.autofollow", "focus.exists", "focus.alive", "focus.friend", "focus.spell(Water Walking).range", "!focus.spell(Primal Strike).range" } }, -- TODO: NYI: isFollowing()

	-- Heal
	{ "Healing Stream Totem", "player.health < 80" },
	--{ "Healing Wave", "@coreHealing.needsHealing(80, 1)", "lowest" },
	{ "Healing Wave", "lowest.health < 85", "lowest" },
	
},
function()
	ProbablyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'PvP', 'Toggle the usage of PvP abilities.')
	ProbablyEngine.toggle.create('dpsmode', 'Interface\\Icons\\ability_dualwield', 'DPS Mode', 'Toggle the usage of damage dealing abilities.')
	ProbablyEngine.toggle.create('mouseovers', 'Interface\\Icons\\spell_fire_flameshock', 'Toggle Mouseovers', 'Automatically cast spells on mouseover targets')
	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
	ProbablyEngine.toggle.create('autofollow', 'Interface\\Icons\\ui_charactercreate_gendermale', 'Auto Follow', 'Automaticaly follows your focus target. Must be another player.')
end)
