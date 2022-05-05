-----------------------------------
-- Area: Horlais Peak
--  Mob: Chlevnik
-- KSNM99
-----------------------------------

require("scripts/globals/status")

local entity = {}

entity.onMobSpawn = function(mob)
    mob:setUnkillable(true)
    mob:addListener("TAKE_DAMAGE", "CHLEVNIK_DAMAGE_TAKEN", function(mob, amount, optionalAttacker, attackType, damageType)
        if mob:getHP() < amount then
            if mob:getLocalVar("finalMeteor") == 0 then
                mob:setLocalVar("finalMeteor",1)
                mob:setMobMod(xi.mobMod.NO_MOVE, 1)
                mob:SetMagicCastingEnabled(false)
                mob:SetAutoAttackEnabled(false)
                mob:SetMobAbilityEnabled(false)
                mob:addStatusEffect(xi.effect.FAST_CAST, 90, 0, 60)               
                mob:setAnimationSub(5)
                mob:castSpell(218)
            end
        end
    end)
    mob:addListener("MAGIC_STATE_EXIT","CHLEVNIK_METEOR_CHECK",function(mob, spell)
        print("spellcheck")
        if spell:getID() == 218 and mob:getLocalVar("finalMeteor") == 1 then        
            mob:setUnkillable(false)
            mob:setHP(0)
        end        
    end)
end

entity.onMobDeath = function(mob, player, isKiller)
end



return entity
