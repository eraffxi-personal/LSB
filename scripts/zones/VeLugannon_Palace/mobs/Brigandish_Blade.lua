-----------------------------------
-- Area: VeLugannon Palace
--   NM: Brigandish Blade
-----------------------------------
local ID = require("scripts/zones/VeLugannon_Palace/IDs")
require("scripts/globals/mobs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    mob:setUnkillable(true)
    mob:addListener("TAKE_DAMAGE", "BB_DAMAGE_TAKEN", function(mob, amount, optionalAttacker, attackType, damageType)
        local BUCCANEERS_KNIFE = (optionalAttacker:getEquipID(xi.slot.MAIN) == ID.weapon.BUCCANEERS_KNIFE) or (optionalAttacker:getEquipID(xi.slot.SUB) == ID.weapon.BUCCANEERS_KNIFE)
        if attackType == xi.attackType.PHYSICAL and damageType == xi.damageType.PIERCING and BUCCANEERS_KNIFE then
            mob:setUnkillable(false)
        end
    end)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TERROR, {chance = 30})
end

entity.onMobDeath = function(mob, player, isKiller)
    GetNPCByID(ID.npc.QM3):setLocalVar("PillarCharged", 1)
end

return entity
