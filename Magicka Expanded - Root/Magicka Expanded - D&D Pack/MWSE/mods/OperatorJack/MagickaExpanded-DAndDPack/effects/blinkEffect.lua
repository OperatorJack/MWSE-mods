local framework = include("OperatorJack.MagickaExpanded.magickaExpanded")

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
			percent = framework.functions.ternary( (percent >= 1) , .95, percent)
			local destX, destY = framework.functions.linearInterpolation(casterX, casterY, collisionX, collisionY, percent)

			e.sourceInstance.caster.position.x = destX
			e.sourceInstance.caster.position.y = destY
			e.sourceInstance.caster.position.z = e.collision.point.z
		else
			tes3.messageBox("You are not able to cast that spell here.")
		end
	end
end

local function addBlinkMagicEffect()
	framework.effects.mysticism.createBasicEffect({
		-- Base information.
		id = tes3.effect.blink,
		name = "Blink",
		description = "Teleports the caster towards the location they are looking at. Teleportation distance scales with mysticism level.",

		-- Basic dials.
		baseCost = 100.0,

		-- Flags
		allowEnchanting = true,
		appliesOnce = true,
		canCastTarget = true,
		hasNoDuration = true,
		hasNoMagnitude = true,

		-- Graphics / sounds.
		icon = "s\\tx_s_recall.tga",
		particleTexture = "vfx_particle064.tga",
		lighting = { 206 / 255, 237 / 255, 255 / 255 },

		-- Callbacks
		onCollision = onBlinkCollision
	})
end

event.register("magicEffectsResolved", addBlinkMagicEffect)