local this = {}
this.createBasicEffect = function(params)
	local effect = tes3.addMagicEffect({
		-- Base information.
		id = params.id,
		name = params.name,
		description = params.description,
		school = tes3.magicSchool.destruction,

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
		icon = params.icon or "s\\tx_s_ab_attrib.tga",
		particleTexture = params.particleTexture or "vfx_alpha_bolt01.tga",
		castSound = params.castSound or "destruction cast",
		castVFX = params.castVFX or "VFX_DestructCast",
		boltSound = params.boltSound or "destruction bolt",
		boltVFX = params.boltVFX or "VFX_DestructBolt",
		hitSound = params.hitSound or "destruction hit",
		hitVFX = params.hitVFX or "VFX_DestructHit",
		areaSound = params.areaSound or "destruction area",
		areaVFX = params.areaVFX or "VFX_DestructArea",
		lighting = params.lighting,
		size = params.size or 1,
		sizeCap = params.sizeCap or 50,

		-- Required callbacks.
        onTick = params.onTick or nil,
        onCollision = params.onCollision or nil
	})

	return effect
end

return this