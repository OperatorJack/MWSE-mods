--[[ 	Public functions for mods to add and manipulate custom skills	]]--

local common = include("SpellsModule.common")
local this = {}

local function setTooltip(e)
	mwse.log("[Spells Module: DEBUG] Setting Tooltip! for e.id: " .. e.spell.id)

	local uiText = common.spells[e.spell.id].tooltipDesc
	local uiBlock = e.tooltip:createBlock()
	uiBlock.autoHeight = true
	uiBlock.autoWidth = true

	local uiLabel = uiBlock:createLabel{text = uiText}
end

local function defaultCombatStartedEvent(e)
    
end

--[[
	@id : id of the spell to update
	@spellVals : table of values to update. Whatever fields are included will be changed to the values in the table
	
	E.g to change the name and description of a spell:
		updatespell ( "Myspell_ID", { name = "My spell", description = "This is a new spell description" } )
]]--

function this.updateSpell(id, spellVals)
    if common.spells[id] then
        for i,val in pairs(spellVals) do
            if val then
                common.spells[id][i] = val
            end
        end
    else
		mwse.log("[Spells Module: ERROR] Spell %s does not exist.", id)
		return
    end
end

function this.getSpell(id)
    return common.spells[id] or nil
end

--[[
	Register a spell..
	If the spell doesn't exist, it is created with values from @spell paramater
	If the spell already exists, simply update it.
]]--
function this.registerSpell(id, spell)
    if not id then
		mwse.log("[Spells Module: ERROR] registerSpell requires id parameter.")
		return
    end

    if not common.spells then
		mwse.log("[Spells Module: ERROR] Spells table not loaded. Trigger register using event 'SpellsModule:Register'")
		return
    end

    local spellObject = tes3.getObject(spell.id)
    if not spellObject then
		mwse.log("[Spells Module: ERROR] Unable to find existing Spell object. Make sure your spell ID matches the spell ID in the Construction Set.")
		return
    end

    if common.spells[id] then
        this.updateSpell(id, spell)
    else
        spell = spell or {}
        spell.id                        = id
        spell.name                      = spell.name or id
        spell.castType                  = spell.castType or "target"
        spell.tooltipDesc               = spell.tooltipDesc
        spell.tooltipClear              = spell.tooltipClear or false
        spell.spellCastEvent            = spell.spellCastEvent or nil
        spell.spellCastedEvent          = spell.spellCastedEvent or nil
        spell.spellCastedFailureEvent   = spell.spellCastedFailureEvent or nil
        spell.spellResistEvent          = spell.spellResistEvent or nil
        spell.spellTickEvent            = spell.spellTickEvent or nil
        spell.combatStartedEvent        = spell.combatStartedEvent or nil
        spell.combatStartedEventDoOnce  = spell.combatStartedEventDoOnce or false
        spell.disableCombatAI           = spell.disableCombatAI or false
        common.spells[id] = spell
    end

    if spell.spellCastEvent then
        event.register("spellCast", spell.spellCastEvent, { filter =  spellObject })
    end
    if spell.spellCastedEvent then
        event.register("spellCasted", spell.spellCastedEvent, { filter =  spellObject })
    end
    if spell.spellCastedFailureEvent then
        event.register("spellCastedFailure", spell.spellCastedFailureEvent, { filter =  spellObject })
    end
    if spell.spellResistEvent then
        event.register("spellResist", spell.spellResistEvent, { filter =  spellObject })
    end
    if spell.spellTickEvent then
        event.register("spellTick", spell.spellTickEvent, { filter =  spellObject })
    end
    if not spell.disableCombatAI then
        if spell.combatStartedEvent then
            event.register("combatStarted", spell.combatStartedEvent, {doOnce = spell.combatStartedEventDoOnce})
        else
            event.register("combatStarted", defaultCombatStartedEvent, {doOnce = spell.combatStartedEventDoOnce})
        end
    end

    event.register("uiSpellTooltip", setTooltip, { filter = spellObject} )

	mwse.log("[Spells Module: INFO] Registered Spell: %s", spell.name )
	return common.spells[id]
end


return this