-- ProbablyEngine Rotation Packager
-- Custom Survival Hunter Rotation
-- Created on Dec 25th 2013 1:00 am
ProbablyEngine.rotation.register_custom(255, "bbHunterSurvival", {
-- PLAYER CONTROLLED: Rabid MUST be on Auto-Cast for Stampede pets to use them :)
-- SUGGESTED TALENTS:
-- CONTROLS: Pause - Left Control, Explosive/Ice/Snake Traps - Left Alt, Freezing Trap - Right Alt, Scatter Shot - Right Control

-- COMBAT
	-- Rotation Utilities
	-- TODO: Explosive Trap timer cooldown OSD
	-- cant place traps without target?
    { "pause", "modifier.lcontrol" },
	{ "pause", "@bbLib.bossMods" },
	{ "pause", "player.buff(5384)" }, -- Feign Death
	{ "pause", { "toggle.pvpmode", "@bbLib.BGFlag" } },
	{ "/targetenemy [noexists]", { "toggle.autotarget", "!target.exists" } },
	{ "/targetenemy [dead]", { "toggle.autotarget", "target.exists", "target.dead" } },
	
	--{ "pause", "player.time >= 300", "toggle.dpstest" } },

	-- Interrupts
    { "147362", { "modifier.interruptAt(80)", "player.range < 40" } }, -- Counter Shot
	
    -- Pet
    { "883", { "toggle.callpet", "!pet.exists" } }, -- Call Pet 1
    { "55709", "!pet.alive" }, -- Heart of the Phoenix
	{ "136", { "pet.health <= 50", "pet.exists", "!pet.buff(136)", "pet.range < 40" } }, -- Mend Pet

	-- PvP Abilities
	{ "53271", "player.state.disorient" }, -- Master's Call
    { "53271", "player.state.stun" }, -- Master's Call
    { "53271", "player.state.root" }, -- Master's Call
    { "53271", "player.state.snare" }, -- Master's Call
	{ "19503", { "toggle.mouseovers", "toggle.pvpmode", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient",  -- Scatter Shot
		"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root", 
		"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.disorient" }, "mouseover" }, -- If casting too?
	{ "19503", { "modifier.rcontrol", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient", -- Scatter Shot
		"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root", 
		"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.disorient" }, "mouseover" },
	{ "19386", { "toggle.mouseovers", "toggle.pvpmode", "player.spell(19503).cooldown > 0", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient", -- Wyvern Sting
		"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root", 
		"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.sleep" }, "mouseover" }, -- If casting too?
	{ "19386", { "modifier.rcontrol", "player.spell(19503).cooldown > 0", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.status.disorient", -- Wyvern Sting
		"!mouseover.status.sleep", "!mouseover.status.incapacitate", "!mouseover.status.fear", "!mouseover.status.misc", "!mouseover.status.root", 
		"!mouseover.status.stun", "!mouseover.status.snare", "!mouseover.immune.all", "!mouseover.immune.sleep" }, "mouseover" }, 
	{ "13809", { "modifier.rcontrol", "player.spell(19503).cooldown > 0", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "mouseover.status.disorient", -- Ice Trap on Scatter Shot targets
		"!mouseover.immune.all", "!mouseover.immune.sleep" }, "ground" }, 
	-- TODO: Binding Shot (ground)
	-- TODO: Reactive Deterrence
	{ "1513", { "toggle.mouseovers", "toggle.pvpmode", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.debuff(1513)", "mouseover.creatureType(Beast)" }, "mouseover" }, -- Scare Beast
	{ "1513", { "toggle.pvpmode", "target.exists", "target.enemy", "target.alive", "!target.debuff(1513)", "target.creatureType(Beast)" } }, -- Scare Beast
	
    -- Mouseovers
	{ "1978", { "!modifier.pvpmode", "toggle.mouseovers", "mouseover.exists", "mouseover.enemy", "mouseover.alive", "!mouseover.debuff(118253)", -- Serpent Sting
		"!mouseover.state.charm", "mouseover.deathin > 10" }, "mouseover" },
	
	-- Traps
	{ "77769", { "modifier.lalt", "!player.buff" } }, -- Trap Launcher
    { "13813", "modifier.lalt", "ground" }, -- Explosive Trap
    { "13809" , "modifier.lalt", "ground" }, -- Ice Trap
	{ "34600" , "modifier.lalt", "ground" }, -- Snake Trap
	{ "1499" , "modifier.ralt", "ground" }, -- Freezing Trap
	
    -- Tranq Shot
    { "19801", "target.dispellable(19801)", "target" }, -- Tranquilizing Shot

	-- TODO: Boss Functions + hold cooldowns
	-- TODO: Energy Pooling Toggle

    -- Misdirect ( focus -> tank -> pet )
	{{
		{ "34477", { "focus.exists", "focus.alive", "!player.buff(34477)", "target.threat > 60" }, "focus" }, -- Misdirection
		{ "34477", { "tank.exists", "tank.alive", "!focus.exists", "target.threat > 60" }, "tank" }, -- Misdirection
		{ "34477", { "pet.exists", "pet.alive", "!focus.exists", "!tank.exists", "target.threat > 60" }, "pet" }, -- Misdirection
	}, {
		"toggle.misdirect", "!toggle.pvpmode", "!target.isPlayer", "!player.buff(34477)", "@bbLib.canMisdirect" 
	}},

	-- Stances
    { "109260", { "toggle.aspect", "!player.buff(13165)", "!player.buff(109260)", "!player.moving" } }, -- Aspect of the Iron Hawk
    { "13165", { "toggle.aspect", "!player.buff(13165)", "!player.buff(109260)", "!player.moving" } }, -- Aspect of the Hawk
	
	
	-- Pre DPS Pause
	{ "pause", "target.debuff(19386).any" }, -- Wyvern Sting
	{ "pause", "target.debuff(19503).any" }, -- Scatter Shot
	{ "pause", "target.immune.all" },
	{ "pause", "target.status.disorient" },
	{ "pause", "target.status.incapacitate" },
	{ "pause", "target.status.sleep" },

	-- Cooldowns
	{ "109304", { "modifier.cooldowns", "player.health < 50" } }, -- Exhilaration
	{ "#5512", { "modifier.cooldowns", "player.health < 40" } }, -- Healthstone (5512)
	--{ "#76097", { "modifier.cooldowns", "player.health < 40", "@bbLib.useHealthPot" } }, -- Master Healing Potion (76097) 
	{ "#76089", { "modifier.cooldowns", "toggle.consume", "pet.exists", "target.exists", "player.hashero", "@bbLib.useAgiPot" } }, -- Agility Potion (76089)
	{ "20572", "modifier.cooldowns" }, -- Blood Fury (AP)
	{ "#gloves", { "modifier.cooldowns", "pet.exists", "target.exists" } }, -- Synapse Springs
	{ "26297", { "modifier.cooldowns", "pet.exists", "target.exists", "!player.hashero", "!player.buff(3045)" } }, -- Berserking

	-- PvP


	-- Dual Use
	{ "82726", "player.focus <= 50" }, -- TIER 4: Fervor
	{ "131894" }, -- TIER 5: A Murder of Crows
	{ "120697" }, -- TIER 5: Lynx Rush
	
	-- Multi Target
	{ "2643", "modifier.multitarget" }, -- Multi-Shot
	{ "117050", "modifier.multitarget" }, -- TIER 6: Glaive Toss --TODO: do range check
	{ "109259", "modifier.multitarget" }, -- TIER 6: Powershot
	{ "120360", "modifier.multitarget" }, -- TIER 6: Barrage
	{ "13813", "modifier.multitarget", "ground" }, --  Explosive Trap
	{ "3674", { "modifier.multitarget", "!target.debuff", "target.deathin >= 8", "!target.state.charm" } }, -- Black Arrow
	{ "53301", { "modifier.multitarget", "player.buff(56343)" } }, -- Explosive Shot, Lock and Load
	{ "53351", { "modifier.multitarget", "target.health <= 20" } }, -- Kill Shot
	{ "77767", { "modifier.multitarget", "player.focus < 40" } }, -- Cobra Shot
	
	-- Single Target
	{ "53301", "player.buff(56343)" }, -- Explosive Shot, Lock and Load
	{ "117050" }, -- TIER 6: Glaive Toss --TODO: do range check
	{ "109259" }, -- TIER 6: Powershot
	{ "120360" }, -- TIER 6: Barrage
	{ "1978", { "!target.debuff(118253)", "target.deathin >= 10", "!target.state.charm" } }, -- Serpent Sting
	{ "53301" }, -- Explosive Shot
	{ "53351", "target.health <= 20" }, -- Kill Shot
	{ "5116", { "toggle.pvpmode", "!target.debuff(5116).any", "target.moving", "!target.immune.snare" } }, -- PvP: Concussive Shot
	{ "82654", { "toggle.pvpmode", "!target.debuff(82654).any", "target.health > 20" } }, -- PvP: Widow Venom
	{ "3674", { "!target.debuff", "target.deathin >= 8", "!target.state.charm" } }, -- Black Arrow
	{ "2643", { "player.buff(34720)", "target.debuff(118253).duration < 2" } }, -- Multi-Shot, Thrill of the Hunt, Serpent Sting
	{ "2643", { "toggle.cleavemode", "player.buff(34720)" } }, -- Multi-Shot, Thrill of the Hunt
	{ "3044", "player.buff(34720)" }, -- Arcane Shot, Thrill of the Hunt
	{ "3045", { "modifier.cooldowns", "pet.exists", "target.exists", "!player.hashero" } }, -- Rapid Fire
	{ "120679" }, -- TIER 4: Dire Beast -- Dire Beast
	{ "121818", { "modifier.cooldowns", "pet.exists", "player.hashero" } }, -- Stampede
	{ "121818", { "modifier.cooldowns", "pet.exists", "player.buff(3045)" } }, -- Stampede
	{ "77767", "target.debuff(118253).duration < 6" }, -- Cobra Shot, Serpent Sting
	{ "2643", { "toggle.cleavemode", "player.focus >= 67", "modifier.enemies > 1" } }, -- Multi-Shot
	{ "13813", { "toggle.cleavemode", "modifier.enemies > 2" }, "ground" }, --  Explosive Trap
	{ "3044", { "player.focus >= 67" } }, -- Arcane Shot
	{ "77767", "player.spell(53301).cooldown > 1" }, -- Cobra Shot, Explosive Shot
	{ "77767", "player.focus < 40" }, -- Cobra Shot
	
},
{
	-- Pauses
    { "pause", "modifier.lcontrol" },
	{ "pause", "player.buff(5384)" }, -- Feign Death
	
	{ "5118", { "toggle.aspect", "player.moving", "!player.buff(5118)", "!player.buff(13159)" } }, -- Aspect of the Cheetah, 
	{ "51753", { "toggle.camomode", "!player.buff(51753)", "!player.debuff(Orb of Power)" } }, -- Camouflage
	
	-- Pet
	{ "883", { "toggle.callpet", "!pet.exists" } }, -- Call Pet 1
	--{ "982", "!pet.alive" }, -- Revive Pet
    { "136", { "pet.health <= 90", "pet.exists", "pet.alive", "!pet.buff(136)" } }, -- Mend Pet

	-- Traps
    { "13813", "modifier.lalt", "ground" }, -- Explosive Trap
    { "13809" , "modifier.lalt", "ground" }, -- Ice Trap
	{ "34600" , "modifier.lalt", "ground" }, -- Snake Trap
	{ "1499" , "modifier.ralt", "ground" }, -- Freezing Trap
	
	-- Mark
	{ "1130", { "target.exists", "target.alive", "!target.debuff(1130).any" }, "target" }, -- Hunter's Mark
	
	-- Food / Flask
	-- TODO: flask of spring blossoms
	-- TODO: food mist rice noodles
	-- TODO: PRE POT: Virmen's Bite potion
	
}, 
function()
	ProbablyEngine.toggle.create('callpet', 'Interface\\Icons\\ability_hunter_beastcall', 'Call Pet 1', 'Toggle to keep the pet in your first pet slot out.')
	ProbablyEngine.toggle.create('misdirect', 'Interface\\Icons\\ability_hunter_misdirection', 'Auto Misdirect', 'Toggle to automatically misdirect to your Focus>Tank>Pet when high on threat.')
	ProbablyEngine.toggle.create('consume', 'Interface\\Icons\\inv_alchemy_endlessflask_06', 'Use Consumables', 'Toggle the usage of Flasks/Food/Potions etc..')
	ProbablyEngine.toggle.create('autotarget', 'Interface\\Icons\\ability_hunter_snipershot', 'Auto Target', 'Automatically target the nearest enemy when target dies or does not exist.')
	ProbablyEngine.toggle.create('aspect', 'Interface\\Icons\\ability_mount_jungletiger', 'Auto Aspect', 'Automatically switch aspect when moving and not in combat.')
	ProbablyEngine.toggle.create('mouseovers', 'Interface\\Icons\\ability_hunter_quickshot', 'Use Mouseovers', 'Toggle automatic usage of stings/scatter/etc on eligible mouseover targets.')
	ProbablyEngine.toggle.create('pvpmode', 'Interface\\Icons\\achievement_pvp_o_h', 'Enable PvP', 'Toggle the usage of PvP abilities.')
	ProbablyEngine.toggle.create('camomode', 'Interface\\Icons\\ability_hunter_displacement', 'Use Camouflage', 'Toggle the usage Camouflage when out of combat.')
	ProbablyEngine.toggle.create('cleavemode', 'Interface\\Icons\\ability_upgrademoonglaive', 'Cleave Mode', 'Toggle the automatic usage of AoE abilities for 2 to 3 enemies.')

end)
