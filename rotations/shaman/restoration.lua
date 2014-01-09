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

-- COMBAT
	-- Rotation Utilities
	{ "pause", "modifier.lcontrol" },
	{ "pause", "@bbLib.bossMods" },
	{ "pause", { "toggle.pvpmode", "@bbLib.BGFlag" } },
	w{ "/script TargetNearestEnemy()", { "toggle.autotarget", "!target.exists" } },
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "target.exists", "target.dead" } },
	--{ "/script FollowUnit('focus')", { "toggle.autofollow", "focus.exists", "focus.alive" } }, -- TODO: NYI: isFollowing()
	
	-- Racials 
	{ "Stoneform", "player.health <= 65" },
	{ "Gift of the Naaru", "player.health <= 70", "player" },
	{ "Rocket Barrage", "player.moving" },
	{ "Quaking Palm", "modifier.interrupts" },
	
	-- Buffs
	{ "Earthliving Weapon", "!player.enchant.mainhand" },
	{ "Water Shield", "!player.buff" },

	-- Interrupt
	{ "Wind Shear", "modifier.interrupt" },

	-- Mouseovers
	{ "Flame Shock", { "mouseover.enemy", "mouseover.alive", "mouseover.deathin > 15", "mouseover.debuff(Flame Shock).duration <= 3", "toggle.mouseovers" }, "mouseover" },

	-- Cooldowns
	--{ "Elemental Mastery", { "modifier.cooldowns", "target.boss" } },
	--{ "Ascendance", { "modifier.cooldowns", "target.boss", "!player.buff(Ascendance)" } },

	-- Tank
	{ "Earth Shield", "!tank.buff(Earth Shield).any", "tank" },
	{ "Riptide", "!tank.buff(Riptide)", "tank" },

	-- Healing totem
	{ "Healing Stream Totem" },
	{ "Mana Tide Totem", { "modifier.cooldowns", "player.mana < 30" } },
	{ "Healing Tide Totem", "@coreHealing.needsHealing(40, 4)", "lowest" },

	-- Dispel
	{ "Purify Spirit", "@coreHealing.needsDispelled('Aqua Bomb')" },

	-- AoE
	{ "Unleash Elements", "modifier.lshift" },
	{ "Healing Rain", "modifier.lshift", "ground" },

	-- Unleash Life
	{ "Greater Healing Wave", { "lowest.health < 50", "player.buff(Unleash Life)" }, "lowest" },
	{ "Unleash Elements", "lowest.health < 50" }w, -- Use before direct heals
	{ "Healing Wave", { "lowest.health < 91", "lowest.debuff(Chomp)" }, "lowest" },

	-- regular healing
	{ "Healing Surge", "lowest.health < 40", "lowest" }, -- only if you feel that the target will die before you have a chance to complete a Greater Healing Wave Icon Greater Healing Wave cast on them. If you suspect that a player may be in danger of dying in the near future, apply Riptide Icon Riptide on them, this will give them a bit of healing and, thanks to Tidal Waves Icon Tidal Waves, this will increase the critical strike chance of Healing Surge Icon Healing Surge.
	{ "Riptide", { "!lowest.buff(Riptide)", "lowest.health < 99" }, "lowest" },
	{ "Greater Healing Wave", { "lowest.health < 55", "player.buff(Tidal Waves).count = 2" }, "lowest" },
	{ "Chain Heal", "@coreHealing.needsHealing(80, 4)", "lowest" }, --Therefore, you should always cast Chain Heal Icon Chain Heal on targets with an active Riptide Icon Riptide. 
	{ "Healing Wave", "lowest.health < 75", "lowest" },


	-- DPS
	{ "Fire Elemental Totem", { "modifier.cooldowns", "target.boss" } },
	{ "Stormlash Totem", { "modifier.cooldowns", "target.boss" } },
	{ "Searing Totem", { "!player.totem(Fire Elemental Totem)", "!player.totem(Searing Totem)" } },
	{ "Flame Shock", { "focustarget.exists", "!focustarget.debuff(Flame Shock)", "player.mana > 66" }, "focustarget" },
	{ "Lava Burst", { "focustarget.exists", "focustarget.debuff(Flame Shock)", "player.mana > 66" }, "focustarget" },
	{ "Lightning Bolt", { "focustarget.exists", "player.glyph(Glyph of Telluric Currents)" }, "focustarget" },
	
}, {
-- OUT OF COMBAT ROTATION
	-- Pause
	{ "pause", "modifier.lcontrol" },

	-- Buffs
	{ "Earthliving Weapon", "!player.enchant.mainhand" },
	{ "Water Shield", "!player.buff" },

	-- Heal
	{ "Healing Stream Totem", "player.health < 80" },
	{ "Healing Wave", "@coreHealing.needsHealing(80, 1)", "lowest" },
	{ "Healing Wave", "lowest.health < 85", "lowest" },
	
},
function()
	ProbablyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'PvP', 'Toggle the usage of PvP abilities.')
	ProbablyEngine.toggle.create('mouseovers', 'Interface\\Icons\\spell_fire_flameshock', 'Toggle Mouseovers', 'Automatically cast spells on mouseover targets')
	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
end)
