local framework = include("OperatorJack.MagickaExpanded.magickaExpanded")

tes3.claimSpellEffectId("boundGreaves", 239)
tes3.claimSpellEffectId("boundPauldrons", 240)


local function getDescription(armorName)
    return "The spell effect conjures a lesser Daedra bound in the form of a magical," ..
    " wondrously light pair of " .. armorName ..". The ".. armorName .." appear automatically" ..
    " equipped on the caster, displacing any currently equipped armor to inventory.  When the effect ends, "..
    " the " .. armorName .. " disappear, and any previously equipped armor is automatically re-equipped."
end

local function addBoundArmorEffects()
    framework.effects.conjuration.createBasicBoundArmorEffect({
        id = tes3.effect.boundGreaves,
        name = "Bound Greaves",
        description = getDescription("Daedric Greaves"),
        baseCost = 2,
        armorId = "OJ_ME_BoundGreaves",
		icon = "RFD\\RFD_lf_greaves.dds"
    })
    framework.effects.conjuration.createBasicBoundWeaponEffect({
        id = tes3.effect.boundPauldrons,
        name = "Bound Pauldrons",
        description = getDescription("Daedric Pauldrons"),
        baseCost = 2,
        armorId = "OJ_ME_BoundPauldronLeft",
        armorId2 = "OJ_ME_BoundPauldronRight",
		icon = "RFD\\RFD_lf_pauldrons.dds"
    })
end

event.register("magicEffectsResolved", addBoundArmorEffects)