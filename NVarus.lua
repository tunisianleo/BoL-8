--[[ Varus Script by Nickieboy
		Script 
]]

if myHero.charName ~= "Varus" then return end

-- Download script
local version = 1.7
local author = "Nickieboy"
local SCRIPT_NAME = "NVarus"
local AUTOUPDATE = true
local UPDATE_HOST = "raw.github.com"
local UPDATE_PATH = "/Nickieboy/BoL/master/NVarus.lua".."?rand="..math.random(1,10000)
local UPDATE_FILE_PATH = SCRIPT_PATH..GetCurrentEnv().FILE_NAME
local UPDATE_URL = "https://"..UPDATE_HOST..UPDATE_PATH

function AutoupdaterMsg(msg) print("<font color=\"#6699ff\"><b>NVarus:</b></font> <font color=\"#FFFFFF\">"..msg..".</font>") end
if AUTOUPDATE then
	local ServerData = GetWebResult(UPDATE_HOST, "/Nickieboy/BoL/master/version/NVarus.version")
	if ServerData then
		ServerVersion = type(tonumber(ServerData)) == "number" and tonumber(ServerData) or nil
		if ServerVersion then
			if tonumber(version) < ServerVersion then
				AutoupdaterMsg("New version available "..ServerVersion)
				AutoupdaterMsg("Updating, please don't press F9")
				DelayAction(function() DownloadFile(UPDATE_URL, UPDATE_FILE_PATH, function () AutoupdaterMsg("Successfully updated. ("..version.." => "..ServerVersion.."), press F9 twice to load the updated version.") end) end, 3)
			else
				AutoupdaterMsg("You have got the latest version (v"..ServerVersion..") of NVarus by " .. author)
			end
		end
	else
		AutoupdaterMsg("Error downloading version info")
	end
end


-- Download Libraries
local REQUIRED_LIBS = {
	["SxOrbWalk"] = "https://raw.githubusercontent.com/Superx321/BoL/master/common/SxOrbWalk.lua",
	["VPrediction"] = "https://raw.githubusercontent.com/Hellsing/BoL/master/common/VPrediction.lua",
	["SourceLib"] = "https://raw.githubusercontent.com/Dienofail/BoL/master/common/SourceLib.lua",
	["SOW"] = "https://raw.github.com/Hellsing/BoL/master/common/SOW.lua"
}
local DOWNLOADING_LIBS, DOWNLOAD_COUNT = false, 0

function AfterDownload()
	DOWNLOAD_COUNT = DOWNLOAD_COUNT - 1
	if DOWNLOAD_COUNT == 0 then
		DOWNLOADING_LIBS = false
		print("<b><font color=\"#6699FF\">Required libraries downloaded successfully, please reload (double F9).</font>")
	end
end

for DOWNLOAD_LIB_NAME, DOWNLOAD_LIB_URL in pairs(REQUIRED_LIBS) do
	if FileExist(LIB_PATH .. DOWNLOAD_LIB_NAME .. ".lua") then
		require(DOWNLOAD_LIB_NAME)
	else
		DOWNLOADING_LIBS = true
		DOWNLOAD_COUNT = DOWNLOAD_COUNT + 1
		DownloadFile(DOWNLOAD_LIB_URL, LIB_PATH .. DOWNLOAD_LIB_NAME..".lua", AfterDownload)
	end
end

--- BoL Script Status Connector --- 
local ScriptKey = "WJMJPJQKQLP" -- NVarus auth key
local ScriptVersion = "1.7" -- Your .version file content

-- Thanks to Bilbao for his socket help & encryption
assert(load(Base64Decode("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"), nil, "bt", _ENV))() BolBoost( ScriptKey, ScriptVersion )
-----------------------------------

-- Local Variables
local Qspell = {name = "Piercing Arrow", duration = 1.25, speed = 1900, width = 60, delay = 0}
local Qrangemin = 850
local Qrangemax = 1800
local Wspell = {name = "Blighted Quiver"}
local Espell = {name = "Hail Of Arrows", duration = 0, range = 925, speed = 1750, width = 50, delay = 0.240}
local Rspell = {name = "Chain of Corruption", duration = 0, range = 1075, speed = 2000, width = 100, delay = 0.250}
local AA = 600
local Qready, Eready, Rready = false, false, false
local Qtarget, Etarget, Rtarget, AAtarget = nil
local EnemyMinions = minionManager(MINION_ENEMY, 625, myHero, MINION_SORT_HEALTH_ASC)
local farmMinions = 0

local myPos = myHero.pos
local targetPos = nil
local newPos = nil
local newTargetPos = nil
local xFurther = 0

local healPosition = nil
local ignite = nil
local barrier = nil

local Orbwalker = nil
local loaded = false

local passiveStacks = {}


-- Load when game loads
function OnLoad()
	VP = VPrediction()
	STS = SimpleTS(STS_LESS_CAST_PHYSICAL)
	DMG = DamageLib()

	--Register E and R damage
	DMG:RegisterDamageSource(_E, _PHYSICAL, 30, 65, _PHYSICAL, _AD, 0.6, function() return (myHero:CanUseSpell(_E) == READY) end)
	DMG:RegisterDamageSource(_R, _MAGIC, 50, 100, _MAGIC, _AP, 1.0, function() return (myHero:CanUseSpell(_R) == READY) end)

	-- Find heal
	if myHero:GetSpellData(SUMMONER_1).name:find("summonerheal") then 
		healPosition = SUMMONER_1
    elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerheal") then 
    	healPosition = SUMMONER_2
    end 

    if myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") then 
		ignite = SUMMONER_1
    elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") then 
    	ignite = SUMMONER_2
    end 

    if myHero:GetSpellData(SUMMONER_1).name:find("summonerbarrier") then 
		barrier = SUMMONER_1
    elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerbarrier") then 
    	barrier = SUMMONER_2
    end 

    for i, enemy in ipairs(GetEnemyHeroes()) do 
    	passiveStacks[enemy.networkID] = 0
    end 



    -- Draw Menu
    Menu()

	--Setting skillshots through SourceLib
	Q = Spell(_Q, Qrangemin, false)
	Q:SetSkillshot(VP, SKILLSHOT_LINEAR, Qspell.width, Q.delay, Qspell.speed, false)
	Q:SetCharged("VarusQ", 4, Qrangemax, 1.3)
	Q:SetAOE(true)

	--Set E
	E = Spell(_E, Espell.range, false)
	E:SetSkillshot(VP, SKILLSHOT_CIRCULAR, Espell.width, E.delay, Espell.speed, false)
	E:SetAOE(true)

	--Set R
	R = Spell(_R, Rspell.range, false)
	R:SetSkillshot(VP, SKILLSHOT_LINEAR, Rspell.width, R.delay, Rspell.speed, false)
	R:SetAOE(true)

end

-- Checks frequently
function OnTick()
	PerformChecks()

	if not loaded then
		CheckOrbWalker()
	end 

	if Menu.harass.harass then
		Harass()
	end 
	if Menu.combo.combo then
		Combo()
	end 

	if Menu.killsteal.killsteal then
		KillSteal()
	end 

	if VIP_USER then
		if Menu.misc.skinChanger.skinChanger and skinChanged()  then
			GenModelPacket("Varus", Menu.misc.skinChanger.skinChangerSlice)
	        lastSkin = Menu.misc.skinChanger.skinChangerSlice
		end 
 	end 

	if Menu.misc.autopotions.usePotion then
		DrinkPotions()
	end 

	if Menu.laneclear.laneclear then 
		LaneClear()
	end 

	if healPosition ~= nil then
		if Menu.misc.autoheal.useHeal then
			UseHeal()
		end 
	end 

	if ignite ~= nil then
		if Menu.misc.autoignite.useIgnite then
			UseIgnite()
		end 
	end 

	if barrier ~= nil then
		if Menu.misc.autobarrier.useBarrier then
			UseBarrier()
		end 
	end 

	CheckMenu()
end

-- Checks same with FPS
function OnDraw()
	if Menu.drawings.draw then
		if Menu.drawings.drawQ then
			DrawCircle(myHero.x, myHero.y, myHero.z, 1200, 0x111111)
		end

		if Menu.drawings.drawE then
			DrawCircle(myHero.x, myHero.y, myHero.z, Espell.range, 0x111111)
		end

		if Menu.drawings.drawR then
			DrawCircle(myHero.x, myHero.y, myHero.z, Rspell.range, 0x111111)
		end
		STS:OnDraw()
	end 

	if not loaded then
		DrawText3D("Choose an orbwalker", myHero.x, myHero.y + 50, myHero.z, 50, 4294967295, true)
	end
end

function PerformChecks()
	Qready = (myHero:CanUseSpell(_Q) == READY)
	Eready = (myHero:CanUseSpell(_E) == READY)
	Rready = (myHero:CanUseSpell(_R) == READY)
end 

function Combo()
	Qtarget = STS:GetTarget(Qrangemax)
	Etarget = STS:GetTarget(Espell.range)
	Rtarget = STS:GetTarget(Rspell.range)
	if Menu.combo.combo then
		if Menu.combo.comboQ.comboQ then

			if VIP_USER then
				if Menu.combo.comboQ.comboQinstant then
					if Qtarget and Qready then
						if passiveStacks[Qtarget.networkID] >= Menu.combo.comboQ.stacks then
							if Q:IsCharging() then

								local castPosition, hitChance, nTargets = Q:GetPrediction(Qtarget)
								if Q.range ~= Qrangemax and GetDistanceSqr(castPosition) < math.pow(Q.range - 200, 2) then
									Send2ndQPacket(castPosition)
								end 
							else
								Q:Charge()
							end 
						end 
					end
				end 

				if Menu.combo.comboQ.comboQmax then
					if Qtarget and Qready then
						if passiveStacks[Qtarget.networkID] >= Menu.combo.comboQ.stacks then
							if Q:IsCharging() then

								local castPosition, hitChance, nTargets = Q:GetPrediction(Qtarget)
								if Q.range == Qrangemax and GetDistanceSqr(castPosition) < math.pow(Q.range - 200, 2) then
									Send2ndQPacket(castPosition)
								end 
							else
								Q:Charge()
							end 
						end 
					end 
				end 

			else

				if Menu.combo.comboQ.comboQinstant then
					if Qtarget and Qready then
						if passiveStacks[Qtarget.networkID] >= Menu.combo.comboQ.stacks then
							if Q:IsCharging() then

								local castPosition, hitChance, nTargets = Q:GetPrediction(Qtarget)
								if Q.range ~= Qrangemax and GetDistanceSqr(castPosition) < math.pow(Q.range - 200, 2) then
									CastSpell(_Q, castPosition.x, castPosition.z)
								end 
							else
								Q:Charge()
							end 
						end 
					end
				end 

				if Menu.combo.comboQ.comboQmax then
					if Qtarget and Qready then
						if passiveStacks[Qtarget.networkID] >= Menu.combo.comboQ.stacks then
							if Q:IsCharging() then

								local castPosition, hitChance, nTargets = Q:GetPrediction(Qtarget)
								if Q.range == Qrangemax and GetDistanceSqr(castPosition) < math.pow(Q.range - 200, 2) then
									CastSpell(_Q, castPosition.x, castPosition.z)
								end 
							else
								Q:Charge()
							end 
						end 
					end 
				end 

			end 

		end 

		if Menu.combo.comboE.comboE then
			if Etarget and Eready then
				if Menu.combo.comboE.comboEinstant then
					E:Cast(Etarget.x, Etarget.z)
				end 
				if Menu.combo.comboE.comboEFurther then
					EnemyMovingFurtherAwayCastE(760, Etarget)
				end 
			end 
		end 
		

		if Menu.combo.comboR.comboR then
			if Rtarget and Rready then
				if Menu.combo.comboR.comboRinstant then
					R:Cast(Rtarget)
				end 
			end 
		end 
	end
end 

-- Harass
function Harass()
	if Menu.harass.harass then 
		Qtarget = STS:GetTarget(Qrangemax)
		Etarget = STS:GetTarget(E.range)
		if Qtarget and Menu.harass.harassQ and Qready then
			if Q:IsCharging() then
				local castPosition, hitChance, nTargets = Q:GetPrediction(Qtarget)
				if Q.range ~= Qrangemax and GetDistanceSqr(castPosition) < math.pow(Q.range - 200, 2) then
					Send2ndQPacket(castPosition)
				end 
			else
				Q:Charge()
			end 
			
		end 

		if Etarget and Menu.harass.harassE and Eready then
			E:Cast(Etarget.x, Etarget.z) 
		end 
	end 
end 

--Laneclear
function LaneClear()
	if Menu.laneclear.laneclear then
		EnemyMinions:update()
		if #EnemyMinions.objects >= 2 then
			farmMinions = SelectUnits(EnemyMinions.objects, function(t) return ValidTarget(t) end)
			if Menu.laneclear.laneclearQ and Qready then
				if Q:IsCharging() then
					local farmPos, farmHit = GetBestLineFarmPosition(Qrangemax, Qspell.width, farmMinions)
					if farmPos then
						if Q.range ~= Qrangemax and GetDistanceSqr(farmPos) < math.pow(Q.range - 200, 2) then
							Send2ndQPacket(farmPos)
						end 
					end 
				else
					Q:Charge()
				end 
			end 
		
			if Menu.laneclear.laneclearE and Eready then
				local farmPos2, farmHit2 = GetBestCircularFarmPosition(Espell.range, Espell.width, farmMinions)
				if farmPos2 then
					E:Cast(farmPos2.x, farmPos2.z)
				end 
			end 
		end 
	end 
end 


-- KillSteal
function KillSteal()
	for i, enemy in ipairs(GetEnemyHeroes()) do
		if Menu.killsteal.killstealAA then
			AATarget = STS:GetTarget(AA)
			if ValidTarget(enemy, AA) and AATarget then
				if DMG:IsKillable(enemy, {_AA}) then
					CastSpell(_AA, AATarget)
				end 
			end 
		end 

		if Menu.killsteal.killstealE then
			if (ValidTarget(enemy, Espell.range)) then
				if DMG:IsKillable(enemy, {_E}) then
					E:Cast(enemy.x, enemy.z)
				end 
			end 
		end 
	end 

end 

function Send2ndQPacket(to)
	local packet = CLoLPacket(0xE6)
	packet:EncodeF(myHero.networkID)
	packet:Encode1(190)
	packet:Encode1(0)
	packet:EncodeF(to.x)
	packet:EncodeF(to.y)
	packet:EncodeF(to.z)
	packet.dwArg1 = 1
	packet.dwArg2 = 0
	SendPacket(packet)
end

-- Credits to Devn for showing DelayAction
function EnemyMovingFurtherAwayCastE(range, target)
	if (target and ValidTarget(target, range)) then
		local distance = GetDistance(target, myHero)
		DelayAction(function(range, target)
			if (ValidTarget(target, range)) then
				local newDistance = GetDistance(target, myHero)
				if (newDistance > distance) then
					xFurther = xFurther + 1;
				else 
					xFurther = xFurther - 1;
				end 
				if (xFurther < 0) then
					xFurther = 0
				end 
				if (xFurther >= 5) then
					xFurther = 0
				end 
				if (myHero:CanUseSpell(_E) == READY) and xFurther >= 4 and ValidTarget(target, range) then
					E:Cast(target.x, target.z)
				end
			end
		end, 1, {range, target})
	end
end

-- Works, but gives error with LIB_PATH
--[[function EnemyMovingFurtherAway(range, target) 
	print("Going in function")
	myPos = myHero.pos

	if target then -- Don't need to check if target is valid because STS:GetTarget() does it automatically so you can just make sure it returned something.
		targetPos = target.pos
		--print("myPos = " .. myPos .. "  targetPos = " .. targetPos)
		print("Target = true, going into DelayAction")
		DelayAction(newPosition(target), 0.5)
		print("Ended function")
	end 
end 

function newPosition(target)
if (ValidTarget(target, range)) then --Check to make sure target is valid because if he isn't you WILL be spammed with errors.
				print ("Entered ValidTarget")
				newPos = myHero.pos
				newTargetPos = target.pos

				print("myPos " .. myPos.z)
				print("MyNewPos " .. newPos.z)
				print("oldEnemyPos " .. targetPos.z)
				print("newEnemyPos " .. newTargetPos.z)
				print("OldDistance " .. GetDistance(newTargetPos, newPos))
				print("NewDistance " .. GetDistance(targetPos, myPos))

				if GetDistance(newTargetPos, newPos) >= GetDistance(targetPos, myPos) then
					print("Entered Distance grows bigger")
					if (myHero:CanUseSpell(_E) == READY) then
						print("Casted E")
						E:Cast(target.x, target.z)
					end 
				end
			end
end 
]]



function HaveBuff(unit,buffname)
	local result = false
	for i = 1, unit.buffCount, 1 do 
		if unit:getBuff(i) ~= nil and unit:getBuff(i).name == buffname and unit:getBuff(i).valid and BuffIsValid(unit:getBuff(i)) then 
			result = true 
			break 
		end 
	end 
	return result
end 


-- Gapcloser (SourceLib TriggerCallbacks)
function castStunGapClosing(unit, spell)
	if Rready and GetDistance(unit) <= R.range then
		R:Cast(unit)
	end
end 

--Interuptable (SourceLib TriggerCallbacks)
function castStunInterruptable(unit, spell) 
	if Rready and GetDistance(unit) <= R.range then
		R:Cast(unit)
	end
end 

function UseHeal()
	health = myHero.health
	maxHealth = myHero.maxHealth

	if (myHero:CanUseSpell(healPosition) == READY) then
		if ((health / maxHealth) <= Menu.misc.autoheal.amountOfHealth) then
			CastSpell(healPosition)
		end 
	end 

	if Menu.misc.autoheal.amountOfHealth then
		for i, teammate in ipairs(GetAllyHeroes()) do
			if GetDistance(teammate, myHero) <= 700 then
				health = teammate.health
				maxHealth = teammate.maxHealth

				if ((health / maxHealth) <= Menu.misc.autoheal.amountOfHealth) then
					if (myHero:CanUseSpell(healPosition) == READY) then
						CastSpell(healPosition)
					end 
				end 
			end 
		end 
	end 
end 

function UseIgnite()
	local igniteT = STS:GetTarget(600)
	local igniteDMG = (50 + (20 * myHero.level)) * 5

	if igniteT ~= nil and (myHero:CanUseSpell(ignite) == READY) then
		if igniteT.health < igniteDMG then
			CastSpell(ignite, target)
		end 
	end 
end 

function UseBarrier()
	health = myHero.health
	maxHealth = myHero.maxHealth

	if (myHero:CanUseSpell(barrier) == READY) then
		if ((health / maxHealth) <= Menu.misc.autobarrier.amountOfHealth) then
			CastSpell(barrier)
		end 
	end 
end 

function DrinkPotions()
		health = myHero.health
		mana = myHero.mana
		maxHealth = myHero.maxHealth
		maxMana = myHero.maxMana
		
		DrinkHealth(health, maxHealth)
		DrinkMana(mana, maxMana)
end 

function DrinkHealth(h, mH) 
	if not HaveBuff(myHero, "RegenerationPotion") then
		if GetInventoryHaveItem(2003) then
			if (h / mH <= Menu.misc.autopotions.health) then
				CastItem(2003)
			end 
		end 
	end
end 

function DrinkMana(m, mM) 
	if not HaveBuff(myHero, "FlaskOfCrystalWater") then
		if GetInventoryHaveItem(2004) then
			if (m / mM <= Menu.misc.autopotions.mana) then
				CastItem(2004)
			end 
		end 
	end 
end 

function skinChanged()
        return Menu.misc.skinChanger.skinChangerSlice ~= lastSkin
end

function GenModelPacket(champ, skinId)
        p = CLoLPacket(0x97)
        p:EncodeF(myHero.networkID)
        p.pos = 1
        t1 = p:Decode1()
        t2 = p:Decode1()
        t3 = p:Decode1()
        t4 = p:Decode1()
        p:Encode1(t1)
        p:Encode1(t2)
        p:Encode1(t3)
        p:Encode1(bit32.band(t4,0xB))
        p:Encode1(1)--hardcode 1 bitfield
        p:Encode4(skinId)
        for i = 1, #champ do
                p:Encode1(string.byte(champ:sub(i,i)))
        end
        for i = #champ + 1, 64 do
                p:Encode1(0)
        end
        p:Hide()
        RecvPacket(p)
end

---[[ 
function OnGainBuff(unit, buff)
	if unit.isValid and unit.team ~= myHero.team and (buff.name == "varuswdebuff") and buff.valid then
		passiveStacks[unit.networkID] = 1
	end

	--]]
end

function OnUpdateBuff(unit, buff)
	if unit.isValid and unit.team ~= myHero.team and (buff.name == "varuswdebuff") and buff.valid then
		passiveStacks[unit.networkID] = buff.stack
	end
end

function OnLoseBuff(unit, buff)
	if unit.isValid and unit.team ~= myHero.team and (buff.name == "varuswdebuff") and buff.valid then
		passiveStacks[unit.networkID] = 0
	end
end

--]]

-- Draw Menu
function Menu()
	Menu = scriptConfig("NVarus by Nickieboy", "NVarus")

	 -- Combo
	Menu:addSubMenu("Combo", "combo")

 	Menu.combo:addParam("combo", "Combo", SCRIPT_PARAM_ONKEYDOWN, false, 32)
 	
 		-- Use Q in combo
 	Menu.combo:addSubMenu(Qspell.name .. " (Q)", "comboQ")
 	Menu.combo.comboQ:addParam("comboQ", "Use " .. Qspell.name .. " (Q)", SCRIPT_PARAM_ONOFF, true)
 	Menu.combo.comboQ:addParam("comboQmax", "Cast in full range", SCRIPT_PARAM_ONOFF, false)
 	Menu.combo.comboQ:addParam("comboQinstant", "Cast Q immediately", SCRIPT_PARAM_ONOFF, true)
 	Menu.combo.comboQ:addParam("stacks", "Use Q if x of passive", SCRIPT_PARAM_SLICE, 0, 0, 3, 0)

 		-- Use E in combo
 	Menu.combo:addSubMenu(Espell.name .. " (E)", "comboE")
 	Menu.combo.comboE:addParam("comboE", "Use " .. Espell.name .. " (E)", SCRIPT_PARAM_ONOFF, true)
 	Menu.combo.comboE:addParam("comboEinstant", "Cast instantly", SCRIPT_PARAM_ONOFF, false)
 	Menu.combo.comboE:addParam("comboEFurther", "Use if Enemy runs away", SCRIPT_PARAM_ONOFF, true)
 	
 		-- Use R in combo
 	Menu.combo:addSubMenu(Rspell.name .. " (R)", "comboR")
 	Menu.combo.comboR:addParam("comboR", "Use " .. Rspell.name .. " (R)", SCRIPT_PARAM_ONOFF, true)
 	Menu.combo.comboR:addParam("comboRinstant", "Use instantly", SCRIPT_PARAM_ONOFF, true)

 	 -- Harass
	Menu:addSubMenu("Harass", "harass")
 	Menu.harass:addParam("harass", "Harass", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("T"))
 	Menu.harass:addParam("harassQ", "Use " .. Qspell.name .. " (Q)", SCRIPT_PARAM_ONOFF, true)
 	Menu.harass:addParam("harassE", "Use " .. Espell.name .. " (E)", SCRIPT_PARAM_ONOFF, false)

 	Menu:addSubMenu("LaneClear", "laneclear")
 	Menu.laneclear:addParam("laneclear", "Laneclear", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("U"))
 	Menu.laneclear:addParam("laneclearQ", "Use " .. Qspell.name .. " (Q)", SCRIPT_PARAM_ONOFF, true)
 	Menu.laneclear:addParam("laneclearE", "Use " .. Espell.name .. " (E)", SCRIPT_PARAM_ONOFF, true)

 	 -- Combo
	Menu:addSubMenu("KillSteal", "killsteal")
 	Menu.killsteal:addParam("killsteal", "KillSteal", SCRIPT_PARAM_ONOFF, false)
 	Menu.killsteal:addParam("killstealAA", "Use AA", SCRIPT_PARAM_ONOFF, false)
 	Menu.killsteal:addParam("killstealE", "Use " .. Espell.name .. " (E)", SCRIPT_PARAM_ONOFF, false)

 	--Drawings
 	Menu:addSubMenu("Drawings", "drawings")
 	Menu.drawings:addParam("draw", "Use Drawings", SCRIPT_PARAM_ONOFF, true)
 	Menu.drawings:addParam("drawQ", "Draw " .. Qspell.name .. " (Q)", SCRIPT_PARAM_ONOFF, true)
 	Menu.drawings:addParam("drawE", "Draw " .. Espell.name .. " (E)", SCRIPT_PARAM_ONOFF, true)
 	Menu.drawings:addParam("drawR", "Draw " .. Rspell.name .. " (R)", SCRIPT_PARAM_ONOFF, true)
 	DMG:AddToMenu(Menu.drawings, {_AA, _AA, _AA, _E, _R})
 	Menu.drawings:addParam("damageAfter", "Damage after", SCRIPT_PARAM_INFO, "3 AA, E and R")

 	--Misc
 	Menu:addSubMenu("Misc", "misc")
 	
 	Menu.misc:addSubMenu("Auto Potions", "autopotions")
 	Menu.misc.autopotions:addParam("usePotion", "Use Potions Automatically", SCRIPT_PARAM_ONOFF, false)
 	Menu.misc.autopotions:addParam("health", "Health under %", SCRIPT_PARAM_SLICE, 0.25, 0, 1, 2)
 	Menu.misc.autopotions:addParam("mana", "Mana under %", SCRIPT_PARAM_SLICE, 0.25, 0, 1, 2)

 	if healPosition ~= nil then
	Menu.misc:addSubMenu("Auto Heal", "autoheal")
	Menu.misc.autoheal:addParam("useHeal", "Use Summoner Heal", SCRIPT_PARAM_ONOFF, false)
	Menu.misc.autoheal:addParam("amountOfHealth", "Under % of health", SCRIPT_PARAM_SLICE, 0, 0, 1, 2)
	Menu.misc.autoheal:addParam("helpHeal", "Use Heal to save teammates", SCRIPT_PARAM_ONOFF, false)
	end 

	if ignite ~= nil then
	Menu.misc:addSubMenu("Auto Ignite", "autoignite")
	Menu.misc.autoignite:addParam("useIgnite", "Use Summoner Ignite", SCRIPT_PARAM_ONOFF, false)
	end 

	if barrier ~= nil then
	Menu.misc:addSubMenu("Auto Barrier", "autobarrier")
	Menu.misc.autobarrier:addParam("useBarrier", "Use Summoner Barrier", SCRIPT_PARAM_ONOFF, false)
	Menu.misc.autobarrier:addParam("amountOfHealth", "Under % of health", SCRIPT_PARAM_SLICE, 0, 0, 1, 2)
	end 

	if VIP_USER then
		Menu.misc:addSubMenu("Skin Changer", "skinChanger")
		Menu.misc.skinChanger:addParam("skinChanger", "Change Skin (VIP)", SCRIPT_PARAM_ONOFF, false)
		Menu.misc.skinChanger:addParam("skinChangerSlice", "Change Skin", SCRIPT_PARAM_SLICE, 1, 1, 4, 0)
	end

 	Menu.misc:addSubMenu("Gapcloser", "gc")
	AntiGapcloser(Menu.misc.gc, castStunGapClosing)
	Menu.misc:addSubMenu("Interrupter", "ai")
	Interrupter(Menu.misc.ai, castStunInterruptable)

	Menu:addSubMenu("Target Selector", "sts")
	STS:AddToMenu(Menu.sts)

	--Orbwalker
	Menu:addSubMenu("OrbWalker", "orbwalker")
	Menu.orbwalker:addParam("sxorbwalk", "Use SxOrbWalk", SCRIPT_PARAM_ONOFF, false)
	Menu.orbwalker:addParam("sow", "Use SOW", SCRIPT_PARAM_ONOFF, false)


	-- Permashow
  	Menu.combo:permaShow("combo")
  	Menu.harass:permaShow("harass")
  	Menu.killsteal:permaShow("killsteal")
  	Menu.drawings:permaShow("draw")
  	Menu.misc:permaShow("gc")
  	Menu.misc:permaShow("ai")
end

function CheckOrbWalker()

	if Menu.orbwalker.sxorbwalk then
		Orbwalker = SxOrbWalk(VP)
		Orbwalker:LoadToMenu(Menu.orbwalker)
		loaded = true
	end 

	if Menu.orbwalker.sow then
		Orbwalker = SOW(VP)
		Orbwalker:LoadToMenu(Menu.orbwalker, STS)
		loaded = true
	end 
end 


function CheckMenu()
	if Menu.combo.comboE.comboEFurther then
		Menu.combo.comboE.comboEinstant = false
	end 

	if Menu.combo.comboE.comboEinstant then
		Menu.combo.comboE.comboEFurther = false
	end 

	if Menu.combo.comboQ.comboQmax then
		Menu.combo.comboQ.comboQinstant = false
	end 

	if Menu.combo.comboQ.comboQinstant then
		Menu.combo.comboQ.comboQmax = false
	end 

	if Menu.orbwalker.sxorbwalk then
		Menu.orbwalker.sow = false
		Menu.orbwalker.sxorbwalk = true
	end

	if Menu.orbwalker.sow then
		Menu.orbwalker.sxorbwalk = false
		Menu.orbwalker.sow = true
	end 
end 



