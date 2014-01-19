bbLib = {}

function bbLib.bossMods()
	-- Darkmoon Faerie Cannon
	--if select(7, UnitBuffID("player", 102116)) 
	  --and select(7, UnitBuffID("player", 102116)) - GetTime() < 1.07 then 
		--CancelUnitBuff("player", "Magic Wings") 
	--end
	
	-- Raid Boss Checks
	if UnitExists("boss1") then
		for i = 1,4 do
			local bossCheck = "boss"..i
			if UnitExists(bossCheck) then
				local npcID = tonumber(UnitGUID(bossCheck):sub(6, 10), 16)
				--local bossCasting,_,_,_,_,castEnd = UnitCastingInfo(bossCheck)
				if npcID == 71515 then  -- SoO: General Nazgrim
					--if UnitBuffID("target", 71) then
						--SpellStopCasting()
						--return true
					--end
				end
			end
		end
	end
	return false
end

function bbLib.bossTaunt()
	-- Thanks to Rubim!
	-- Make sure we're a tank first and we're in a raid
	if UnitGroupRolesAssigned("player") == "TANK" and IsInRaid() then
		local otherTank
		for i = 1, GetNumGroupMembers() do
			local other = "raid" .. i
			if not otherTank and not UnitIsUnit("player", other) and UnitGroupRolesAssigned(other) == "TANK" then
				otherTank = other
			end
		end
		if otherTank and not UnitIsDeadOrGhost(otherTank) then
			for j = 1, 4 do
				local bossID = "boss" .. j
				local boss = UnitID(bossID) -- /script print(UnitID("target"))
				if     boss == 71543 then -- Immersus
					if UnitDebuff(otherTank, "Corrosive Blast") and not UnitDebuff("player", "Corrosive Blast") then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end 
				elseif boss == 72276 then -- Norushen
					local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Self Doubt") -- Possibly a buff?
					if debuffName and debuffCount > 2 and not UnitDebuff("player", "Self Doubt") then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end 
				elseif boss == 71734 then -- Sha of Pride
					if UnitDebuff(otherTank, "Wounded Pride") and not UnitDebuff("player", "Wounded Pride") then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 72249 then -- Galakras
					local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Flames of Galakrond")
					if debuffName and debuffCount > 2 and not UnitDebuff("player", "Flames of Galakrond") then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end  
				elseif boss == 71466 then -- Iron Juggernaut
					local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Ignite Armor")
					if debuffName and debuffCount > 1 and not UnitDebuff("player", "Ignite Armor") then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end  
				elseif boss == 71859 then -- Kor'kron Dark Shaman
					local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Froststorm Strike") -- Earthbreaker Haromm
					if debuffName and debuffCount > 4 and not UnitDebuff("player", "Froststorm Strike") then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end   
				elseif boss == 71515 then -- General Nazgrim
					local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Sundering Blow")
					if debuffName and debuffCount > 2 and not UnitDebuff("player", "Sundering Blow") then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71454 then -- Malkorok
					local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Fatal Strike")
					if debuffName and debuffCount > 11 and not UnitDebuff("player", "Fatal Strike") then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71529 then -- Thok the Bloodsthirsty
					local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Panic")
					if debuffName and debuffCount > 2 and not UnitDebuff("player", "Panic") then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
					local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Acid Breath")
					if debuffName and debuffCount > 2 and not UnitDebuff("player", "Acid Breath") then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end 
					local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Freezing Breath")
					if debuffName and debuffCount > 2 and not UnitDebuff("player", "Freezing Breath") then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end 
					local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Scorching Breath")
					if debuffName and debuffCount > 2 and not UnitDebuff("player", "Scorching Breath") then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71504 then -- Siegecrafter Blackfuse
					local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Electrostatic Charge")
					if debuffName and debuffCount > 3 and not UnitDebuff("player", "Electrostatic Charge") then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71865 then -- Garrosh Hellscream
					local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Gripping Despair")
					if debuffName and debuffCount > 2 and not UnitDebuff("player", "Gripping Despair") then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				end
			end
		end
	end
	return false
end

function bbLib.useAgiPot()
	-- 76089 = Virmen's Bite
	if GetItemCount(76089) > 1 
	  and GetItemCooldown(76089) == 0 
	  and ProbablyEngine.condition["modifier.cooldowns"] 
	  and (UnitBuff("player", 2825) or
		UnitBuff("player", 32182) or
		UnitBuff("player", 80353) or
		UnitBuff("player", 90355)) then 
		return true
	end
	return false
end

function bbLib.useIntPot()
	-- 114757 = Potion of the Jade Serpent
	if GetItemCount(114757) > 1 
	  and GetItemCooldown(114757) == 0 
	  and ProbablyEngine.condition["modifier.cooldowns"] then 
		return true
	end
	return false
end

function bbLib.useManaGem()
	-- 36799 = Mana Gem
	if GetItemCount(36799) > 0 
	  and GetItemCooldown(36799) == 0 then 
		return true
	end
	return false
end

function bbLib.isMounted()
	if IsMounted() then
		return true
	end
	return false
end

function bbLib.conjureManaGem()
	-- 36799 = Mana Gem
	if GetItemCount(36799) < 1 then -- TODO: make to work with charges
		return true
	end
	return false
end

bbLib.darkSimSpells = { "Froststorm Bolt","Arcane Shock","Rage of the Empress","Chain Lightning","Hex","Mind Control","Cyclone","Polymorph","Pyroblast","Tranquility","Divine Hymn","Hymn of Hope","Ring of Frost","Entangling Roots" }
function bbLib.useDarkSim(unit)
	-- Thanks to PCMD
	for index,spellName in pairs(pcmdDK.darkSimSpells) do
			if ProbablyEngine.condition["casting"](unit, spellName) then return true end
	end
	return false
end

function bbLib.isTargetingMe(target)
	if UnitExists(target) then
		return UnitGUID(target.."target") == UnitGUID("player")
	end
	return false
end

function bbLib.highThreatOnPlayerTarget(target)
	if UnitExists(target) and UnitExists("target") then
		local threat = UnitThreatSituation(target,"target")
		if threat and threat > 0 then --not tanking, higher threat than tank.
			return true
		end
	end
	return false
end

function bbLib.useHealthPot()
	-- 76098 = Master Health Potion
	if GetItemCount(76097) > 1 
	 and GetItemCooldown(76097) == 0 
	 and ProbablyEngine.condition["modifier.cooldowns"] then 
		return true
	end
	return false
end

function bbLib.playerHasted()
	if UnitBuff("player", "Rapid Fire")
	  or UnitBuff("player", "Bloodlust")
	  or UnitBuff("player", "Heroism")
	  or UnitBuff("player", "Time Warp")
	  or UnitBuff("player", "Ancient Hysteria") then 
		return true 
	end
	return false
end

function bbLib.BGFlag()
	if GetBattlefieldStatus(1)=='active' 
	  or GetBattlefieldStatus(2)=='active' then
		InteractUnit('Horde flag')
		InteractUnit('Alliance flag')
	end
	return false
end

ProbablyEngine.library.register("bbLib", bbLib)
