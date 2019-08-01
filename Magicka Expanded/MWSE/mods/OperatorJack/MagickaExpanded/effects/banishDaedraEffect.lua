local common = include("OperatorJack.MagickaExpanded.common")

local BanishDaedraEffect = {
	name = "Banish Daedra",
	id = "banishDaedra",
	description = "Banishes a daedric creature back to its originating plane. The effect's magnitude is the maximum level of daedra that it can banish."
}

common.claimSpellEffectId("banishDaedria", 220)

-- Written by NullCascade.
local function onBanishDaedraTick(e)
	mwse.log("Spell state: %d", e.effectInstance.state)

	-- Ignore any non-daedric opponents.
	if (e.effectInstance.target.object.type ~= tes3.creatureType.daedra) then
		e.effectInstance.state = tes3.spellState.retired
		return
	end

	tes3.setEnabled({ reference = e.effectInstance.target, enabled = false })
	tes3.messageBox("%s has been banished!", e.effectInstance.target.baseObject)
	
	e.effectInstance.state = tes3.spellState.retired
end

-- Written by NullCascade.
local function addBanishDaedraEffect()
	tes3.addMagicEffect({
		-- Base information.
		id = tes3.effect.banishDaedra,
		name = BanishDaedraEffect.name,
		description = BanishDaedraEffect.description,
		school = tes3.magicSchool.conjuration,

		-- Basic dials.
		baseCost = 2.0,
		speed = 1,

		-- Various flags.
		allowEnchanting = true,
		allowSpellmaking = true,
		appliesOnce = true,
		canCastSelf = false,
		canCastTarget = true,
		canCastTouch = true,
		casterLinked = false,
		hasContinuousVFX = false,
		hasNoDuration = true,
		hasNoMagnitude = false,
		illegalDaedra = false,
		isHarmful = false,
		nonRecastable = true,
		targetsAttributes = false,
		targetsSkills = false,
		unreflectable = true,
		usesNegativeLighting = false,

		-- Graphics/sounds.
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

		-- Required callbacks.
		onTick = onBanishDaedraTick,
	})
end

event.register("magicEffectsResolved", addBanishDaedraEffect)