local common = require("OperatorJack.SecurityEnhanced.common")
local mcm = require("OperatorJack.SecurityEnhanced.mcm")
local lockpick = require("OperatorJack.SecurityEnhanced.lockpick")
local probe = require("OperatorJack.SecurityEnhanced.probe")
local general = require("OperatorJack.SecurityEnhanced.general")

local function initialized()
    lockpick.registerEvents()
    probe.registerEvents()
    general.registerEvents()

    print("[Security Enhanced: INFO] Security Enhanced Initialized")
end

event.register("initialized", initialized)