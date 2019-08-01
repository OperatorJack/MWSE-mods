if (mwse.buildDate == nil) or (mwse.buildDate < 20181211) then
    local function warning()
        tes3.messageBox(
            "[Magicka Expanded ERROR] Your MWSE is out of date!"
            .. " You will need to update to a more recent version to use this mod."
        )
    end
    event.register("initialized", warning)
    event.register("loaded", warning)
    return
end

local function initialized(e)
    math.randomseed(os.time())
	local blinkSpell = require("OperatorJack.MagickaExpanded.blinkSpell")

    event.trigger("MagickaExpanded:Register")

	print("[Magicka Expanded: INFO] Initialized Magicka Expanded Spells")
end
event.register("initialized", initialized)