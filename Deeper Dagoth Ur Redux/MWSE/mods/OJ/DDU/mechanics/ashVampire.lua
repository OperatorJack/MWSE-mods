local common = require("TeamVoluptuousVelks.DeeperDagothUr.common")

-- Ash Vampire Mechanics --
local ashVampireIds = {
    ["ash_vampire"] = true,
    ["dagoth araynys"] = true,
    ["dagoth endus"] = true,
    ["dagoth gilvoth"] = true,
    ["dagoth odros"] = true,
    ["dagoth tureynul"] = true,
    ["dagoth uthol"] = true,
    ["dagoth vemyn"] = true
}

local function isAshVampire(id)
    return ashVampireIds[id] == true or
               (id:lower():startswith("dagoth") == true and id ~= "dagoth_ur_1" and
                   id ~= "dagoth_ur_2")
end

event.register("death", function(e)
    local referenceId = e.mobile.object.baseObject.id
    if (isAshVampire(referenceId) == false) then return end

    common.debug("Ash Vampire is dying.")

    if (common.shouldPerformRandomEvent(50) ~= true) then
        common.debug("Ash Vampire Death: Check failed.")
        return
    end

    common.debug("Ash Vampire Death: Check passed.")

    if (referenceId == "dagoth araynys") then
        tes3.messageBox(common.data.dialogue.ashVampires.araynys)
    elseif (referenceId == "dagoth endus") then
        tes3.messageBox(common.data.dialogue.ashVampires.endus)
    elseif (referenceId == "dagoth gilvoth") then
        tes3.messageBox(common.data.dialogue.ashVampires.gilvoth)
    elseif (referenceId == "dagoth odros") then
        tes3.messageBox(common.data.dialogue.ashVampires.odros)
    elseif (referenceId == "dagoth tureynul") then
        tes3.messageBox(common.data.dialogue.ashVampires.tureynul)
    elseif (referenceId == "dagoth uthol") then
        tes3.messageBox(common.data.dialogue.ashVampires.uthol)
    elseif (referenceId == "dagoth vemyn") then
        tes3.messageBox(common.data.dialogue.ashVampires.vemyn)
    end

end)
