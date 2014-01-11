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
  if UnitGroupRolesAssigned("player") ~= "TANK" or not IsInRaid() then
    return false
  end

  local otherTank
  for i = 1, GetNumGroupMembers() do
    local other = "raid" .. i
    if not otherTank and not UnitIsUnit("player", other) and UnitGroupRolesAssigned(other) == "TANK" then
      otherTank = other
    end
  end
  if not otherTank then return false end

  if UnitIsDeadOrGhost(otherTank) then return false end

  for i = 1, 4 do
    local bossID = "boss" .. i
    local boss = UnitID(bossID) -- /script print(UnitID("target"))
    if     boss == 71543 then -- Immersus
      if ProbablyEngine.dsl.get('debuff.any')(otherTank, 143437) or ProbablyEngine.dsl.get('debuff.any')(otherTank, 143436) then
        ProbablyEngine.dsl.parsedTarget = bossID
        return true
      end
    elseif boss == 71967 then -- Norushen
      if ProbablyEngine.dsl.get('buff.count')(otherTank, GetSpellID(146124)) then
        ProbablyEngine.dsl.parsedTarget = bossID
        return true
      end
    elseif boss == 71734 then -- Sha of Pride
      if ProbablyEngine.dsl.get('debuff.any')(otherTank, 144358) then
        ProbablyEngine.dsl.parsedTarget = bossID
        return true
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
