local framework = include("OperatorJack.MagickaExpanded.magickaExpanded")

require("OperatorJack.MagickaExpanded-LoreFriendlyPack.effects.banishDaedraEffect")
require("OperatorJack.MagickaExpanded-LoreFriendlyPack.effects.boundWeaponEffectSet")
require("OperatorJack.MagickaExpanded-LoreFriendlyPack.effects.boundArmorEffectSet")

local function registerSpells()
	framework.spells.createBasicSpell({
    id = "OJ_ME_BanishDaedra",
    name = "Banish Daedra",
    effect = tes3.effect.banishDaedra,
    range = tes3.effectRange.touch,
    min = 30,
    max = 50
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_BoundGreaves",
    name = "Bound Greaves",
    effect = tes3.effect.boundGreaves,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_BoundPauldrons",
    name = "Bound Pauldrons",
    effect = tes3.effect.boundPauldrons,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_BoundClaymore",
    name = "Bound Claymore",
    effect = tes3.effect.boundClaymore,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_BoundClub",
    name = "Bound Club",
    effect = tes3.effect.boundClub,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_BoundDaiKatana",
    name = "Bound Dai-Katana",
    effect = tes3.effect.boundDaiKatana,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_BoundKatana",
    name = "Bound Katana",
    effect = tes3.effect.boundKatana,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_BoundShortsword",
    name = "Bound Shortsword",
    effect = tes3.effect.boundShortSword,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_BoundStaff",
    name = "Bound Staff",
    effect = tes3.effect.boundStaff,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_BoundTanto",
    name = "Bound Tanto",
    effect = tes3.effect.boundTanto,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_BoundWakizashi",
    name = "Bound Wakizashi",
    effect = tes3.effect.boundWakizashi,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_BoundWarAxe",
    name = "Bound War Axe",
    effect = tes3.effect.boundWarAxe,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_BoundWarhammer",
    name = "Bound Warhammer",
    effect = tes3.effect.boundWarhammer,
    range = tes3.effectRange.self,
    duration = 30
  })
end

event.register("MagickaExpanded:Register", registerSpells)