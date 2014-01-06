-- ProbablyEngine Rotation Packager
-- Custom Survival Hunter Rotation
-- Created on Dec 25th 2013 1:00 am
ProbablyEngine.rotation.register_custom(255, "bbHunterSurvival", {
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
	
	{ "pause", "player.buff(Feign Death)" },
	--{ "pause", "player.time >= 300", "toggle.dpstest" } },
	
	-- Master's Call (53271)
    { "53271", "player.state.disorient" },
    { "53271", "player.state.stun" },
    { "53271", "player.state.root" },
    { "53271", "player.state.snare" },
	
	-- Interrupts
    { "Counter Shot", { "modifier.interruptAt(80)", "player.range < 40" } },
	
    -- Pet
    { "883", "!pet.exists" }, -- Call Pet 1
    { "Heart of the Phoenix", "!pet.alive" },
    { "Revive Pet", "!pet.alive" },
	{ "Mend Pet", { "pet.health <= 75", "pet.exists", "!pet.buff(Mend Pet)", "pet.range < 40" } },

    -- Mouseovers
	{ "Serpent Sting", { "toggle.mousesting", "mouseover.enemy", "mouseover.exists", "mouseover.alive", "!mouseover.debuff(Serpent Sting)", "!mouseover.state.charm", "mouseover.deathin > 10" }, "mouseover" },
	-- Traps
    { "Explosive Trap", "modifier.lalt", "ground" },
    { "Ice Trap" , "modifier.lalt", "ground" },
	{ "Snake Trap" , "modifier.lalt", "ground" },

    -- Tranq Shot
    { "19801", "target.dispellable(19801)", "target" }, -- Tranquilizing Shot (19801)

	-- Boss Functions + hold cooldowns
	-- TODO

	-- Energy Pooling Toggle
	-- TODO

    -- Misdirect to focus target or pet when threat is above a certain threshold
    { "Misdirection", { "focus.exists", "!player.buff(Misdirection)", "target.threat > 60" }, "focus" },
    { "Misdirection", { "pet.exists", "!player.buff(Misdirection)", "!focus.exists", "target.threat > 85" }, "pet" },

	-- Stances
    { "109260", { "player.spell(109260).exists", "!player.buff(109260)", "!player.buff(13165)", "!player.moving" } }, -- Aspect of the Iron Hawk
    { "13165", { "!player.spell(109260).exists", "!player.buff(109260)", "!player.buff(13165)", "!player.moving" } }, -- Aspect of the Hawk
	
    -- Cooldowns
	{{
		{ "Exhilaration", { "player.spell(109304).exists", "player.health < 50" } },
		{ "#5512", "player.health < 40" }, -- Healthstone
		{ "#76097", { "player.health < 40", "@bbLib.useHealthPot" } }, -- Master Healing Potion
		{ "#76089", { "pet.exists", "target.exists", "@bbLib.useAgiPot" } }, -- Agility Potion (76089)
		{ "#gloves", { "pet.exists", "target.exists" } },
		{ "Stampede", { "pet.exists", "@bbLib.playerHasted" } },
		{ "Rapid Fire", { "pet.exists", "target.exists", "target.deathin > 10", "!player.buff(Focus Fire)", "!@bbLib.playerHasted" } },
		{ "Berserking", { "pet.exists", "target.exists", "!@bbLib.playerHasted" } },
	},{
		"modifier.cooldowns",
	}},
    
    -------- AoE DPS Rotation --------
    {{
		{ "Barrage", "player.spell(120360).exists" }, -- TIER 6: Barrage
		{ "Glaive Toss", "player.spell(117050).exists" }, -- TIER 6: Glaive Toss
		{ "Lynx Rush", "player.spell(120697).exists" }, -- TIER 5: Lynx Rush
		{ "Dire Beast", "player.spell(120679).exists" }, -- TIER 4: Dire Beast
		{ "Fervor", { "player.spell(82726).exists", "player.focus < 50" } }, -- TIER 4: Fervor
		{ "Multi-Shot" },
		--{ "Explosive Trap", "", "ground" },
		{ "Black Arrow", { "target.deathin > 10", "!target.state.charm" } },
		{ "Explosive Shot", "player.buff(Lock and Load)" },
		{ "Kill Shot", "target.health <= 20" }, -- Kill Shot
		{ "Cobra Shot", "player.focus < 30" },
    }, 
	{
        "modifier.multitarget",
        "modifier.enemies > 3",
    }},

    -------- Single DPS Rotation --------
    { "Serpent Sting", { "!target.debuff(Serpent Sting)", "!target.state.charm", "target.deathin > 10" } }, -- Serpent Sting (1978)
	{ "Explosive Shot" }, -- Explosive Shot on cooldown.
	{ "Kill Shot", "target.health <= 20" }, -- Kill Shot
    { "Black Arrow", { "target.deathin > 15", "!target.state.charm" } }, -- Black Arrow on cooldown (if the target will live for the full duration of Black Arrow).
	{ "Concussive Shot", { "toggle.pvpmode", "!target.debuff(Concussive Shot).any" }},
	{ "Widow Venom", { "toggle.pvpmode", "!target.debuff(Widow Venom).any", "target.health > 20" }},
    { "Cobra Shot", "target.debuff(Serpent Sting).duration < 4" }, -- Cobra Shot if sting is about to drop.
	{ "A Murder of Crows", "player.spell(131894).exists" }, -- TIER 5: A Murder of Crows
	{ "Lynx Rush", "player.spell(120697).exists" }, -- TIER 5: Lynx Rush
	{ "Dire Beast", "player.spell(120679).exists" }, -- TIER 4: Dire Beast
    { "Fervor", { "player.spell(82726).exists", "player.focus < 50" } }, -- TIER 4: Fervor
	{ "Glaive Toss", "player.spell(117050).exists" }, -- TIER 6: Glaive Toss
    { "Powershot", "player.spell(109259).exists" }, -- TIER 6: Powershot
	{ "Barrage", "player.spell(120360).exists" }, -- TIER 6: Barrage
	{ "Explosive Trap", { "modifier.multitarget", "modifier.enemies > 2" }, "ground" },
	{ "Multi-Shot", { "modifier.multitarget", "modifier.enemies > 1", "player.focus >= 60", "!player.buff(56453)" } },
    { "Arcane Shot", { "player.buff(Thrill of the Hunt)", "player.focus >= 40" } },
    { "Arcane Shot", { "player.focus >= 60", "!player.buff(56453)" } },
    { "Cobra Shot", { "player.focus < 80", "player.spell(Explosive Shot).cooldown > 1", "player.spell(Black Arrow).cooldown > 1" }},
},
{
    { "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Feign Death)" },
	{ "5118", { "toggle.aspect", "player.moving", "!player.buff(5118)", "!player.buff(13159)" } }, -- Aspect of the Cheetah (5118)
	{ "1130", { "target.exists", "target.alive", "!target.debuff(1130)" }, "target" }, -- Hunter's Mark
    { "Mend Pet", { "pet.health <= 90", "pet.exists", "pet.alive", "!pet.buff(Mend Pet)" } },
	{ "Camouflage", { "toggle.camomode", "!player.buff(Camouflage)" }},
}, 
function()
	ProbablyEngine.toggle.create('aspect', 'Interface\\Icons\\ability_mount_jungletiger', 'Auto Aspect', 'Automatically switch aspect when moving and not in combat.')
	ProbablyEngine.toggle.create('mousesting', 'Interface\\Icons\\ability_hunter_quickshot', 'Auto Sting', 'Automatically cast Serpent Sting on mouseover targets.')
	ProbablyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'PvP', 'Toggle the usage of PvP abilities.')
	ProbablyEngine.toggle.create('camomode', 'Interface\\Icons\\ability_hunter_displacement', 'Camouflage', 'Toggle the usage Camouflage when out of combat.')
	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
end)
