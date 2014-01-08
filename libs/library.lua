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
				local bossCasting,_,_,_,_,castEnd = UnitCastingInfo(bossCheck)
				if npcID == 71515 then  -- SoO: General Nazgrim
					if UnitBuffID("target", 71) then
						SpellStopCasting()
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

function bbLib.isTargetingMe(target)
	if UnitExists(target) then
		return UnitGUID(target.."target") == UnitGUID("player")
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
