local common = require("OperatorJack.MagickaExpanded.common")

local function createDebugCategory(page)
    local category = page:createCategory{
        label = "Debug"
    }

    -- Create option to capture debug mode.
    category:createOnOffButton{
        label = "Enable Debug Mode",
        description = "Use this option to enable debug mode.",
        variable = mwse.mcm.createTableVariable{
            id = "debugMode",
            table = common.config
        }
    }

    -- Create option to capture hotkey.
    category:createButton{
        label = "Add Test Spells to Player",
        buttonText = "Add Spells",
        description = "Use this option to add a set of test spells to the player's spell list.",
        inGameOnly = true,
        callback = common.addTestSpellsToPlayer
    }

    return category
end

-- Handle mod config menu.
local function registerModConfig()
    local template = mwse.mcm.createTemplate("Magicka Expanded")
    template:saveOnClose("Magicka Expanded", common.config)

    local page = template:createSideBarPage{
        label = "Settings Sidebar",
        description = "Hover over a setting to learn more about it."
    }

    createDebugCategory(page)

    mwse.mcm.register(template)
end
event.register("modConfigReady", registerModConfig)