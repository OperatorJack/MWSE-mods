if (mwse.buildDate == nil) or (mwse.buildDate < 20190711) then
    local function warning()
        tes3.messageBox(
            "[Chrysopoeia ERROR] Your MWSE is out of date!"
            .. " You will need to update to a more recent version to use this mod."
        )
    end
    event.register("initialized", warning)
    event.register("loaded", warning)
    return
end

local function calculateItemValue(item)
    return item.value
end

local function filterItems(e)
    return calculateItemValue(e.item) > 0
end



local function getMultiplier()
    -- Calculate Damage Health multiplier, based on Alteration and Willpower.
    local alterationSkillLvl = tes3.mobilePlayer.alteration.current
    local willpowerAttrLvl = tes3.mobilePlayer.willpower.current

    local multiplier = ((alterationSkillLvl / 100) + (willpowerAttrLvl / 100)) / 2.5

    if (multiplier > .85) then
        multiplier = .85
    end

    return multiplier
end


local function onInventoryItemSelected(e)
    -- Remove transmuted item.
    tes3.removeItem({
        reference = tes3.player,
        item = e.item
    });

    -- Calculate Values
    local count =  calculateItemValue(e.item)
    local multiplier = getMultiplier()
    local goldAmount = math.ceil(count * multiplier)
    local damageAmount = math.ceil(count * multiplier * 1.2)

    -- Add gold to the players inventory.
    tes3.addItem({
        reference = tes3.player,
        item = "gold_001",
        count = goldAmount
    })

    -- Add damage health costs from casting spell.
    tes3.mobilePlayer:applyHealthDamage(damageAmount)

    -- Provide some information to the player.
    if (tes3.mobilePlayer.health.current > 0) then
        tes3.messageBox("The blood price has been paid. You  lost " .. damageAmount .. " health." ..
         " You receive " .. goldAmount .. " gold from the transmutation.")
         print("[Chrysopoeia: DEBUG] Spell Cast: Multiplier = " .. multiplier ..
         ", Value = " .. count ..
         ", GoldAmt = " .. goldAmount ..
         ", DmgAmt = " .. damageAmount)
    else
        tes3.messageBox("The blood price proved too great for your body.")
    end
end

local function onCastChrysopoeia(e)
	tes3ui.showInventorySelectMenu({
		title = "Chrysopoeia",
		noResultsText = "No possible items found.",
		filter = filterItems,
        callback = onInventoryItemSelected
	})
end

local function createSpellSchoolLineBlock(parentBlock, schoolText)
    local schoolBlock = parentBlock:createBlock({ id = tes3ui.registerID("Chrysopoeia:spellSchoolBlock")})
    schoolBlock.autoHeight = true
    schoolBlock.autoWidth = true
    schoolBlock.flowDirection = "left_to_right"
    schoolBlock.borderAllSides = 4

        local schoolLabel = schoolBlock:createLabel({ id=tes3ui.registerID("Chryopoeia:spellSchoolTextLabel"), text = schoolText })
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

        local icon = iconBlock:createImage({ id=tes3ui.registerID("Chryopoeia:effectIconImage"), path=iconPath})
        icon.autoHeight = false
        icon.autoWidth = false
        icon.height = 16
        icon.width = 16

    return iconBlock
end

local function createSpellEffectTextBlock(parentBlock, effectText)
    local textBlock = parentBlock:createBlock({ id=tes3ui.registerID("Chryopoeia:effectTopRightBlock") })
    textBlock.autoHeight = false
    textBlock.autoWidth = true
    textBlock.height = 18
    textBlock.paddingTop = 2
    textBlock.flowDirection = "top_to_bottom"

        local skillLabel = textBlock:createLabel({ id=tes3ui.registerID("Chryopoeia:effectTextLabel"), text = effectText })
        skillLabel.autoHeight = true
        skillLabel.autoWidth = true

    return textBlock
end

local function createSpellEffectLineBlock(parentBlock, iconPath, effectText)
    local effectLineBlock = parentBlock:createBlock({ id=tes3ui.registerID("Chryopoeia:effectTopBlock") })
    effectLineBlock.autoHeight = true
    effectLineBlock.autoWidth = true
    effectLineBlock.borderAllSides = 4

    createSpellEffectIconBlock(effectLineBlock, iconPath)
    createSpellEffectTextBlock(effectLineBlock, effectText)

    return effectLineBlock
end

local function createSpellEffectBlock(parentBlock, schoolText, iconPath, effectText)
    local outerBlock = parentBlock:createBlock({ id=tes3ui.registerID("Chryopoeia:effectOuterBlock") })
	outerBlock.flowDirection = "top_to_bottom"
    outerBlock.autoWidth = true
    outerBlock.autoHeight = true
    outerBlock.borderAllSides = 4

    createSpellSchoolLineBlock(outerBlock, schoolText)
    createSpellEffectLineBlock(outerBlock, iconPath, effectText)

    return outerBlock
end

local function setChrysopoeiaTooltip(e)
    local schoolText = "School:  Alteration"
    local effectText = "Transmute an item into Gold, with the cost paid in blood."
    local iconPath = "Icons/s/Tx_S_Drain_Health.tga"

    e.tooltip:findChild(tes3ui.registerID("effect")):destroy()

    createSpellEffectBlock(e.tooltip, schoolText, iconPath, effectText)
end

local function readChrysopoeia(e)
    local player = tes3.getPlayerRef()
    local chrysopoeiaSpell = tes3.getObject( "OJ_CH_ChrysopoeiaSpell" )

    if (not tes3.player.object.spells:contains(chrysopoeiaSpell)) then
        tes3.messageBox("As you read the scroll, you feel the spell drift into your mind.")
        tes3.updateJournal({id="OJ_CH_Chrysopoeia", index=30})
        mwscript.addSpell({reference = player, spell = chrysopoeiaSpell})
    end
end

local function onInitialized()
    local chrysopoeiaSpell = tes3.getObject( "OJ_CH_ChrysopoeiaSpell" ) or "nothing"
    local chrysopoeiaBook = tes3.getObject("OJ_CH_ChrysopoeiaBook") or "nothing"

	--Watch for "Chrysopoeia" spellcast.
	event.register("spellCasted", onCastChrysopoeia, { filter = chrysopoeiaSpell })
    event.register("uiSpellTooltip", setChrysopoeiaTooltip, { filter = chrysopoeiaSpell } )

    -- Watch for book reading
    event.register("bookGetText", readChrysopoeia, { filter = chrysopoeiaBook } )


	print("[Chrysopoeia: INFO] Initialized Chrysopoeia")
end
event.register("initialized", onInitialized)