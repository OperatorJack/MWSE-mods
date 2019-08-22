local function onCast(e)
    if (e.caster ~= tes3.player) then
        return
    end

    --@type tes3cell
    local cell = e.caster.cell

    if (cell.restingIsIllegal) then
        for _, effect in ipairs(e.source.effects) do
            tes3.messageBox("Effect ID: %s", effect.id)
            tes3.messageBox("Effect: %s", effect.object.name)
            if string.startswith(effect.object.name, "Summon ") then
                local commitedCrime = tes3.triggerCrime({
                    criminal = e.caster,
                    type = tes3.crimeType.trespass,
                    value = 500
                })
                if (commitedCrime) then
                    tes3.messageBox("It is illegal to summon creatures here. Your crime has been reported!")
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