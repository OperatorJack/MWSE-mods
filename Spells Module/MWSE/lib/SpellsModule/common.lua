local this = {}
local debug = true
this.debugMessage = function(string)
	if debug then
		tes3.messageBox(string)
		mwse.log("[Spells Module: DEBUG] " .. string)
	end
end

local function loaded(e)
	--local shortcut
	this.spells = {}
	event.trigger("SpellsModule:Register")
	print("[Spells Module: INFO] Player data loaded")
end
event.register("loaded", loaded )

return this
