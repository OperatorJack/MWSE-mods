local framework = include("OperatorJack.MagickaExpanded.magickaExpanded")

require("OperatorJack.MagickaExpanded-PaladinPack.effects.lightDamageEffect")

local function registerSpells()
  framework.spells.createBasicSpell({
    id = "OJ_ME_StendarrsAuraSpell",
    name = "Stendarr's Aura",
    effect = tes3.effect.lightDamage,
    range = tes3.effectRange.target,
    min = 10,
    max = 10,
    duration = 60,
    radius = 10
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_StendarrsTouchSpell",
    name = "Stendarr's Touch",
    effect = tes3.effect.lightDamage,
    range = tes3.effectRange.touch,
    min = 10,
    max = 50
  })
end

event.register("MagickaExpanded:Register", registerSpells)