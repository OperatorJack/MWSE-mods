local common = include("OperatorJack.MagickaExpanded.common")

tes3.claimSpellEffectId("summonGoblinGrunt", 223)
tes3.claimSpellEffectId("summonGoblinBruiser", 224)
tes3.claimSpellEffectId("summonGoblinFootSoldier", 225)
tes3.claimSpellEffectId("summonGoblinHandler", 226)
tes3.claimSpellEffectId("summonGoblinOfficer", 227)
tes3.claimSpellEffectId("summonLich", 228)

local function getDescription(creatureName)
    return "This effect summons a ".. creatureName .." from Oblivion."..
    " It appears six feet in front of the caster and attacks any entity that attacks the caster until"..
    " the effect ends or the summoning is killed. At death, or when the effect ends, the summoning"..
    " disappears, returning to Oblivion. If summoned in town, the guards will attack you and the summoning on sight."
end
local function addSummoningEffects()
	common.createSimpleSummoningEffect({
		id = tes3.effect.summonGoblinGrunt,
		name = "Summon Goblin",
		description = getDescription("Goblin"),
		cost = 7,
		creatureId = "goblin_grunt",
	})
	common.createSimpleSummoningEffect({
		id = tes3.effect.summonGoblinFootSoldier,
		name = "Summon Goblin Foot Soldier",
		description = getDescription("Goblin Foot Soldier"),
		cost = 16,
		creatureId = "goblin_footsoldier",
	})
	common.createSimpleSummoningEffect({
		id = tes3.effect.summonGoblinBruiser,
		name = "Summon Goblin Bruiser",
		description = getDescription("Goblin Bruiser"),
		cost = 25,
		creatureId = "goblin_bruiser",
	})
	common.createSimpleSummoningEffect({
		id = tes3.effect.summonGoblinHandler,
		name = "Summon Goblin Handler",
		description = getDescription("Goblin Handler"),
		cost = 40,
		creatureId = "goblin_handler",
	})
	common.createSimpleSummoningEffect({
		id = tes3.effect.summonGoblinOfficer,
		name = "Summon Goblin Officer",
		description = getDescription("Goblin Officer"),
		cost = 60,
		creatureId = "goblin_officer",
	})
	common.createSimpleSummoningEffect({
		id = tes3.effect.summonLich,
		name = "Summon Lich",
		description = getDescription("Lich"),
		cost = 62,
		creatureId = "lich",
	})
end

event.register("magicEffectsResolved", addSummoningEffects)