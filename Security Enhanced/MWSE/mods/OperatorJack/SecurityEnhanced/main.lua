local config = require("OperatorJack.SecurityEnhanced.config")
local tools = require("OperatorJack.SecurityEnhanced.tools")

-- Register the mod config menu (using EasyMCM library).
event.register("modConfigReady", function()
    require("OperatorJack.SecurityEnhanced.mcm")
end)

local function initialized()
    tools.registerEvents()

    print("[Security Enhanced: INFO] Security Enhanced Initialized")
end

event.register("initialized", initialized)