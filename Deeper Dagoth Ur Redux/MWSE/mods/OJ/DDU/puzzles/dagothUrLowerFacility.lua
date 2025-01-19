local cellId = "Dagoth Ur, Lower Facility"
local journalId = "C3_DestroyDagoth"

local actor = {id = "dagoth gilvoth"}
local forceFieldId = "DDU_LowerFacilityForcefield"

local function onDeath(e)
    local id = e.reference.object.baseObject.id
    if (actor.id ~= id) then return end

    tes3.messageBox("As Dagoth Gilvoth falls, a nearby forcefield collapses.")

    local forceField = tes3.getReference(forceFieldId)
    forceField:delete()
end

local function onJournal(e)
    if (e.topic.id ~= journalId) then return end

    event.unregister("death", onDeath)
    event.unregister("journal", onJournal)
end

local function onLoaded(e)
    local journalIndex = tes3.getJournalIndex({id = journalId})
    if (journalIndex == nil or journalIndex < 5) then
        event.register("death", onDeath)
        event.register("journal", onJournal)
    end
end

event.register("loaded", onLoaded)
