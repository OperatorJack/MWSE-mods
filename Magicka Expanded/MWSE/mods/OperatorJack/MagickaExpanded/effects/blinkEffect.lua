local common = include("OperatorJack.MagickaExpanded.common")

tes3.claimSpellEffectId("blink", 221)

local function onBlinkCollision(e)
	if e.collision then
		local canTeleport = not tes3.worldController.flagTeleportingDisabled
		if canTeleport then
			local casterX = e.sourceInstance.caster.position.x
			local casterY = e.sourceInstance.caster.position.y
			local collisionX = e.collision.point.x
			local collisionY = e.collision.point.y

			local percent = e.sourceInstance.caster.mobile.mysticism.current / 100
			percent = common.ternary( (percent >= 1) , .95, percent)
			local destX, destY = common.linearInterpolation(casterX, casterY, collisionX, collisionY, percent)

			e.sourceInstance.caster.position.x = destX
			e.sourceInstance.caster.position.y = destY
			e.sourceInstance.caster.position.z = e.collision.point.z
		else
			tes3.messageBox("You are not able to cast that spell here.")
		end
	end
end

local function addBlinkMagicEffect()
	tes3.addMagicEffect({
		-- Base information.
		id = tes3.effect.blink,
		name = "Blink",
		description = "Teleports the caster towards the location they are looking at. Teleportation distance scales with mysticism level.",
		school = tes3.magicSchool.mysticism,

		-- Basic dials.
		baseCost = 100.0,
		speed = 1,

		-- Flags
		allowEnchanting = true,
		allowSpellmaking = false,
		appliesOnce = true,
		canCastSelf = false,
		canCastTarget = true,
		canCastTouch = false,
		casterLinked = false,
		hasContinuousVFX = false,
		hasNoDuration = true,
		hasNoMagnitude = true,
		illegalDaedra = false,
		isHarmful = false,
		nonRecastable = false,
		targetsAttributes = false,
		targetsSkills = false,
		unreflectable = false,
		usesNegativeLighting = false,

		-- Graphics / sounds.
		icon = "s\\tx_s_recall.tga",
		particleTexture = "vfx_particle064.tga",
		castSound = "mysticism cast",
		castVFX = "VFX_MysticismCast",
		boltSound = "mysticism bolt",
		boltVFX = "VFX_MysticismBolt",
		hitSound = "mysticism hit",
		hitVFX = "VFX_MysticismHit",
		areaSound = "mysticism area",
		areaVFX = "VFX_MysticismArea",
		lighting = { 206 / 255, 237 / 255, 255 / 255 },
		size = 1,
		sizeCap = 50,

		-- Callbacks
		onCollision = onBlinkCollision
	})
end

event.register("magicEffectsResolved", addBlinkMagicEffect)