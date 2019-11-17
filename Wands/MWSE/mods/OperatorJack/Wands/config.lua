-- Load configuration.
return mwse.loadConfig("Wands") or {
    -- Initialize Settings
    showDebug = false,
    applyToStaves = true,
    wands = { 
        ["w_wand_iron"] = true,
        ["w_wand_"] = true,
    },
}