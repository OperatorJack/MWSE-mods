local config = require("OperatorJack.IllegalSummoning.config")

-- Register the mod config menu (using EasyMCM library).
event.register("modConfigReady", function()
    require("OperatorJack.IllegalSummoning.mcm")
end)

local function onCast(e)
    if (e.caster ~= tes3.player) then
        return
    end

    --@type tes3cell
    local cell = e.caster.cell

    if (cell.restingIsIllegal) then
        for _, effect in ipairs(e.source.effects) do
            if (effect.object) then
                if string.startswith(effect.object.name, "Summon ") then
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