local common = include("OperatorJack.MagickaExpanded.common")

local function registerSpells()
	common.createSimpleSpell({
		id = "OJ_ME_BanishDaedra",
		name = "Banish Daedra",
		effect = tes3.effect.banishDaedra,
        range = tes3.effectRange.touch,
        min = 30,
        max = 50
    })
    common.createSimpleSpell({
		id = "OJ_ME_Blink",
		name = "Blink",
		effect = tes3.effect.blink,
		range = tes3.effectRange.target
    })
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
    common.createSimpleSpell({
		id = "OJ_ME_SummonGoblinGrunt",
		name = "Summon Goblin",
		effect = tes3.effect.summonGoblinGrunt,
        range = tes3.effectRange.self,
        duration = 30
    })
    common.createSimpleSpell({
		id = "OJ_ME_SummonGoblinBruiser",
		name = "Summon Goblin Bruiser",
		effect = tes3.effect.summonGoblinBruiser,
        range = tes3.effectRange.self,
        duration = 30
    })
    common.createSimpleSpell({
		id = "OJ_ME_SummonGoblinFootSoldier",
		name = "Summon Goblin Foot Soldier",
		effect = tes3.effect.summonGoblinFootSoldier,
        range = tes3.effectRange.self,
        duration = 30
    })
    common.createSimpleSpell({
		id = "OJ_ME_SummonGoblinHandler",
		name = "Summon Goblin Handler",
		effect = tes3.effect.summonGoblinHandler,
        range = tes3.effectRange.self,
        duration = 30
    })
    common.createSimpleSpell({
		id = "OJ_ME_SummonGoblinOfficer",
		name = "Summon Goblin Officer",
		effect = tes3.effect.summonGoblinOfficer,
        range = tes3.effectRange.self,
        duration = 30
    })
    common.createSimpleSpell({
		id = "OJ_ME_SummonLich",
		name = "Summon Lich",
		effect = tes3.effect.summonLich,
        range = tes3.effectRange.self,
        duration = 30
    })
end

event.register("MagickaExpanded:Register", registerSpells)