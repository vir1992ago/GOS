PrintChat("Karthus(Ilovesona) Plugin for CloudBot by medivih")
PrintChat("Credits: Ilovesona, Noddy and Cloud")
global_ticks = 0

OnLoop(function(myHero)

    killableInfo()
    AutoLevel()
    AutoBuy()
    AutoZhonia()
    AutoEmbrace()
    --SkillFarm() --Skill Farm causes to Suicide @Turrets

    local target = GetCurrentTarget()
    if ValidTarget(target, math.huge) then
        -- DrawText(GetObjectName(target),20,0,150,0xff00ff00)
        
            castE(target)
            castW(target)
            castQ(target)
        
    end
end)
-- Q farm
function SkillFarm()

      for _,Q in pairs(GetAllMinions(MINION_ENEMY)) do
        if IsInDistance(Q, 790) then
        local z = (GetCastLevel(myHero,_Q)*50)+(GetBonusDmg(myHero)*.7)
        local hp = GetCurrentHP(Q)
        local Dmg = CalcDamage(myHero, Q, z)
        if Dmg > hp then
            local EnemyPos = GetOrigin(Q)
            if CanUseSpell(myHero, _Q) == READY and IsInDistance(Q, 880) then
            CastSkillShot(_Q,EnemyPos.x,EnemyPos.y,EnemyPos.z)
end
end
end
end

end

-- End QFarm
-- Zhonya's Hourglass 3157 Cloud's code
function AutoZhonia()
    if GetItemSlot(myHero,3157) > 0 and ValidTarget(unit, 1000) and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.13 then
        CastTargetSpell(myHero, GetItemSlot(myHero,3157))
    end
end

--Auto Seraph's Embrace     3040
function AutoEmbrace()
    if GetItemSlot(myHero,3040) > 0  and ValidTarget(unit, 1000) and GetCurrentHP(myHero)/GetMaxHP(myHero) < 0.17 then
        CastTargetSpell(myHero, GetItemSlot(myHero,3040))
    end
end

--Karthus

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
    --Doran's Ring (1056)
        if GetItemSlot(myHero,1056) == 0 then 
        BuyItem(1056)
        end
    --Warding Totem (Trinket)     3340
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

function castQ( target )
    -- CastStartPosVec,EnemyChampionPtr,EnemyMoveSpeed,YourSkillshotSpeed,SkillShotDelay,SkillShotRange,SkillShotWidth,MinionCollisionCheck,AddHitBox;
    pred = GetPredictionForPlayer(GetOrigin(target),target,GetMoveSpeed(target),math.huge,500,GetCastRange(myHero,_Q),200,false,true)
    if IsInDistance(target, GetCastRange(myHero,_Q)) and CanUseSpell(myHero,_Q) == READY and pred.HitChance == 1 then   
        CastSkillShot(_Q,pred.PredPos.x,pred.PredPos.y,pred.PredPos.z)
    end
end

function castW( target )
    -- CastStartPosVec,EnemyChampionPtr,EnemyMoveSpeed,YourSkillshotSpeed,SkillShotDelay,SkillShotRange,SkillShotWidth,MinionCollisionCheck,AddHitBox;
    pred = GetPredictionForPlayer(GetOrigin(target),target,GetMoveSpeed(target),math.huge,500,GetCastRange(myHero,_W),800,false,true)
    if IsInDistance(target, GetCastRange(myHero,_W)) and CanUseSpell(myHero,_W) == READY and pred.HitChance == 1 then   
        CastSkillShot(_W,pred.PredPos.x,pred.PredPos.y,pred.PredPos.z)
    end
end

function castE( target )
    -- open E
    if IsInDistance(target, GetCastRange(myHero,_E)) and CanUseSpell(myHero,_E) == READY and GotBuff(myHero,"KarthusDefile") <= 0 then
        CastTargetSpell(myHero, _E)
    end

    -- close E
    if not IsInDistance(target, GetCastRange(myHero,_E)) and GotBuff(myHero,"KarthusDefile") > 0 then
        CastTargetSpell(myHero, _E)
    end
end

--Auto R
function killableInfo()
    -- no need show killable info when R in cd
    if CanUseSpell(myHero,_R) ~= READY then return end

    rDmg = 100 + GetCastLevel(myHero,_R) * 150 + GetBonusAP(myHero) * 0.6
    -- info = "R dmg : "..rDmg .. "\n"
    info = ""
    for nID, enemy in pairs(GetEnemyHeroes()) do
        if IsObjectAlive(enemy) then
            realdmg = CalcDamage(myHero, enemy, 0, rDmg)
            hp = GetCurrentHP(enemy)
            if realdmg > hp then
                info = info..GetObjectName(enemy)
                if not IsVisible(enemy) then
                    info = info.." maybe"
                    HoldPosition()
                    CastSpell(_R)
                end
                    HoldPosition()
                    CastSpell(_R)
                info = info.."  killable\n"
            end
            -- info = info..GetObjectName(enemy).."    HP:"..hp.."  dmg: "..realdmg.." "..killable.."\n"
        end
  end
  DrawText(info,40,500,0,0xffff0000) 
end