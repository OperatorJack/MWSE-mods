if (mwse.buildDate == nil) or (mwse.buildDate < 20181211) then
    local function warning()
        tes3.messageBox(
            "[Astral Pocket ERROR] Your MWSE is out of date!"
            .. " You will need to update to a more recent version to use this mod."
        )
    end
    event.register("initialized", warning)
    event.register("loaded", warning)
    return
end

local common = require("OperatorJack.AstralPocket.common")

local function initialized(e)

	if not tes3.isModActive("Astral Pocket.ESP") then
		print("[Astral Pocket: INFO] ESP not loaded")
		return
	end

	local spellEffects = require("OperatorJack.AstralPocket.spellEffects")
    local bookEffects = require("OperatorJack.AstralPocket.bookEffects")

	print("[Astral Pocket: INFO] Initialized Astral Pocket")

	event.trigger("AstralPocket:Initialized")
end
event.register("initialized", initialized)