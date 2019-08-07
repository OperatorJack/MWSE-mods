local framework = include("OperatorJack.MagickaExpanded.magickaExpanded")

require("OperatorJack.MagickaExpanded-DAndDPack.effects.blinkEffect")

local function registerSpells()
  framework.spells.createBasicSpell({
    id = "OJ_ME_Blink",
    name = "Blink",
    effect = tes3.effect.blink,
    range = tes3.effectRange.target
  })
end

event.register("MagickaExpanded:Register", registerSpells)