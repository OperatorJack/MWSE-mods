local config = require("OperatorJack.IllegalSummoning.config")

-- Register the mod config menu (using EasyMCM library).
event.register("modConfigReady", function()
    dofile("Data Files\\MWSE\\mods\\OperatorJack\\IllegalSummoning\\mcm.lua")
end)

local function onCast(e)
    --@type tes3cell
    local cell = e.caster.cell

    if (cell.restingIsIllegal) then
        for _, effect in ipairs(e.source.effects) do
            if (effect.object) then
                if (effect.object.name:startswith("Summon ")) then
                    tes3.triggerCrime({
                        criminal = e.caster,
                        type = tes3.crimeType.theft,
                        value = config.bountyValue
                    })               
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