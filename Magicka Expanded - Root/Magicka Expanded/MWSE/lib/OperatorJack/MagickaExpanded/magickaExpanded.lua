local common = require("OperatorJack.MagickaExpanded.common")

local this = {}

this.info = function(message)
	common.info(message)
end
this.debug = function(message)
	common.debug(message)
end
this.error = function(message)
	common.error(message)
end

this.getActiveSpells = function()
	return common.spells
end

this.spells = require("OperatorJack.MagickaExpanded.classes.spells")

this.effects =  require("OperatorJack.MagickaExpanded.classes.effects")

this.functions =  require("OperatorJack.MagickaExpanded.classes.functions")

local function onLoaded()
    event.trigger("MagickaExpanded:Register")
	this.info("Magicka Expanded Framework Initialized")
	common.addTestSpellsToPlayer()
end

event.register("loaded", onLoaded)

return this