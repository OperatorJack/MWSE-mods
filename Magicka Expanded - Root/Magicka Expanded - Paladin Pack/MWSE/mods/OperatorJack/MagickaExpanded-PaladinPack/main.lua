local common = include("OperatorJack.MagickaExpanded.common")

require("OperatorJack.MagickaExpanded-PaladinPack.effects.lightDamageEffect")

local function registerSpells()
  common.createSimpleSpell({
    id = "OJ_ME_StendarrsAura",
    name = "Stendarr's Aura",
    effect = tes3.effect.lightDamage,
    range = tes3.effectRange.target,
    min = 10,
    max = 10,
    duration = 60,
    radius = 10
  })
  common.createSimpleSpell({
    id = "OJ_ME_StendarrsTouch",
    name = "Stendarr's Touch",
    effect = tes3.effect.lightDamage,
    range = tes3.effectRange.touch,
    min = 10,
    max = 50
  })
end

event.register("MagickaExpanded:Register", registerSpells)