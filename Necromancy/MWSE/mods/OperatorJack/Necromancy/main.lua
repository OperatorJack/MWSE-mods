if (mwse.buildDate == nil) or (mwse.buildDate < 20181102) then
    local function warning()
        tes3.messageBox(
            "[Necromancy ERROR] Your MWSE is out of date!"
            .. " You will need to update to a more recent version to use this mod."
        )
    end
    event.register("initialized", warning)
    event.register("loaded", warning)
    return
end

local skillModule = require("OtherSkills.skillModule")
local common = require("OperatorJack.Necromancy.common")


if not skillModule then
    local function warningSkill()
        tes3.messageBox(
            "[Necromancy ERROR] You need to install Skills Module to use this mod!"
        )
    end
    event.register("initialized", warningSkill)
    event.register("loaded", warningSkill)
    return
end

local function initialized(e)
	if not tes3.isModActive("Necromancy.ESP") then
		print("[Necromancy: INFO] ESP not loaded")
		return
	end

	
	local necroSkill = require("OperatorJack.Necromancy.necroSkill")
	print("[Necromancy: INFO] Initialized Necromancy")
end
event.register("initialized", initialized)

--SKILLS------------------------------------------------------
local function onSkillsReady()
	skillModule.registerSkill(
		common.necromancySkillId, 
		{	name 			=		"Necromancy", 
			icon 			=		"Icons/OperatorJack/Necromancy/necromancy.dds", 
			value			= 		15,
			attribute 		=		tes3.attribute.intelligence,
            description 	= 		"Necromancy is the manipulation of the souls or corpses of the dead. Different groups and cultures have varying positions on what exactly constitutes necromancy."
                                    .. " In its broadest sense, necromancy can be understood as any form of soul manipulation."
                                    .. " Some might consider it a subset of the conjuration school of magic, as both involve the summoning of spirits and utilizing the powers of Oblivion."
                                    .. " However, necromancy is more generally understood to connote the manipulation of the souls of mortals and the reanimation of their corpses."
                                    .. " Typically, this soul manipulation is accomplished by binding a soul to a physical form which has been prepared by the necromancer.",
			specialization 	= 		tes3.specialization.magic,
			active			= 		"active"
		}
	)
end
event.register("OtherSkills:Ready", onSkillsReady)