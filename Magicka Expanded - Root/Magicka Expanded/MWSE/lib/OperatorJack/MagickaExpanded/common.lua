local this = {}

this.info = function (message)
    local prepend = '[Magicka Expanded: INFO] '
    mwse.log(prepend .. message)
    tes3.messageBox(prepend .. message)
end

this.debug = function (message)
    local prepend = '[Magicka Expanded: DEBUG] '
    mwse.log(prepend .. message)
    tes3.messageBox(prepend .. message)
end

this.error = function (message)
    local prepend = '[Magicka Expanded: ERROR] '
    mwse.log(prepend .. message)
    tes3.messageBox(prepend .. message)
end

this.spells = {}

this.addSpellToSpellsList = function(spell)
	table.insert(this.spells, spell)
end

this.addTestSpellsToPlayer = function()
    for i = 1,#this.spells do
        local spell = this.spells[i]
		mwscript.addSpell({reference = tes3.player, spell = spell})
	end

	this.debug("Added Test Spells to Player.")
end

return this