-- Make sure we have an up-to-date version of MWSE.
if (mwse.buildDate == nil) or (mwse.buildDate < 20190821) then
    event.register("initialized", function()
        tes3.messageBox(
            "[Wands] Your MWSE is out of date!"
            .. " You will need to update to a more recent version to use this mod."
        )
    end)
    return
end

-- Check Magicka Expanded framework.
local framework = include("OperatorJack.MagickaExpanded.magickaExpanded")
if (framework == nil) then
    local function warning()
        tes3.messageBox(
            "[Wands: ERROR] Magicka Expanded framework is not installed!"
            .. " You will need to install it to use this mod."
        )
    end
    event.register("initialized", warning)
    event.register("loaded", warning)
    return
end

local config = require("OperatorJack.Wands.config")

-- Register the mod config menu (using EasyMCM library).
event.register("modConfigReady", function()
    dofile("Data Files\\MWSE\\mods\\OperatorJack\\Wands\\mcm.lua")
end)

local function debug(message)
    if (config.showDebug == true) then
        local prepend = '[Wands: DEBUG] '
        message = prepend .. message
        mwse.log(message)
        tes3.messageBox(message)
    end   
end

local enchantmentPotionId = "OJ_W_EnchantmentPotion"
local function blockPotionEquipEvent(e)
    if (e.item.id == enchantmentPotionId) then
        debug("Blocking Potion equip event.")
        e.claim = true
    end
end

local function onAttack(e)
    -- Ignore non-player references as they will only swing when in range due to AI.
    if (e.reference ~= tes3.player) then
        return
    end

    local weapon = tes3.mobilePlayer.readiedWeapon

    if (weapon == nil) then
        return
    end

    if (weapon.object.enchantment == nil) then
        return
    end
    
    local continue
    if (config.wands[weapon.object.mesh]) then
        debug("Using Wand.")
        continue = true
    elseif (config.applyToStaves == true and weapon.object.type == tes3.weaponType.bluntTwoWide) then
        debug("Using Staff.")
        continue = true
    end

    if (continue) then  
        local chargeCost = weapon.object.enchantment.chargeCost * 1.1
        -- If not enough charge is remaining on the enchantment, don't cast.
        if (weapon.variables.charge < chargeCost) then
            debug("Inadequate charge remaining to perform cast. Returning...")
            return
        end

        -- If there is a target reference and the enchantment is type On Strike, don't cast.
        if (e.targetReference and weapon.object.enchantment.castType == tes3.enchantmentType.onStrike) then
            debug("Valid Target Reference found for On Strike. Returning...")
            return
        end

        debug("Creating potion.")
        local effects = {}
        for i=1, #weapon.object.enchantment.effects do
            local enchantmentEffect = weapon.object.enchantment.effects[i]
            local effect = {}
            effect.id = enchantmentEffect.id
            effect.range = tes3.effectRange.target
            effect.min = enchantmentEffect.min or 0
            effect.max = enchantmentEffect.max or 0
            effect.duration = enchantmentEffect.duration or 1
            effect.radius = enchantmentEffect.radius or 0
            
            effects[i] = effect
        end

        local potion = framework.alchemy.createComplexPotion({
            id = enchantmentPotionId,
            name = "Enchantment Potion",
            effects = effects
        })

        debug("Drinking potion.")
        mwscript.equip({
            reference = e.reference,
            item = potion
        })

        debug("Reducing Enchantment charge.")
        weapon.variables.charge = weapon.variables.charge - chargeCost
    end
end

local function onInitialized()
	--Watch for weapon swing.
    event.register("attack", onAttack)
    event.register("equip", blockPotionEquipEvent, {priority = 1e+06})
    event.register("equipped", blockPotionEquipEvent, {priority = 1e+06})

	print("[Wands: INFO] Initialized Wands")
end
event.register("initialized", onInitialized)