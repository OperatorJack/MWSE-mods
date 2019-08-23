local config = require("OperatorJack.IllegalSummoning.config")

local function createGeneralCategory(page)
    local category = page:createCategory{
        label = "General Settings"
    }

    -- Create option to capture debug mode.
    category:createSlider{
        label = "Bounty Value",
        description = "Use this option to configure the amount of bounty received when getting caught during an illegal summon.",
        min = 0,
        max = 10000,
        step = 50,
        jump = 500,
        variable = mwse.mcm.createTableVariable{
            id = "bountyValue",
            table = config
        }
    }

    return category
end

-- Handle mod config menu.
local template = mwse.mcm.createTemplate("Illegal Summoning")
template:saveOnClose("Illegal-Summoning", config)

local page = template:createSideBarPage{
    label = "Settings Sidebar",
    description = "Hover over a setting to learn more about it."
}

createGeneralCategory(page)

mwse.mcm.register(template)