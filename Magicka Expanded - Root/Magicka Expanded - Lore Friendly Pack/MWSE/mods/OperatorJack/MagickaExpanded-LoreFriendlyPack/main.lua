local framework = include("OperatorJack.MagickaExpanded.magickaExpanded")

require("OperatorJack.MagickaExpanded-LoreFriendlyPack.effects.banishDaedraEffect")
require("OperatorJack.MagickaExpanded-LoreFriendlyPack.effects.boundWeaponEffectSet")
require("OperatorJack.MagickaExpanded-LoreFriendlyPack.effects.boundArmorEffectSet")

local function registerSpells()
	framework.spells.createBasicSpell({
    id = "OJ_ME_BanishDaedraSpell",
    name = "Banish Daedra",
    effect = tes3.effect.banishDaedra,
    range = tes3.effectRange.touch,
    min = 30,
    max = 50
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_BoundGreavesSpell",
    name = "Bound Greaves",
    effect = tes3.effect.boundGreaves,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_BoundPauldronsSpell",
    name = "Bound Pauldrons",
    effect = tes3.effect.boundPauldrons,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_BoundClaymoreSpell",
    name = "Bound Claymore",
    effect = tes3.effect.boundClaymore,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_BoundClubSpell",
    name = "Bound Club",
    effect = tes3.effect.boundClub,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_BoundDaiKatanaSpell",
    name = "Bound Dai-Katana",
    effect = tes3.effect.boundDaiKatana,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_BoundKatanaSpell",
    name = "Bound Katana",
    effect = tes3.effect.boundKatana,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_BoundShortswordSpell",
    name = "Bound Shortsword",
    effect = tes3.effect.boundShortSword,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_BoundStaffSpell",
    name = "Bound Staff",
    effect = tes3.effect.boundStaff,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_BoundTantoSpell",
    name = "Bound Tanto",
    effect = tes3.effect.boundTanto,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_BoundWakizashiSpell",
    name = "Bound Wakizashi",
    effect = tes3.effect.boundWakizashi,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_BoundWarAxeSpell",
    name = "Bound War Axe",
    effect = tes3.effect.boundWarAxe,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_BoundWarhammerSpell",
    name = "Bound Warhammer",
    effect = tes3.effect.boundWarhammer,
    range = tes3.effectRange.self,
    duration = 30
  })
end

event.register("MagickaExpanded:Register", registerSpells)