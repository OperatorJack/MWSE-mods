local framework = include("OperatorJack.MagickaExpanded.magickaExpanded")

require("OperatorJack.MagickaExpanded-TeleportationPack.effects.teleportationEffectSet")

local function registerSpells()
  framework.spells.createBasicSpell({
    id = "OJ_ME_TeleportToAldRuhn",
    name = "Teleport to Ald-Ruhn",
    effect = tes3.effect.teleportToAldRuhn,
    range = tes3.effectRange.self
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_TeleportToBalmora",
    name = "Teleport to Balmora",
    effect = tes3.effect.teleportToBalmora,
    range = tes3.effectRange.self
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_TeleportToEbonheart",
    name = "Teleport to Ebonheart",
    effect = tes3.effect.teleportToEbonheart,
    range = tes3.effectRange.self
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_TeleportToVivec",
    name = "Teleport to Vivec",
    effect = tes3.effect.teleportToVivec,
    range = tes3.effectRange.self
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_TeleportToCaldera",
    name = "Teleport to Caldera",
    effect = tes3.effect.teleportToCaldera,
    range = tes3.effectRange.self
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_TeleportToGnisis",
    name = "Teleport to Gnisis",
    effect = tes3.effect.teleportToGnisis,
    range = tes3.effectRange.self
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_TeleportToMaarGan",
    name = "Teleport to Maar Gan",
    effect = tes3.effect.teleportToMaarGan,
    range = tes3.effectRange.self
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_TeleportToMolagMar",
    name = "Teleport to Molag Mar",
    effect = tes3.effect.teleportToMolagMar,
    range = tes3.effectRange.self
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_TeleportToPelagiad",
    name = "Teleport to Pelagiad",
    effect = tes3.effect.teleportToPelagiad,
    range = tes3.effectRange.self
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_TeleportToSuran",
    name = "Teleport to Suran",
    effect = tes3.effect.teleportToSuran,
    range = tes3.effectRange.self
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_TeleportToTelMora",
    name = "Teleport to Tel Mora",
    effect = tes3.effect.teleportToTelMora,
    range = tes3.effectRange.self
  })
end

event.register("MagickaExpanded:Register", registerSpells)