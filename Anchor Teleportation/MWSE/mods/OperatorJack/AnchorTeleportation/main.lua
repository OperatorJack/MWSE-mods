local function onSpellResist(e)
    for _, effect in pairs(e.sourceInstance.source.effects) do
        if (effect.id == tes3.effect.recall) then
            tes3markData.position = nil
            tes3markData.rotation = nil
            tes3markData.cell = nil
            return
        end
    end
end
event.register("spellResist", onSpellResist)