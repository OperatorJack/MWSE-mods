local this = {}

this.necromancySkillId = "NecromancySkill"

local function loaded(e)
	--Persistent data stored on player reference 
	-- ensure data table exists
	local data = tes3.getPlayerRef().data
	
	print("[Necromancy: INFO] player data loaded")
end
	
	
event.register("loaded", loaded )

return this