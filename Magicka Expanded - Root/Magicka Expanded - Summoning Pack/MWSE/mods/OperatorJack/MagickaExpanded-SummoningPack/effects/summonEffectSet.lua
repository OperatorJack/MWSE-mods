local framework = include("OperatorJack.MagickaExpanded.magickaExpanded")

tes3.claimSpellEffectId("summonGoblinGrunt", 223)
tes3.claimSpellEffectId("summonGoblinOfficer", 224)
tes3.claimSpellEffectId("summonHulkingFabricant", 225)
tes3.claimSpellEffectId("summonAscendedSleeper", 226)
tes3.claimSpellEffectId("summonDraugr", 227)
tes3.claimSpellEffectId("summonLich", 228)

tes3.claimSpellEffectId("summonOgrim", 252)
tes3.claimSpellEffectId("summonWarDurzog", 253)
tes3.claimSpellEffectId("summonSpriggan", 254)
tes3.claimSpellEffectId("summonCenturionSteam", 255)
tes3.claimSpellEffectId("summonCenturionProjectile", 256)
tes3.claimSpellEffectId("summonAshGhoul", 257)
tes3.claimSpellEffectId("summonAshZombie", 258)
tes3.claimSpellEffectId("summonAshSlave", 259)
tes3.claimSpellEffectId("summonCenturionSpider", 260)

local function getDescription(creatureName)
    return "This effect summons a ".. creatureName .." from Oblivion."..
    " It appears six feet in front of the caster and attacks any entity that attacks the caster until"..
    " the effect ends or the summoning is killed. At death, or when the effect ends, the summoning"..
    " disappears, returning to Oblivion. If summoned in town, the guards will attack you and the summoning on sight."
end
local function addSummoningEffects()
	framework.effects.conjuration.createBasicSummoningEffect({
		id = tes3.effect.summonGoblinGrunt,
		name = "Summon Goblin",
		description = getDescription("Goblin"),
		cost = 12,
		creatureId = "OJ_ME_GoblinGrunt",
	})
	framework.effects.conjuration.createBasicSummoningEffect({
		id = tes3.effect.summonGoblinOfficer,
		name = "Summon Goblin Officer",
		description = getDescription("Goblin Officer"),
		cost = 70,
		creatureId = "OJ_ME_GoblinOfficer",
	})
	framework.effects.conjuration.createBasicSummoningEffect({
		id = tes3.effect.summonHulkingFabricant,
		name = "Summon Hulking Fabricant",
		description = getDescription("Hulking Fabricant"),
		cost = 80,
		creatureId = "OJ_ME_HulkingFabricant",
	})
	framework.effects.conjuration.createBasicSummoningEffect({
		id = tes3.effect.summonAscendedSleeper,
		name = "Summon Ascended Sleeper",
		description = getDescription("Ascended Sleeper"),
		cost = 65,
		creatureId = "OJ_ME_AscendedSleeper",
		icon = "RFD\\RFD_6h_ascslp.dds"
	})
	framework.effects.conjuration.createBasicSummoningEffect({
		id = tes3.effect.summonDraugr,
		name = "Summon Draugr",
		description = getDescription("Draugr"),
		cost = 45,
		creatureId = "OJ_ME_Draugr2",
	})
	framework.effects.conjuration.createBasicSummoningEffect({
		id = tes3.effect.summonLich,
		name = "Summon Lich",
		description = getDescription("Lich"),
		cost = 47,
		creatureId = "OJ_ME_Lich",
	})
	framework.effects.conjuration.createBasicSummoningEffect({
		id = tes3.effect.summonOgrim,
		name = "Summon Ogrim",
		description = getDescription("Ogrim"),
		cost = 15,
		creatureId = "OJ_ME_Ogrim",
	})
	framework.effects.conjuration.createBasicSummoningEffect({
		id = tes3.effect.summonWarDurzog,
		name = "Summon War Durzog",
		description = getDescription("War Durzog"),
		cost = 14,
		creatureId = "OJ_ME_WarDurzog",
	})
	framework.effects.conjuration.createBasicSummoningEffect({
		id = tes3.effect.summonSpriggan,
		name = "Summon Spriggan",
		description = getDescription("Spriggan"),
		cost = 30,
		creatureId = "OJ_ME_Spriggan",
	})
	framework.effects.conjuration.createBasicSummoningEffect({
		id = tes3.effect.summonCenturionSteam,
		name = "Summon Steam Centurion",
		description = getDescription("Steam Centurion"),
		cost = 25,
		creatureId = "OJ_ME_SteamCenturion",
	})
	framework.effects.conjuration.createBasicSummoningEffect({
		id = tes3.effect.summonCenturionProjectile,
		name = "Summon Centurion Archer",
		description = getDescription("Centurion Archer"),
		cost = 20,
		creatureId = "OJ_ME_CenturionArcher",
	})
	framework.effects.conjuration.createBasicSummoningEffect({
		id = tes3.effect.summonCenturionSpider,
		name = "Summon Centurion Spider",
		description = getDescription("Centurion Spider"),
		cost = 5,
		creatureId = "OJ_ME_CenturionSpider",
	})
	framework.effects.conjuration.createBasicSummoningEffect({
		id = tes3.effect.summonAshGhoul,
		name = "Summon Ash Ghoul",
		description = getDescription("Ash Ghoul"),
		cost = 35,
		creatureId = "OJ_ME_AshGhoul",
		icon = "RFD\\RFD_6h_ghoul.dds"
	})
	framework.effects.conjuration.createBasicSummoningEffect({
		id = tes3.effect.summonAshZombie,
		name = "Summon Ash Zombie",
		description = getDescription("Ash Zombie"),
		cost = 8,
		creatureId = "OJ_ME_AshZombie",
		icon = "RFD\\RFD_6h_zombie.dds"
	})
	framework.effects.conjuration.createBasicSummoningEffect({
		id = tes3.effect.summonAshSlave,
		name = "Summon Ash Slave",
		description = getDescription("Ash Slave"),
		cost = 15,
		creatureId = "OJ_ME_AshSlave",
		icon = "RFD\\RFD_6h_slave.dds"
	})
end

event.register("magicEffectsResolved", addSummoningEffects)