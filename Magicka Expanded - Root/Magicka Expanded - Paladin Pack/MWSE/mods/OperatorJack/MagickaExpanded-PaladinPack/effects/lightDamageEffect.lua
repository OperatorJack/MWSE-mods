local framework = include("OperatorJack.MagickaExpanded.magickaExpanded")

tes3.claimSpellEffectId("lightDamage", 222)
local function resistEffect(e)
	framework.debug("Resist Check start.")

	local reference = e.effectInstance.target
	local mobile = reference.mobile
	if (reference.baseObject.type ~= tes3.creatureType.undead) then
		framework.debug("Resist Check: Is Not Undead")
		local vampirism = tes3.getObject("vampire sun damage")
		if (mobile.object.spells:contains(vampirism) == false) then
			framework.debug("Resist Check: Is Not Vampire")
			return true
		end
	end

	framework.debug("Resist Check failed. Damage should be done. ")

	return false
end

local function onLightDamageTick(e)
	-- Get the target's mobile actor.
    local mobile = e.effectInstance.target.mobile

    -- Trigger the modification to the statistic through the event system.
    e:trigger({
        value = mobile.health,
        type = tes3.effectEventType.modStatistic,
        negateOnExpiry = false,
        resistanceCheck = resistEffect,
    })
end

-- Written by NullCascade.
local function addLightDamageEffect()
	framework.effects.restoration.createBasicEffect({
		-- Base information.
		id = tes3.effect.lightDamage,
		name = "Light Damage",
        description = "Produces a manifestation of pure light." ..
        " Upon contact with the undead, this manifestation intensifies, causing damage.",

		-- Basic dials.
		baseCost = 2.0,
		speed = 1.35,

		-- Various flags.
		allowEnchanting = true,
		allowSpellmaking = true,
		appliesOnce = true,
		canCastSelf = true,
		canCastTarget = true,
		canCastTouch = true,
		nonRecastable = true,

		-- Graphics/sounds.
		icon = "RFD\\RFD_pd_lightdmg.dds",
		particleTexture = "OJ\\ME\\VFX_whiteglowalpha.tga",
		castSound = "destruction cast",
		castVFX = "VFX_IllusionCast",
		boltSound = "destruction bolt",
		boltVFX = "VFX_DestructBolt",
		hitSound = "destruction hit",
		hitVFX = "VFX_LightDamageHit",
		areaSound = "destruction area",
		areaVFX = "VFX_LightDamageArea",
		lighting = { 255 / 255, 255 / 255, 255 / 255 },

		-- Required callbacks.
		onTick = onLightDamageTick,
	})
end

event.register("magicEffectsResolved", addLightDamageEffect)