
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

local function createSpellSchoolLineBlock(parentBlock, schoolText)
    local schoolBlock = parentBlock:createBlock({ id = tes3ui.registerID("Chrysopoeia:spellSchoolBlock")})
    schoolBlock.autoHeight = true
    schoolBlock.autoWidth = true
    schoolBlock.flowDirection = "left_to_right"
    schoolBlock.borderAllSides = 4

        local schoolLabel = schoolBlock:createLabel({ id=tes3ui.registerID("AstralPocketSpell:spellSchoolTextLabel"), text = schoolText })
        schoolLabel.autoHeight = false
        schoolLabel.autoWidth = false
        schoolLabel.height = 18

    return schoolBlock
end

local function createSpellEffectIconBlock(parentBlock, iconPath)
    local iconBlock = parentBlock:createBlock({})
    iconBlock.autoHeight = false
    iconBlock.autoWidth = false
    iconBlock.height = 20
    iconBlock.width = 16
    iconBlock.flowDirection = "left_to_right"
    iconBlock.borderRight = 10

        local icon = iconBlock:createImage({ id=tes3ui.registerID("AstralPocketSpell:effectIconImage"), path=iconPath})
        icon.autoHeight = false
        icon.autoWidth = false
        icon.height = 16
        icon.width = 16

    return iconBlock
end

local function createSpellEffectTextBlock(parentBlock, effectText)
    local textBlock = parentBlock:createBlock({ id=tes3ui.registerID("AstralPocketSpell:effectTopRightBlock") })
    textBlock.autoHeight = false
    textBlock.autoWidth = true
    textBlock.height = 18
    textBlock.paddingTop = 2
    textBlock.flowDirection = "top_to_bottom"

        local skillLabel = textBlock:createLabel({ id=tes3ui.registerID("AstralPocketSpell:effectTextLabel"), text = effectText })
        skillLabel.autoHeight = true
        skillLabel.autoWidth = true

    return textBlock
end

local function createSpellEffectLineBlock(parentBlock, iconPath, effectText)
    local effectLineBlock = parentBlock:createBlock({ id=tes3ui.registerID("AstralPocketSpell:effectTopBlock") })
    effectLineBlock.autoHeight = true
    effectLineBlock.autoWidth = true
    effectLineBlock.borderAllSides = 4

    createSpellEffectIconBlock(effectLineBlock, iconPath)
    createSpellEffectTextBlock(effectLineBlock, effectText)

    return effectLineBlock
end

local function createSpellEffectBlock(parentBlock, schoolText, iconPath, effectText)
    local outerBlock = parentBlock:createBlock({ id=tes3ui.registerID("AstralPocketSpell:effectOuterBlock") })
	outerBlock.flowDirection = "top_to_bottom"
    outerBlock.autoWidth = true
    outerBlock.autoHeight = true
    outerBlock.borderAllSides = 4

    createSpellSchoolLineBlock(outerBlock, schoolText)
    createSpellEffectLineBlock(outerBlock, iconPath, effectText)

    return outerBlock
end

local function setAstralPocketSpellTooltip(e)
    local schoolText = "School:  Alteration"
    local effectText = common.spellDescriptions.TeleportToAstralPocket
    local iconPath = "Icons/s/Tx_S_mark.tga"

    e.tooltip:findChild(tes3ui.registerID("effect")):destroy()

    createSpellEffectBlock(e.tooltip, schoolText, iconPath, effectText)
end

local function initializeSpell()
    local teleportToAstralPocketSpell = tes3.getObject( common.spellIds.TeleportToAstralPocket ) or "nothing"

	--Watch for "Teleport to Astral Pocket" spellcast.
	event.register("spellCasted", castTeleportToAstralPocket, { filter = teleportToAstralPocketSpell })
	event.register("uiSpellTooltip", setAstralPocketSpellTooltip, { filter = teleportToAstralPocketSpell } )

	print("[Astral Pocket: INFO] Initialized Astral Pocket Spell Effects")
end

event.register("AstralPocket:Initialized", initializeSpell)