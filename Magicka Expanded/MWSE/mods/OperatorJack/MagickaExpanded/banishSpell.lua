local spellsModule = include("SpellsModule.spellsModule")
local common = include("OperatorJack.MagickaExpanded.common")

local Banish = {
    name = "Banish",
    id = "OJ_ME_Banish",
    tooltip = "Teleports the Target to the Abyss for - seconds.",
    banishCellId = "OJ_ME_AbyssCell",
    banishPosition = {5053, 1950, 17825},
    banishOrientation = {0, 0, 172}
    }


local function spawnBanishActivator(previousLocation)
    common.debugMessage("[Magicka Expanded: INFO] Spawning Acti")
    -- Spawn activator behind PC
    local ref = mwscript.placeAtPC{object="OJ_ME_BanishMummy"}
    ref.orientation = previousLocation.orientation:copy()
    ref.position = previousLocation.position:copy()
    ref.position = previousLocation.position.z + 50
    -- Exploded spell for VFX
    mwscript.explodeSpell({
        reference = ref,
        spell = "OJ_ME_Banish_ExplodeSpell"
    })

    return ref
end

local function despawnBanishActivator(ref)
    -- Exploded spell for VFX
    mwscript.explodeSpell({
        reference = ref,
        spell = "OJ_ME_Banish_ExplodeSpell"
    })

    -- Remove activator
    mwscript.disable({
        reference = ref
    })
end

local function getBanishDuration(mysticismLevel)
    return math.floor(5 + (mysticismLevel / 4))
end


local function getBanishTooltip(mysticismLevel)
    return string.gsub(Banish.tooltip, "-", getBanishDuration(mysticismLevel))
end

local function onBanishCombatStarted(e)
	if e.actor ~= tes3.mobilePlayer and e.target then
		local spellObject = tes3.getObject(Banish.id)
        if common.canCastSpell(e.actor, spellObject) then
            common.debugMessage("[Magicka Expanded: INFO] NPC Casting Banish")
            common.castSpell({
                actor = e.actor,
                target = e.target,
                spell = spellObject
            })
        end
	end
end

local function onBanishExpiration(actor, previousLocation, ref)
    local params={
        reference = actor,
        position = previousLocation.position,
        orientation = previousLocation.orientation,
        cell = previousLocation.cell
    }

    despawnBanishActivator(ref)

    tes3.positionCell(params)
end

local function onBanishSpellResist(e)
    if e.target then
        local timerDuration = getBanishDuration(e.caster.mobile.mysticism.current)

        local previousLocation={
			position = e.target.position:copy(),
			orientation = e.target.orientation:copy(),
			cell = e.target.cell
		}

		local params={
			reference = e.target,
			position = Banish.banishPosition,
			orientation = Banish.banishOrientation,
			cell = Banish.banishCellId
        }

        tes3.positionCell(params)

        local activatorRef = spawnBanishActivator(previousLocation)

        timer.start({
            duration = timerDuration,
            callback = function() onBanishExpiration(e.target, previousLocation, activatorRef) end
        })
    end
end

local function registerSpell()
    if spellsModule then
        spellsModule.registerSpell(
            Banish.id,
            {
                id = Banish.id,
                name = Banish.name,
                tooltipDesc = getBanishTooltip(tes3.mobilePlayer.mysticism.current),
                tooltipClear = true,
                spellResistEvent = onBanishSpellResist,
				combatStartedEvent = onBanishCombatStarted,
            }
        )
    end
end

event.register("SpellsModule:Register", registerSpell)
