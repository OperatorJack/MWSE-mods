local function onCast(e)
    if (e.caster ~= tes3.player) then
        return
    end

    --@type tes3cell
    local cell = e.caster.cell

    if (cell.restingIsIllegal) then
        for _, effect in ipairs(e.source.effects) do
            tes3.messageBox("Effect ID: %s", effect.id)
            tes3.messageBox("Effect: %s", effect.name)
            if string.startswith(effect.name, "Summon ") then
                tes3.mobilePlayer.bounty = tes3.mobilePlayer.bounty + 1000
                tes3.messageBox("You have summoned a creature in an illegal area. Your bounty has been increased!")
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