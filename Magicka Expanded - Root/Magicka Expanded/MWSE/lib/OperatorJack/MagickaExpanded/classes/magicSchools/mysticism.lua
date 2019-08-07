local this = {}
this.createBasicEffect = function(params)
	local effect = tes3.addMagicEffect({
		-- Base information.
		id = params.id,
		name = params.name,
		description = params.description,
		school = tes3.magicSchool.mysticism,

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
		particleTexture = params.particleTexture or "vfx_myst_flare01.tga",
		castSound = params.castSound or "mysticism cast",
		castVFX = params.castVFX or "VFX_MysticismCast",
		boltSound = params.boltSound or "mysticism bolt",
		boltVFX = params.boltVFX or "VFX_MysticismBolt",
		hitSound = params.hitSound or "mysticism hit",
		hitVFX = params.hitVFX or "VFX_MysticismHit",
		areaSound = params.areaSound or "mysticism area",
		areaVFX = params.areaVFX or "VFX_MysticismArea",
		lighting = params.lighting,
		size = params.size or 1,
		sizeCap = params.sizeCap or 50,

		-- Required callbacks.
        onTick = params.onTick or nil,
        onCollision = params.onCollision or nil
	})

	return effect
end

this.createBasicTeleportationEffect = function(params)
	local effect = this.createBasicEffect({
		-- Base information.
		id = params.id,
		name = params.name,
		description = params.description,

		-- Basic dials.
		baseCost = params.cost,

		-- Various flags.
		allowEnchanting = true,
		appliesOnce = true,
		canCastSelf = true,
		hasNoDuration = true,
		hasNoMagnitude = true,
		nonRecastable = true,
		unreflectable = true,

		-- Graphics/sounds.
		icon = "s\\tx_s_ab_attrib.tga",
		lighting = { 0.99, 0.95, 0.67 },

		-- Required callbacks.
		onTick = function(e)
			local teleportParams = {
				reference = e.sourceInstance.caster,
				position = params.positionCell.position,
				orientation = params.positionCell.orientation,
				cell = params.positionCell.cell
			}
			tes3.positionCell(teleportParams)
		end,
	})

	return effect
end

return this