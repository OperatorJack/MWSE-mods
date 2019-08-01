local common = include("OperatorJack.MagickaExpanded.common")

local BlinkSpell = {
    name = "Blink",
    id = "OJ_ME_Blink",
}
	
local BlinkEffect = {
	name = "Blink",
	id = "blink",
	description = "Teleports the caster towards the location they are looking at. Teleportation distance scales with mysticism level."
}

common.claimSpellEffectId("blink", 221)

local function onBlinkTick(e)
	mwse.log("Spell state: %d", e.effectInstance.state)

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
			
			e.effectInstance.state = tes3.spellState.retired
			return
		else
			tes3.messageBox("You are not able to cast that spell here.")
			e.effectInstance.state = tes3.spellState.retired
			return
		end
	end
end

local function addBlinkMagicEffect()
	tes3.addMagicEffect({
		-- Base information.
		id = tes3.effect.blink,
		name = BlinkEffect.name,
		description = BlinkEffect.description,
		school = tes3.magicSchool.mysticism,

		-- Basic dials.
		baseCost = 2.0,
		speed = 1,

		-- Flags
		allowEnchanting = false,
		allowSpellmaking = true,
		appliesOnce = true,
		canCastSelf = true,
		canCastTarget = false,
		canCastTouch = false,
		casterLinked = true, -- ?????
		hasContinuousVFX = false,
		hasNoDuration = true,
		hasNoMagnitude = true,
		illegalDaedra = false,
		isHarmful = false,
		nonRecastable = false,
		targetAttributes = false,
		targetSkills = false,
		unreflectable = true,
		usesNegativeLighting = false,

		-- Graphics / sounds.
		-- Must be updated to teleport VFX.
		icon = "s\\tx_s_ab_attrib.tga",
		particleTexture = "vfx_myst_flare01",
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

		-- Callbacks
		onTick = onBlinkTick
	})
end

event.register("magicEffectsResolved", addBlinkMagicEffect)

local function registerSpell()
	local spell = common.createSimpleSpell({
		id = BlinkSpell.id,
		name = BlinkSpell.name,
		effect = tes3.effect.blink,
		range = tes3.effectRange.self
	})
end

event.register("SpellsModule:Register", registerSpell)