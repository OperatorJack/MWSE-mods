--- @type {[number] : any}
local categories = {
    [tes3.objectType.armor] = {
        text = "Armor",
        types = tes3.armorSlot,
        blockedSlots = { ["shield"] = true }
    },
    [tes3.objectType.clothing] = {
        text = "Clothing",
        types = tes3.clothingSlot,
        blockedSlots = { ["amulet"] = true, ["belt"] = true, ["ring"] = true }
    }
}


local layerOverrides = {
    [tes3.objectType.armor] = {
        [tes3.armorSlot.helmet] = {
            { layer = tes3.activeBodyPartLayer.base,  part = tes3.activeBodyPart.hair, override = 0 },
            { layer = tes3.activeBodyPartLayer.armor, part = tes3.activeBodyPart.hair, override = 0 },
            { layer = tes3.activeBodyPartLayer.armor, part = tes3.activeBodyPart.head, override = 0 },
        },
        [tes3.armorSlot.greaves] = {
            { layer = tes3.activeBodyPartLayer.armor, part = tes3.activeBodyPart.rightKnee,     override = 0 },
            { layer = tes3.activeBodyPartLayer.armor, part = tes3.activeBodyPart.leftKnee,      override = 0 },
            { layer = tes3.activeBodyPartLayer.armor, part = tes3.activeBodyPart.rightUpperLeg, override = 0 },
            { layer = tes3.activeBodyPartLayer.armor, part = tes3.activeBodyPart.leftUpperLeg,  override = 0 },
        },
    },
    [tes3.objectType.clothing] = {
        [tes3.clothingSlot.robe] = {
            { layer = tes3.activeBodyPartLayer.base,     part = tes3.activeBodyPart.chest },
            { layer = tes3.activeBodyPartLayer.base,     part = tes3.activeBodyPart.groin },
            { layer = tes3.activeBodyPartLayer.base,     part = tes3.activeBodyPart.rightForearm },
            { layer = tes3.activeBodyPartLayer.base,     part = tes3.activeBodyPart.leftForearm },
            { layer = tes3.activeBodyPartLayer.base,     part = tes3.activeBodyPart.rightUpperArm },
            { layer = tes3.activeBodyPartLayer.base,     part = tes3.activeBodyPart.leftUpperArm },
            { layer = tes3.activeBodyPartLayer.base,     part = tes3.activeBodyPart.rightKnee },
            { layer = tes3.activeBodyPartLayer.base,     part = tes3.activeBodyPart.leftKnee },
            { layer = tes3.activeBodyPartLayer.base,     part = tes3.activeBodyPart.rightUpperLeg },
            { layer = tes3.activeBodyPartLayer.base,     part = tes3.activeBodyPart.leftUpperLeg },
            { layer = tes3.activeBodyPartLayer.clothing, part = tes3.activeBodyPart.chest,        override = 0 },
            { layer = tes3.activeBodyPartLayer.clothing, part = tes3.activeBodyPart.groin },
            { layer = tes3.activeBodyPartLayer.clothing, part = tes3.activeBodyPart.rightForearm },
            { layer = tes3.activeBodyPartLayer.clothing, part = tes3.activeBodyPart.leftForearm },
            { layer = tes3.activeBodyPartLayer.clothing, part = tes3.activeBodyPart.rightUpperArm },
            { layer = tes3.activeBodyPartLayer.clothing, part = tes3.activeBodyPart.leftUpperArm },
            { layer = tes3.activeBodyPartLayer.clothing, part = tes3.activeBodyPart.rightKnee },
            { layer = tes3.activeBodyPartLayer.clothing, part = tes3.activeBodyPart.leftKnee },
            { layer = tes3.activeBodyPartLayer.clothing, part = tes3.activeBodyPart.rightUpperLeg },
            { layer = tes3.activeBodyPartLayer.clothing, part = tes3.activeBodyPart.leftUpperLeg },
            { layer = tes3.activeBodyPartLayer.armor,    part = tes3.activeBodyPart.chest },
            { layer = tes3.activeBodyPartLayer.armor,    part = tes3.activeBodyPart.groin },
        },
        [tes3.clothingSlot.skirt] = {
            { layer = tes3.activeBodyPartLayer.base,     part = tes3.activeBodyPart.groin },
            { layer = tes3.activeBodyPartLayer.base,     part = tes3.activeBodyPart.rightUpperLeg },
            { layer = tes3.activeBodyPartLayer.base,     part = tes3.activeBodyPart.leftUpperLeg },
            { layer = tes3.activeBodyPartLayer.clothing, part = tes3.activeBodyPart.groin,        override = 0 },
            { layer = tes3.activeBodyPartLayer.clothing, part = tes3.activeBodyPart.rightUpperLeg },
            { layer = tes3.activeBodyPartLayer.clothing, part = tes3.activeBodyPart.leftUpperLeg },
            { layer = tes3.activeBodyPartLayer.armor,    part = tes3.activeBodyPart.groin },
            { layer = tes3.activeBodyPartLayer.armor,    part = tes3.activeBodyPart.rightUpperLeg },
            { layer = tes3.activeBodyPartLayer.armor,    part = tes3.activeBodyPart.leftUpperLeg },
        },
    },
}

local this = {}
this.categories = categories
this.layerOverrides = layerOverrides
return this
