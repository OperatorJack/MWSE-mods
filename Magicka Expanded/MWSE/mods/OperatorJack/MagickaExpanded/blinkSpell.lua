local spellsModule = include("SpellsModule.spellsModule")
local common = include("OperatorJack.MagickaExpanded.common")

local Blink = {
    name = "Blink",
    id = "OJ_ME_Blink",
    tooltip = "Teleports the Caster to within a few paces of the target.",
    }

local function  onBlinkSpellResist(e)
	if e.target then
		local canTeleport = not tes3.worldController.flagTeleportingDisabled
		if canTeleport then
			local casterX = e.caster.position.x
			local casterY = e.caster.position.y
			local targetX = e.target.position.x
			local targetY = e.target.position.y

			local percent = e.caster.mobile.mysticism.current / 100
			percent = common.ternary( (percent >= 1) , .95, percent)
			local destX, destY = common.linearInterpolation(casterX, casterY, targetX, targetY, percent)

			e.caster.position.x = destX
			e.caster.position.y = destY
			e.caster.position.z = e.target.position.z
		else
			tes3.messageBox("You are not able to cast that spell here.")
		end
	end
end

local function onBlinkCombatStarted(e)
	if e.actor ~= tes3.mobilePlayer and e.target then
		local spellObject = tes3.getObject(Blink.id)
		if common.canCastSpell(e.actor, spellObject) then
			if e.target.position:distance(e.actor.position) > 250 then
				if math.random(10) > 7 then
					common.debugMessage("[Magicka Expanded: INFO] NPC Casting Blink")
					common.castSpell({
						actor = e.actor,
						target = e.target,
						spell = spellObject
					})
				end
			end
		end
	end
end

local function registerSpell()
    if spellsModule then
        spellsModule.registerSpell(
            Blink.id,
            {
				id = Blink.id,
				name = Blink.name,
				tooltipDesc = Blink.tooltip,
				tooltipClear = true,
				spellResistEvent = onBlinkSpellResist,
				combatStartedEvent = onBlinkCombatStarted
            }
        )
    end
end

event.register("SpellsModule:Register", registerSpell)
