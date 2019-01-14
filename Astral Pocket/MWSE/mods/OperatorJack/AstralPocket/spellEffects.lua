
local debug = true
local function debugMessage(string)
	if debug then
		tes3.messageBox(string)
		mwse.log("[Astral Pocket: DEBUG] " .. string)
	end
end

local common = require("OperatorJack.AstralPocket.common")

local function updateAstralPocketTravelDestination(_position, _orientation, _cell)
	local _door = tes3.getReference(common.doorId)
	local params ={
		reference = _door,
		position = _position,
		orientation = _orientation,
		cell = _cell
	}

	tes3.setDestination(params)
end

local function  castTeleportToAstralPocket(e)
	local canTeleport = not tes3.worldController.flagTeleportingDisabled
	if canTeleport then
		updateAstralPocketTravelDestination(e.caster.position, e.caster.orientation, e.caster.cell)

		local params={
			reference = e.caster,
			position = common.cell.position,
			orientation = common.cell.orientation,
			cell = common.cell.id
		}

		tes3.positionCell(params)
	else
		tes3.messageBox("You are not able to cast that spell here.")
	end
end

local function setAstralPocketSpellTooltip(e)
	mwse.log("[Astral Pocket: DEBUG] Setting Tooltip!")

	local uiText = common.spellDescriptions.TeleportToAstralPocket
	local uiBlock = e.tooltip:createBlock()
	uiBlock.autoHeight = true
	uiBlock.autoWidth = true

	local uiLabel = uiBlock:createLabel{text = uiText}
end

local function initializeSpell()
    local teleportToAstralPocketSpell = tes3.getObject( common.spellIds.TeleportToAstralPocket ) or "nothing"

	--Watch for "Teleport to Astral Pocket" spellcast.
	event.register("spellCasted", castTeleportToAstralPocket, { filter = teleportToAstralPocketSpell })
	event.register("uiSpellTooltip", setAstralPocketSpellTooltip, { filter = teleportToAstralPocketSpell } )

	print("[Astral Pocket: INFO] Initialized Astral Pocket Spell Effects")
end

event.register("AstralPocket:Initialized", initializeSpell)