-- ProbablyEngine Rotation Packager
-- Custom Survival Hunter Rotation
-- Created on Dec 25th 2013 1:00 am
ProbablyEngine.rotation.register_custom(255, "bbHunterSurvival", {
-- PLAYER CONTROLLED:
-- SUGGESTED TALENTS:
-- CONTROLS: Pause - Left Control, Explosive/Ice/Snake Traps - Left Alt, Freezing Trap - Right Alt

-- COMBAT
	-- Rotation Utilities
    { "pause", "modifier.lcontrol" },
	{ "pause", "@bbLib.bossMods" },
	{ "pause", "player.buff(Feign Death)" },
	{ "pause", { "toggle.pvpmode", "@bbLib.BGFlag" } },

	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "!target.exists" } },
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "target.exists", "target.dead" } },
	
	--{ "pause", "player.time >= 300", "toggle.dpstest" } },

	-- Interrupts
    { "Counter Shot", { "modifier.interruptAt(80)", "player.range < 40" } },
	
    -- Pet
    { "883", "!pet.exists" }, -- Call Pet 1
    { "Heart of the Phoenix", "!pet.alive" },
    { "Revive Pet", "!pet.alive" },
	{ "Mend Pet", { "pet.health <= 75", "pet.exists", "!pet.buff(Mend Pet)", "pet.range < 40" } },

	-- PvP Abilities
	{ "Master's Call", "player.state.disorient" },
    { "Master's Call", "player.state.stun" },
    { "Master's Call", "player.state.root" },
    { "Master's Call", "player.state.snare" },
	{ "Scatter Shot", { "toggle.pvpmode", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient", 
		"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root", 
		"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.disorient" }, "mouseover" }, -- If casting too?
	{ "Wyvern Sting", { "toggle.pvpmode", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient", 
		"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root", 
		"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.sleep" }, "mouseover" }, -- If casting too?
	-- TODO: Binding Shot (ground)
	-- TODO: Reactive Deterrence
	{ "Scare Beast", { "toggle.pvpmode", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "mouseover.creatureType(Beast)" }, "mouseover" },
	{ "Scare Beast", { "toggle.pvpmode", "target.exists", "target.enemy", "target.alive", "target.creatureType(Beast)" } },
	
    -- Mouseovers
	{ "Serpent Sting", { "toggle.mousesting", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.debuff(Serpent Sting)",
		"!mouseover.state.charm", "mouseover.deathin > 10" }, "mouseover" },
	
	-- Traps
    { "Explosive Trap", "modifier.lalt", "ground" },
    { "Ice Trap" , "modifier.lalt", "ground" },
	{ "Snake Trap" , "modifier.lalt", "ground" },
	{ "Freezing Trap" , "modifier.ralt", "ground" },
	
    -- Tranq Shot
    { "Tranquilizing Shot", "target.dispellable(Tranquilizing Shot)", "target" },

	-- TODO: Boss Functions + hold cooldowns

	-- TODO: Energy Pooling Toggle
	
	-- TODO: Cleave Rotation?

    -- Misdirect to focus target or pet when threat is above a certain threshold
    { "Misdirection", { "!toggle.pvpmode", "focus.exists", "!player.buff(Misdirection)", "target.threat > 60" }, "focus" },
    { "Misdirection", { "!toggle.pvpmode", "pet.exists", "!player.buff(Misdirection)", "!focus.exists", "target.threat > 85" }, "pet" },

	-- Stances
    { "Aspect of the Iron Hawk", { "!player.buff(Aspect of the Hawk)", "!player.buff(Aspect of the Iron Hawk)", "!player.moving" } }, -- Aspect of the Iron Hawk
    { "Aspect of the Hawk", { "!player.buff(Aspect of the Hawk)", "!player.buff(Aspect of the Iron Hawk)", "!player.moving" } }, -- Aspect of the Hawk
	
	-- Pre DPS Pause
	{ "pause", "target.debuff(Wyvern Sting).any" },
	{ "pause", "target.debuff(Scatter Shot).any" },
	{ "pause", "target.immune.all" },
	{ "pause", "target.status.disorient" },
	{ "pause", "target.status.incapacitate" },
	{ "pause", "target.status.sleep" },
	
    -- Cooldowns
	{{
		{ "Exhilaration", "player.health < 50" },
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
		{ "Barrage" }, -- TIER 6: Barrage
		{ "Glaive Toss" }, -- TIER 6: Glaive Toss
		{ "Lynx Rush" }, -- TIER 5: Lynx Rush
		{ "Dire Beast" }, -- TIER 4: Dire Beast
		{ "Fervor", "player.focus < 50" }, -- TIER 4: Fervor
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
	{ "Concussive Shot", { "toggle.pvpmode", "!target.debuff(Concussive Shot).any", "target.moving", "!target.immune.snare" }},
	{ "Widow Venom", { "toggle.pvpmode", "!target.debuff(Widow Venom).any", "target.health > 20" }},
    { "Cobra Shot", "target.debuff(Serpent Sting).duration < 4" }, -- Cobra Shot if sting is about to drop.
	{ "A Murder of Crows" }, -- TIER 5: A Murder of Crows
	{ "Lynx Rush" }, -- TIER 5: Lynx Rush
	{ "Dire Beast" }, -- TIER 4: Dire Beast
    { "Fervor", "player.focus < 50" }, -- TIER 4: Fervor
	{ "Glaive Toss" }, -- TIER 6: Glaive Toss
    { "Powershot" }, -- TIER 6: Powershot
	{ "Barrage" }, -- TIER 6: Barrage
	{ "Explosive Trap", { "modifier.multitarget", "modifier.enemies > 2" }, "ground" },
	{ "Multi-Shot", { "modifier.multitarget", "modifier.enemies > 1", "player.focus >= 60", "!player.buff(56453)" } },
    { "Arcane Shot", { "player.buff(Thrill of the Hunt)", "player.focus >= 40" } },
    { "Arcane Shot", { "player.focus >= 60", "!player.buff(56453)" } },
    { "Cobra Shot", { "player.focus < 80", "player.spell(Explosive Shot).cooldown > 1", "player.spell(Black Arrow).cooldown > 1" }},
},
{
    { "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Feign Death)" },
	{ "Aspect of the Cheetah", { "toggle.aspect", "player.moving", "!player.buff(Aspect of the Cheetah)", "!player.buff(Aspect of the Pack)" } },
	{ "Hunter's Mark", { "target.exists", "target.alive", "!target.debuff(Hunter's Mark).any" }, "target" },
    { "Mend Pet", { "pet.health <= 90", "pet.exists", "pet.alive", "!pet.buff(Mend Pet)" } },
	{ "Camouflage", { "toggle.camomode", "!player.buff(Camouflage)", "!player.debuff(Orb of Power)" } }, 
	
	{ "Explosive Trap", "modifier.lalt", "ground" },
    { "Ice Trap" , "modifier.lalt", "ground" },
	{ "Snake Trap" , "modifier.lalt", "ground" },
	{ "Freezing Trap" , "modifier.ralt", "ground" },
}, 
function()
	ProbablyEngine.toggle.create('aspect', 'Interface\\Icons\\ability_mount_jungletiger', 'Auto Aspect', 'Automatically switch aspect when moving and not in combat.')
	ProbablyEngine.toggle.create('mousesting', 'Interface\\Icons\\ability_hunter_quickshot', 'Auto Sting', 'Automatically cast Serpent Sting on mouseover targets.')
	ProbablyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'PvP', 'Toggle the usage of PvP abilities.')
	ProbablyEngine.toggle.create('camomode', 'Interface\\Icons\\ability_hunter_displacement', 'Camouflage', 'Toggle the usage Camouflage when out of combat.')
	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
end)
