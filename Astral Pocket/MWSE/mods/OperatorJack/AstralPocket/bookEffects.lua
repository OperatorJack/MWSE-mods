
local debug = true
local function debugMessage(string)
	if debug then
		tes3.messageBox(string)
		mwse.log("[Astral Pocket: DEBUG] " .. string)
	end
end

local common = require("OperatorJack.AstralPocket.common")

local function readAstrologicalElements(e)
    local player = tes3.getPlayerRef()
    if tes3.mobilePlayer.mysticism.current > 80 then
        local teleportToAstralPocketSpell = tes3.getObject( common.spellIds.TeleportToAstralPocket ) or "nothing"
        if (not tes3.player.object.spells:contains(teleportToAstralPocketSpell)) then
            tes3.updateJournal({id=common.journalIds.QuestOne, index=20})
            mwscript.addSpell({reference = player, spell = teleportToAstralPocketSpell})
        end
    else
        tes3.messageBox("You try to learn the spell to teleport to the Astral Pocket, but you find you are not skilled enough in the art of Mysticism.")
    end
end

local function readNelasNote(e)
    local questOneIndex = tes3.getJournalIndex({ id = common.journalIds.QuestOne}) or -1
    if questOneIndex < 30 then
        tes3.updateJournal({id = common.journalIds.QuestOne,index=30})
    end
end

local function initializeBooks()
    local AstrologicalElementsObject = tes3.getObject(common.bookIds.AstrologicalElements)
    local NelasNoteObject = tes3.getObject(common.bookIds.NelasNote)

    event.register("bookGetText", readAstrologicalElements, { filter = AstrologicalElementsObject } )
    event.register("bookGetText", readNelasNote, { filter = NelasNoteObject } )

	print("[Astral Pocket: INFO] Initialized Astral Pocket Book Effects")
end
event.register("AstralPocket:Initialized", initializeBooks)