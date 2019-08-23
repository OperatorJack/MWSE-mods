-- Load configuration.
return mwse.loadConfig("Illegal-Summoning") or {
    -- Initialize Settings
    bountyValue = 500,

    effectBlacklist = { 
        ["summonAshGhoul"] = true,
        ["summonAshZombie"] = true,
        ["summonAshSlave"] = true,
        ["summonAscendedSleeper"] = true
    } 
    npcWhitelist = { 
        ["Telvanni Guard"] = true 
    }
}