local framework = include("OperatorJack.MagickaExpanded.magickaExpanded")

tes3.claimSpellEffectId("lightDamage", 222)

local function onLightDamageTick(e)
	-- Trigger into the spell system.
	if (not e:trigger()) then
		return
	end


	-- Only damage undead opponents.
	if (e.effectInstance.target.object.type ~= tes3.creatureType.undead) then
		-- Or Vampires
		local vampirism = tes3.getObject("vampire sun damage")
		if (e.effectInstance.target.mobile.object.spells:contains(vampirism) == false) then
			e.effectInstance.state = tes3.spellState.retired
			return
		end
	end

	local damage = e.effectInstance.magnitude
	e.effectInstance.target.mobile:applyHealthDamage(damage)
	framework.debug("Dealt " .. damage .. " to target " .. e.effectInstance.target.id)

	e.effectInstance.state = tes3.spellState.retired
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