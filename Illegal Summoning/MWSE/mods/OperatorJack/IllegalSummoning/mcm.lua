local config = require("OperatorJack.IllegalSummoning.config")

local function getMagicEffects()
    local list = {}
    for obj in tes3.iterateObjects(tes3.objectType.magic) do
        if obj.organic then
            list[#list+1] = (obj.baseObject or obj).id:lower()
        end
    end
    table.sort(list)
    return list
end

local funciton getNPCs()
    local list = {}
    for obj in tes3.iterateObjects(tes3.objectType.mobileNpc) do
        if obj.organic then
            list[#list+1] = (obj.baseObject or obj).id:lower()
        end
    end
    table.sort(list)
    return list
end

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

    -- Blacklist Page
    category:createExclusionsPage{
        label = "Blacklist Magic Effects",
        description = "Blacklisted magic effects will always trigger a crime, even on whitelisted NPCs.",
        leftListLabel = "Blacklist",
        rightListLabel = "Magic Effects",
        variable = EasyMCM:createTableVariable{
            id = "effectBlacklist",
            table = config,
        },
        filters = {
            {callback = getMagicEffects},
        },
    }

    -- Whitelist Page
    category:createExclusionsPage{
        label = "Whitelist",
        description = "Whitelisted NPCs can cast magic effects that are not blacklisted.",
        leftListLabel = "Whitelist",
        rightListLabel = "NPCs",
        variable = EasyMCM:createTableVariable{
            id = "npcWhitelist",
            table = config,
        },
        filters = {
            {callback = getNPCs},
        },
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