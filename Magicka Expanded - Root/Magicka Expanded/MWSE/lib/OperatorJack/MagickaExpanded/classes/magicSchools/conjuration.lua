local this = {}
this.createBasicEffect = function(params)
	local effect = tes3.addMagicEffect({
		-- Base information.
		id = params.id,
		name = params.name,
		description = params.description,
		school = tes3.magicSchool.conjuration,

		-- Basic dials.
		baseCost = params.cost,
		speed = params.speed or 1,

		-- Various flags.
		allowEnchanting = params.allowEnchanting or false,
		allowSpellmaking = params.allowSpellmaking or false,
		appliesOnce = params.appliesOnce or false,
		canCastSelf = params.canCastSelf or false,
		canCastTarget = params.canCastTarget or false,
		canCastTouch = params.canCastTouch or false,
		casterLinked = params.casterLinked or false,
		hasContinuousVFX =  params.hasContinuousVFX or false,
		hasNoDuration = params.hasNoDuration or false,
		hasNoMagnitude = params.hasNoMagnitude or false,
		illegalDaedra = params.illegalDaedra or false,
		isHarmful = params.isHarmful or false,
		nonRecastable = params.nonRecastable or false,
		targetsAttributes = params.targetsAttributes or false,
		targetsSkills = params.targetsSkills or false,
		unreflectable = params.unreflectable or false,
		usesNegativeLighting = params.usesNegativeLighting or false,

		-- Graphics/sounds.
		icon = params.icon or "RFD\\RFD_ms_conjuration.tga",
		particleTexture = params.particleTexture or "vfx_conj_flare02.tga",
		castSound = params.castSound or "conjuration cast",
		castVFX = params.castVFX or "VFX_ConjureCast",
		boltSound = params.boltSound or "conjuration bolt",
		boltVFX = params.boltVFX or "VFX_DefaultBolt",
		hitSound = params.hitSound or "conjuration hit",
		hitVFX = params.hitVFX or "VFX_DefaultHit",
		areaSound = params.areaSound or "conjuration area",
		areaVFX = params.areaVFX or "VFX_DefaultArea",
		lighting = params.lighting,
		size = params.size or 1,
		sizeCap = params.sizeCap or 50,

		-- Required callbacks.
        onTick = params.onTick or nil,
        onCollision = params.onCollision or nil
	})

	return effect
end

this.createBasicBoundArmorEffect = function(params)
	local effect = this.createBasicEffect({
        -- Use Basic effect function.  Use default for other fields.
        --------------------
		-- Base information.
		id = params.id,
		name = params.name,
		description = params.description,

		-- Basic dials.
        baseCost = params.cost,
        
        -- Various flags.
        allowEnchanting = true,
        allowSpellmaking = true,
        appliesOnce = true,
        canCastSelf = true,
        hasNoMagnitude = true,

		-- Graphics/sounds.
		icon = params.icon or "RFD\\RFD_ms_conjuration.tga",
		particleTexture = params.particleTexture or "vfx_conj_flare02.tga",
        lighting = { 0.99, 0.95, 0.67 },

		-- Required callbacks.
		onTick = function(e)
			e:triggerBoundArmor(params.armorId, params.armorId2)
		end,
	})

	return effect
end

this.createBasicBoundWeaponEffect = function(params)
	local effect = this.createBasicEffect({
        -- Use Basic effect function.  Use default for other fields.
        --------------------
		-- Base information.
		id = params.id,
		name = params.name,
		description = params.description,

		-- Basic dials.
        baseCost = params.cost,
        
        -- Various flags.
        allowEnchanting = true,
        allowSpellmaking = true,
        appliesOnce = true,
        canCastSelf = true,
        hasNoMagnitude = true,

		-- Graphics/sounds.
		icon = params.icon or "RFD\\RFD_ms_conjuration.tga",
		particleTexture = params.particleTexture or "vfx_conj_flare02.tga",
        lighting = { 0.99, 0.95, 0.67 },

		-- Required callbacks.
		onTick = function(e)
			e:triggerBoundWeapon(params.weaponId)
		end,
	})

	return effect
end

this.createBasicSummoningEffect = function(params)
	local effect = this.createBasicEffect({
        -- Use Basic effect function.  Use default for other fields.
        --------------------
		-- Base information.
		id = params.id,
		name = params.name,
		description = params.description,

		-- Basic dials.
        baseCost = params.cost,
        
        -- Various flags.
        allowEnchanting = true,
        allowSpellmaking = true,
        appliesOnce = true,
        canCastSelf = true,
        hasNoMagnitude = true,

		-- Graphics/sounds.
		icon = params.icon or "RFD\\RFD_ms_conjuration.tga",
		particleTexture = params.particleTexture or "vfx_conj_flare02.tga",
        lighting = { 0.99, 0.95, 0.67 },

		-- Required callbacks.
		onTick = function(e)
            e:triggerSummon(params.creatureId)
        end,
	})

	return effect
end

return this