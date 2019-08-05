local this = {}

this.options = {
    general = {
        debugMode = {
            On = "On",
            Off = "Off"
        }
    }
}

-- Load configuration.
this.config = mwse.loadConfig("Magicka Expanded") or {}

-- Initialize settings.
this.config.debugMode = this.config.debugMode or this.options.general.debugMode.On

this.debug = function (message)
    if (this.config.debugMode == this.options.general.debugMode.On) then
        local prepend = '[Magicka Expanded: DEBUG] '
        mwse.log(prepend .. message)
        tes3.messageBox(prepend .. message)
    end
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

this.linearInterpolation = function(x1, y1, x2, y2, percent)
	return (x1 + ((x2 - x1) * percent)), (y1 + ((y2 - y1) * percent))
end

this.ternary = function(condition, T, F)
	if condition then return T else return F end
end

this.createSimpleSpell = function(params)
	local spell = tes3.getObject(params.id) or tes3spell.create(params.id, params.name)
	spell.magickaCost = 0

	local effect = spell.effects[1]
	effect.id = params.effect
	effect.rangeType = params.range or tes3.effectRange.self
	effect.min = params.min or 0
	effect.max = params.max or 0
    effect.duration = params.duration or 0
    effect.radius = params.radius or 0

    this.addSpellToSpellsList(spell)

    return spell
end

this.createSimpleBoundArmorEffect = function(params)
	tes3.addMagicEffect({
		-- Base information.
		id = params.id,
		name = params.name,
		description = params.description,
		school = tes3.magicSchool.conjuration,

		-- Basic dials.
		baseCost = params.cost,
		speed = 1,

		-- Various flags.
		allowEnchanting = true,
		allowSpellmaking = true,
		appliesOnce = true,
		canCastSelf = true,
		canCastTarget = false,
		canCastTouch = false,
		casterLinked = false,
		hasContinuousVFX = false,
		hasNoDuration = false,
		hasNoMagnitude = true,
		illegalDaedra = false,
		isHarmful = false,
		nonRecastable = true,
		targetsAttributes = false,
		targetsSkills = false,
		unreflectable = false,
		usesNegativeLighting = false,

		-- Graphics/sounds.
		icon = "s\\tx_s_ab_attrib.tga",
		particleTexture = "vfx_myst_flare01.tga",
		castSound = "conjuration cast",
		castVFX = "VFX_ConjureCast",
		boltSound = "conjuration bolt",
		boltVFX = "VFX_ConjureBolt",
		hitSound = "conjuration hit",
		hitVFX = "VFX_DefaultHit",
		areaSound = "conjuration area",
		areaVFX = "VFX_ConjureArea",
		lighting = { 0.99, 0.95, 0.67 },
		size = 1,
		sizeCap = 50,

		-- Required callbacks.
		onTick = function(e)
			e:triggerBoundArmor(params.armorId, params.armorId2)
		end,
	})
end
this.createSimpleBoundWeaponEffect  = function(params)
	tes3.addMagicEffect({
		-- Base information.
		id = params.id,
		name = params.name,
		description = params.description,
		school = tes3.magicSchool.conjuration,

		-- Basic dials.
		baseCost = params.cost,
		speed = 1,

		-- Various flags.
		allowEnchanting = true,
		allowSpellmaking = true,
		appliesOnce = true,
		canCastSelf = true,
		canCastTarget = false,
		canCastTouch = false,
		casterLinked = false,
		hasContinuousVFX = false,
		hasNoDuration = false,
		hasNoMagnitude = true,
		illegalDaedra = false,
		isHarmful = false,
		nonRecastable = true,
		targetsAttributes = false,
		targetsSkills = false,
		unreflectable = false,
		usesNegativeLighting = false,

		-- Graphics/sounds.
		icon = "s\\tx_s_ab_attrib.tga",
		particleTexture = "vfx_myst_flare01.tga",
		castSound = "conjuration cast",
		castVFX = "VFX_ConjureCast",
		boltSound = "conjuration bolt",
		boltVFX = "VFX_ConjureBolt",
		hitSound = "conjuration hit",
		hitVFX = "VFX_DefaultHit",
		areaSound = "conjuration area",
		areaVFX = "VFX_ConjureArea",
		lighting = { 0.99, 0.95, 0.67 },
		size = 1,
		sizeCap = 50,

		-- Required callbacks.
		onTick = function(e)
			e:triggerBoundWeapon(params.weaponId)
		end,
	})
end

this.createSimpleSummoningEffect = function(params)
    tes3.addMagicEffect({
        -- Base information.
        id = params.id,
        name = params.name,
        description = params.description,
        school = tes3.magicSchool.conjuration,

        -- Basic dials.
        baseCost = params.cost,
        speed = 1,

        -- Various flags.
        allowEnchanting = true,
        allowSpellmaking = true,
        appliesOnce = true,
        canCastSelf = true,
        canCastTarget = false,
        canCastTouch = false,
        casterLinked = false,
        hasContinuousVFX = false,
        hasNoDuration = false,
        hasNoMagnitude = true,
        illegalDaedra = false,
        isHarmful = false,
        nonRecastable = false,
        targetsAttributes = false,
        targetsSkills = false,
        unreflectable = false,
        usesNegativeLighting = false,

        -- Graphics/sounds.
        icon = "s\\tx_s_ab_attrib.tga",
        particleTexture = "vfx_myst_flare01.tga",
        castSound = "conjuration cast",
        castVFX = "VFX_ConjureCast",
        boltSound = "conjuration bolt",
        boltVFX = "VFX_ConjureBolt",
        hitSound = "conjuration hit",
        hitVFX = "VFX_DefaultHit",
        areaSound = "conjuration area",
        areaVFX = "VFX_ConjureArea",
        lighting = { 0.99, 0.95, 0.67 },
        size = 1,
        sizeCap = 50,

        -- Required callbacks.
        onTick = function(e)
            e:triggerSummon(params.creatureId)
        end,
    })
end

this.hasSpell =  function(actor, spell)
	return actor.object.spells:contains(spell)
end

this.canCastSpell = function(actor, spell)
    if not this.hasSpell(actor, spell) then
        return false
    end

    if (actor.magicka.current <= spell.magickaCost) then
        return false
    end

    return true
end

this.castSpell = function(actor, target, spell)
    tes3.cast({
        reference = actor,
        target = target,
        spell = spell
    })

    actor.magicka.current = actor.magicka.current - spell.magickaCost
end




return this
