-- Check MWSE Build --
if (mwse.buildDate == nil) or (mwse.buildDate < 20190821) then
    local function warning()
        tes3.messageBox(
            "[Deeper Dagoth Ur ERROR] Your MWSE is out of date!"
            .. " You will need to update to a more recent version to use this mod."
        )
    end
    event.register("initialized", warning)
    event.register("loaded", warning)
    return
end


-- Initilization Section --
local function onInitialized()
    if not tes3.isModActive("Deeper Dagoth Ur.ESP") then
        print("[Deeper Dagoth Ur: INFO] ESP not loaded")
        return
    end

    math.randomseed(os.time())
    math.random()
    math.random()
    math.random()

    require("OJ.DDU.common")
    require("OJ.DDU.mechanics.ascendedSleeper")
    require("OJ.DDU.mechanics.ashVampire")
    require("OJ.DDU.mechanics.dagothUr")
    require("OJ.DDU.mechanics.coil")
    require("OJ.DDU.puzzles.dagothUrLowerFacility")

	print("[Deeper Dagoth Ur: INFO] Initialized Deeper Dagoth Ur")
end
event.register("initialized", onInitialized)