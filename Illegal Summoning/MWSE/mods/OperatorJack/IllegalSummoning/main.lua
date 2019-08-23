
-- Make sure we have an up-to-date version of MWSE.
if (mwse.buildDate == nil) or (mwse.buildDate < 20190821) then
    event.register("initialized", function()
        tes3.messageBox(
            "[Illegal Summoning] Your MWSE is out of date!"
            .. " You will need to update to a more recent version to use this mod."
        )
    end)
    return
end

local config = require("OperatorJack.IllegalSummoning.config")

-- Register the mod config menu (using EasyMCM library).
event.register("modConfigReady", function()
    dofile("Data Files\\MWSE\\mods\\OperatorJack\\IllegalSummoning\\mcm.lua")
end)

local function isEffectBlacklisted(name)
    if (config.effectBlacklist[name:lower()]) then
        return true
    end
    return false
end

local function isEffectWhitelisted(name)
    if (config.effectWhitelist[name:lower()]) then
        return true
    end
    return false
end

local function isNpcWhitelisted(name)
    if (config.npcWhitelist[name:lower()]) then
        return true
    end
    return false
end

local function triggerCrime(caster) 
    tes3.triggerCrime({
        criminal = caster,
        type = tes3.crimeType.theft,
        value = config.bountyValue
    })
end

local function onCast(e)
    --@type tes3cell
    local cell = e.caster.cell

    if (cell.restingIsIllegal) then
        for _, effect in ipairs(e.source.effects) do
            if (effect.object) then
                if (isEffectWhitelisted(effect.object.name)) then
                    return
                elseif (isEffectBlacklisted(effect.object.name)) then
                    triggerCrime(e.caster)
                elseif (effect.object.name:lower():startswith("summon ")) then
                    if (isNpcWhitelisted(e.caster.object.name)) then
                        return
                    end
                    
                    triggerCrime(e.caster)
                end
            end
        end 
    end  
end

local function onInitialized()
	--Watch for spellcast.
	event.register("spellCasted", onCast)

	print("[Illegal Summoning: INFO] Initialized Illegal Summoning")
end
event.register("initialized", onInitialized)