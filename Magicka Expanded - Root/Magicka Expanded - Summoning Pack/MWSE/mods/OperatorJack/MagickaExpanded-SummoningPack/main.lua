local framework = include("OperatorJack.MagickaExpanded.magickaExpanded")

require("OperatorJack.MagickaExpanded-SummoningPack.effects.summonEffectSet")

local function registerSpells()
  framework.spells.createBasicSpell({
    id = "OJ_ME_SummonGoblinGrunt",
    name = "Summon Goblin",
    effect = tes3.effect.summonGoblinGrunt,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_SummonGoblinBruiser",
    name = "Summon Goblin Bruiser",
    effect = tes3.effect.summonGoblinBruiser,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_SummonGoblinFootSoldier",
    name = "Summon Goblin Foot Soldier",
    effect = tes3.effect.summonGoblinFootSoldier,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_SummonGoblinHandler",
    name = "Summon Goblin Handler",
    effect = tes3.effect.summonGoblinHandler,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_SummonGoblinOfficer",
    name = "Summon Goblin Officer",
    effect = tes3.effect.summonGoblinOfficer,
    range = tes3.effectRange.self,
    duration = 30
  })
  framework.spells.createBasicSpell({
    id = "OJ_ME_SummonLich",
    name = "Summon Lich",
    effect = tes3.effect.summonLich,
    range = tes3.effectRange.self,
    duration = 30
  })
end

event.register("MagickaExpanded:Register", registerSpells)