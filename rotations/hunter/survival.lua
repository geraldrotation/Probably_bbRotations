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

	--{ "/script TargetNearestEnemy()", { "toggle.autotarget", "!target.exists" } },
	{ "/script TargetNearestEnemy()", { "toggle.autotarget", "target.exists", "target.dead" } },
	
	--{ "pause", "player.time >= 300", "toggle.dpstest" } },

	-- Interrupts
    { "Counter Shot", { "modifier.interruptAt(80)", "player.range < 40" } },
	
    -- Pet
    { "883", "!pet.exists" }, -- Call Pet 1
    { "Heart of the Phoenix", "!pet.alive" },
	{ "Mend Pet", { "pet.health <= 50", "pet.exists", "!pet.buff(Mend Pet)", "pet.range < 40" } },

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
	{ "Serpent Sting", { "!modifier.pvpmode", "toggle.mousesting", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.debuff(Serpent Sting)",
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

    -- Misdirects to focus -> tank -> pet
    { "Misdirection", { "!toggle.pvpmode", "!target.isPlayer", "focus.exists", "focus.alive", "!player.buff(Misdirection)", "target.threat > 60" }, "focus" },
	{ "Misdirection", { "!toggle.pvpmode", "!player.buff(Misdirection)", "tank.exists", "tank.alive", "!focus.exists", "target.threat > 60" }, "tank" },
    { "Misdirection", { "!toggle.pvpmode", "!target.isPlayer", "pet.exists", "!player.buff(Misdirection)", "!focus.exists", "target.threat > 60" }, "pet" },

	-- Stances
    { "Aspect of the Iron Hawk", { "!player.buff(Aspect of the Hawk)", "!player.buff(Aspect of the Iron Hawk)", "!player.moving" } }, --TODO: Make toggle
    { "Aspect of the Hawk", { "!player.buff(Aspect of the Hawk)", "!player.buff(Aspect of the Iron Hawk)", "!player.moving" } },
	
	-- Pre DPS Pause
	{ "pause", "target.debuff(Wyvern Sting).any" },
	{ "pause", "target.debuff(Scatter Shot).any" },
	{ "pause", "target.immune.all" },
	{ "pause", "target.status.disorient" },
	{ "pause", "target.status.incapacitate" },
	{ "pause", "target.status.sleep" },

	-- Cooldowns
	{ "Exhilaration", { "modifier.cooldowns", "player.health < 50" } },
	{ "#5512", { "modifier.cooldowns", "player.health < 40" } }, -- Healthstone (5512)
	--{ "#76097", { "modifier.cooldowns", "player.health < 40", "@bbLib.useHealthPot" } }, -- Master Healing Potion (76097) 
	{ "#76089", { "modifier.cooldowns", "toggle.consume", "pet.exists", "target.exists", "@bbLib.useAgiPot" } }, -- Agility Potion (76089)
	{ "Blood Fury", "modifier.cooldowns" },
	{ "#gloves", { "modifier.cooldowns", "pet.exists", "target.exists" } },
	{ "Berserking", { "modifier.cooldowns", "pet.exists", "target.exists", "!@bbLib.playerHasted" } },

	-- PvP
	{ "Concussive Shot", { "toggle.pvpmode", "!target.debuff(Concussive Shot).any", "target.moving", "!target.immune.snare" }},
	{ "Widow Venom", { "toggle.pvpmode", "!target.debuff(Widow Venom).any", "target.health > 20" }},

	-- Dual Use
	{ "Fervor", "player.focus <= 50" }, -- TIER 4: Fervor
	{ "A Murder of Crows" }, -- TIER 5: A Murder of Crows
	{ "Lynx Rush" }, -- TIER 5: Lynx Rush
	
	-- Multi Target
	{ "Multi-Shot", "modifier.multitarget" },
	{ "Glaive Toss", "modifier.multitarget" }, -- TIER 6: Glaive Toss --TODO: do range check
	{ "Powershot", "modifier.multitarget" }, -- TIER 6: Powershot
	{ "Barrage", "modifier.multitarget" }, -- TIER 6: Barrage
	{ "Explosive Trap", "modifier.multitarget", "ground" },
	{ "Black Arrow", { "modifier.multitarget", "!target.debuff", "target.deathin >= 8", "!target.state.charm" } },
	{ "Explosive Shot", { "modifier.multitarget", "player.buff(Lock and Load)" } },
	{ "Kill Shot", { "modifier.multitarget", "target.health <= 20" } },
	{ "Cobra Shot", { "modifier.multitarget", "player.focus < 40" } },
	
	-- Single Target
	{ "Explosive Shot", "player.buff(Lock and Load)" },
	{ "Glaive Toss" }, -- TIER 6: Glaive Toss --TODO: do range check
	{ "Powershot" }, -- TIER 6: Powershot
	{ "Barrage" }, -- TIER 6: Barrage
	{ "Serpent Sting", { "!target.debuff", "target.deathin >= 10", "!target.state.charm" } },
	{ "Explosive Shot" },
	{ "Kill Shot", "target.health <= 20" }, -- Kill Shot
	{ "Black Arrow", { "!target.debuff", "target.deathin >= 8", "!target.state.charm" } },
	{ "Multi-Shot", { "player.buff(Thrill of the Hunt)", "target.debuff(Serpent Sting).duration < 2" } },
	{ "Arcane Shot", "player.buff(Thrill of the Hunt)" },
	{ "Rapid Fire", { "pet.exists", "target.exists", "!@bbLib.playerHasted" } },
	{ "Dire Beast" }, -- TIER 4: Dire Beast
	{ "Stampede", { "pet.exists", "@bbLib.playerHasted" } },
	{ "Cobra Shot", "target.debuff(Serpent Sting).duration < 6" }, -- Cobra Shot if sting is about to drop.
	{ "Multi-Shot", { "player.focus >= 67", "toggle.cleavemode", "modifier.enemies > 1" } },
	{ "Explosive Trap", { "toggle.cleavemode", "modifier.enemies > 2" }, "ground" },
	{ "Arcane Shot", { "player.focus >= 67" } },
	{ "Cobra Shot", "player.spell(Explosive Shot).cooldown > 1" },
	{ "Cobra Shot", "player.focus < 40" },
	
},
{
	-- Pauses
    { "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(Feign Death)" },
	
	{ "Aspect of the Cheetah", { "toggle.aspect", "player.moving", "!player.buff(Aspect of the Cheetah)", "!player.buff(Aspect of the Pack)" } },
	{ "Camouflage", { "toggle.camomode", "!player.buff(Camouflage)", "!player.debuff(Orb of Power)" } }, 
	
	-- Pet
	{ "883", "!pet.exists" }, -- Call Pet 1
	{ "Revive Pet", "!pet.alive" },
    { "Mend Pet", { "pet.health <= 90", "pet.exists", "pet.alive", "!pet.buff(Mend Pet)" } },

	-- Traps
	{ "Explosive Trap", "modifier.lalt", "ground" },
    { "Ice Trap" , "modifier.lalt", "ground" },
	{ "Snake Trap" , "modifier.lalt", "ground" },
	{ "Freezing Trap" , "modifier.ralt", "ground" },
	
	-- Mark
	{ "Hunter's Mark", { "target.exists", "target.alive", "!target.debuff(Hunter's Mark).any" }, "target" },
	
	-- Food / Flask
	-- TODO: flask of spring blossoms
	-- TODO: food mist rice noodles
	-- TODO: PRE POT: virmens bite potion
	
}, 
function()
	ProbablyEngine.toggle.create('consume', 'Interface\\Icons\\inv_alchemy_endlessflask_06', 'Use Consumables', 'Toggle the usage of Flasks/Food/Potions etc..')
	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automaticaly target the nearest enemy when target dies or does not exist.')
	ProbablyEngine.toggle.create('aspect', 'Interface\\Icons\\ability_mount_jungletiger', 'Auto Aspect', 'Automatically switch aspect when moving and not in combat.')
	ProbablyEngine.toggle.create('mousesting', 'Interface\\Icons\\ability_hunter_quickshot', 'Auto Sting', 'Automatically cast Serpent Sting on mouseover targets.')
	ProbablyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'PvP', 'Toggle the usage of PvP abilities.')
	ProbablyEngine.toggle.create('camomode', 'Interface\\Icons\\ability_hunter_displacement', 'Camouflage', 'Toggle the usage Camouflage when out of combat.')
	ProbablyEngine.toggle.create('cleavemode', 'Interface\\Icons\\achievement_pvp_o_h', 'Cleave Mode', 'Toggle the usage of AoE abilities for 2 to 3 enemies.')

end)
