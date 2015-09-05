PrintChat("Blitzcrank(Deftsu) Plugin for CloudBot by medivih")
PrintChat("Credits: Deftsu, Ilovesona, Noddy and Cloud")
--
-- ATENTION, this code dont work YET, Work in progress!!!
--
Config = scriptConfig("Blitzcrank", "Blitzcrank:")
Config.addParam("Q", "Use Q", SCRIPT_PARAM_ONOFF, true)
Config.addParam("W", "Use W", SCRIPT_PARAM_ONOFF, true)
Config.addParam("E", "Use E", SCRIPT_PARAM_ONOFF, true)
Config.addParam("R", "Use R", SCRIPT_PARAM_ONOFF, true)
KSConfig = scriptConfig("KS", "Killsteal:")
KSConfig.addParam("KSQ", "Killsteal with Q", SCRIPT_PARAM_ONOFF, true)
KSConfig.addParam("KSR", "Killsteal with R", SCRIPT_PARAM_ONOFF, true)
HarassConfig = scriptConfig("Harass", "Harass:")
HarassConfig.addParam("HarassQ", "Harass Q (C)", SCRIPT_PARAM_ONOFF, true)
HarassConfig.addParam("HarassE", "Harass E (C)", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig = scriptConfig("Drawings", "Drawings:")
DrawingsConfig.addParam("DrawQ","Draw Q", SCRIPT_PARAM_ONOFF, true)
DrawingsConfig.addParam("DrawR","Draw R", SCRIPT_PARAM_ONOFF, true)

myIAC = IAC()

OnLoop(function(myHero)
Drawings()
Killsteal()
InterrupterR()
AutoLevel()
AutoBuy()

        --if IWalkConfig.Combo then -- if enemy low life
	      local target = GetTarget(1000, DAMAGE_MAGIC)
	              	
		        local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1800,250,GetCastRange(myHero,_Q),70,true,true)
                        if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(target, GetCastRange(myHero,_Q)) and Config.Q then
                        CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
	                end
                          
                        if CanUseSpell(myHero, _W) == READY and ValidTarget(target, 700) and GetDistance(myHero, target) > 200 and Config.W then
                        CastSpell(_W)
		        end
			
                        if CanUseSpell(myHero, _E) == READY and ValidTarget(target, 250) and Config.E then
                        CastSpell(_E)
		        end
		              
		        if CanUseSpell(myHero, _R) == READY and ValidTarget(target, GetCastRange(myHero,_R)) and Config.R then
                        CastSpell(_R)
	                end
	                      
	end	
	
	
end)

function Killsteal()
        for i,enemy in pairs(GetEnemyHeroes()) do
	    local QPred = GetPredictionForPlayer(GetMyHeroPos(),target,GetMoveSpeed(target),1800,250,GetCastRange(myHero,_Q),70,true,true)
  	    if CanUseSpell(myHero, _Q) == READY and QPred.HitChance == 1 and ValidTarget(enemy,GetCastRange(myHero,_Q)) and KSConfig.KSQ and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, (55*GetCastLevel(myHero,_Q)+25+GetBonusAP(myHero))) then 
            CastSkillShot(_Q,QPred.PredPos.x,QPred.PredPos.y,QPred.PredPos.z)
            elseif CanUseSpell(myHero, _R) == READY and ValidTarget(enemy,GetCastRange(myHero,_R)) and KSConfig.KSR and GetCurrentHP(enemy) < CalcDamage(myHero, enemy, 0, (125*GetCastLevel(myHero,_R)+125+GetBonusAP(myHero))) then
            CastSpell(_R)
	    end
	end
end

function Drawings()
myHeroPos = GetOrigin(myHero)
if CanUseSpell(myHero, _Q) == READY and DrawingsConfig.DrawQ then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_Q),3,100,0xff00ff00) end
if CanUseSpell(myHero, _R) == READY and DrawingsConfig.DrawR then DrawCircle(myHeroPos.x,myHeroPos.y,myHeroPos.z,GetCastRange(myHero,_R),3,100,0xff00ff00) end
end

function InterrupterR()
	addInterrupterCallback(function(unit, spellType)
  if IsInDistance(unit, 640) and CanUseSpell(myHero,_R) == READY then
    local EPred = GetPredictionForPlayer(GetMyHeroPos(),unit,GetMoveSpeed(unit),1200,250,GetCastRange(myHero, _E),60,true,true)
 if Config.EI and EPred.HitChance == 1 and ValidTarget(unit, 590) then
    CastSkillShot(_E,EPred.PredPos.x,EPred.PredPos.y,EPred.PredPos.z)   
end
end
end)
end

--Blitzcrank
function AutoLevel() -- Credits Inferno
local leveltable = { _Q, _E, _Q, _W, _Q, _R, _Q, _E, _Q, _E, _R, _E, _E, _W, _W, _R, _W, _W}
LevelSpell(leveltable[GetLevel(myHero)])
end

--AutoBuy function
function AutoBuy()

--Starting Itens
---- 2 Potions 2003

    if GetLevel(myHero) == 1 then
        if GetItemSlot(myHero,2003) == 0 or GetItemSlot(myHero,2003) < 2 then 
        BuyItem(2003)
        end
    --Relic Shield 	3302
        if GetItemSlot(myHero,3302) == 0 then 
        BuyItem(3302)
        end
    --Warding Totem (Trinket)  3340
        if GetItemSlot(myHero,3340) == 0 then 
        BuyItem(3340)
        end
    end

    --Greater Totem (Trinket)    3361
    if GetLevel(myHero) >= 9 then
        if GetItemSlot(myHero,3361) == 0 or GetItemSlot(myHero,3361) < 1 then 
        BuyItem(3361)
        end
    end
    --end
    
    --Wards--
    --Stealth Ward (2044) green
    --Vision Ward (2043) pink


    --Sightstone (2049)
    --Sweeping Lens (Trinket) 	3341 


Ticker = GetTickCount()
if (global_ticks + 5000) < Ticker then
    -- Potion
        if GetItemSlot(myHero,2003) == 0 or GetItemSlot(myHero,2003) < 2 and GetLevel(myHero) > 1  then 
        BuyItem(2003)
        end

    --Tear of the Goddess   3070
        if GetItemSlot(myHero,3070) == 0 and GetItemSlot(myHero,3003) == 0 and GetItemSlot(myHero,3040) == 0 then 
        BuyItem(3070)
        --Boots of Speed (1001)
        elseif GetItemSlot(myHero,1001) == 0 and GetItemSlot(myHero,3020) == 0 then 
        BuyItem(1001)
        end
        
        --Needlessly Large Rod 1058
        if GetItemSlot(myHero,1058) == 0 then 
        BuyItem(1058)
        --Zhonya's Hourglass 3157
        elseif GetItemSlot(myHero,3157) == 0 then 
        BuyItem(3157)
        --Sorcerer's Shoes 3020
        elseif GetItemSlot(myHero,3020) == 0 then           
            BuyItem(3020)
        --Archangel's Staff 3003
        elseif GetItemSlot(myHero,3003) == 0 then           
            BuyItem(3003)
        elseif GetItemSlot(myHero,1058) == 0 then 
        BuyItem(1058)
        --Elixir of Sorcery 2139
        elseif GetItemSlot(myHero,2139) == 0 and GetLevel(myHero) >= 9 and GetItemSlot(myHero,3003) == 1 and GetItemSlot(myHero,3040) == 1  then 
        BuyItem(2139)
        --Rabadon's Deathcap 3089
        elseif GetItemSlot(myHero,3089) == 0 then 
        BuyItem(3089)
        CastSpell(3089)      
        end
    
-- end do ticker
end
-- end func           
end