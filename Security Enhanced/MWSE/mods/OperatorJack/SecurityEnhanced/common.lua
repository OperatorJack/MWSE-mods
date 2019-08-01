local this = {}


this.options = {
    lockpick ={
        equipHotKeyCycle = {
            NextLockpick = "NEXT",
            ReequipWeapon = "WEAPON"
        },
        equipOrder = {
            BestLockpickFirst = "BEST",
            WorstLockpicKFirst = "WORST"
        },
        autoEquipOnActivate = {
            On = "On",
            Off = "Off"
        },
        autoEquipOnBreak = {
            On = "On",
            Off = "Off"
        }
    },
    probe = {
        equipHotKeyCycle = {
            NextProbe = "NEXT",
            ReequipWeapon = "WEAPON"
        },
        equipOrder = {
            BestProbeFirst = "BEST",
            WorstProbeFirst = "WORST"
        },
        autoEquipOnActivate = {
            On = "On",
            Off = "Off"
        },
        autoEquipOnBreak = {
            On = "On",
            Off = "Off"
        }
    },
    general = {
        enableKeyPossessionIndicator= {
            On = "On",
            Off = "Off"
        },
        debugMode = {
            On = "On",
            Off = "Off"
        }
    }
}

-- Load configuration.
this.config = mwse.loadConfig("Security Enhanced") or {}

-- Initialize lockpick settings.
this.config.lockpickEquipHotKey = this.config.lockpickEquipHotKey or {
    keyCode = tes3.scanCode.l,
    isShiftDown = false,
    isAltDown = false,
    isControlDown = false,
}
this.config.lockpickEquipHotKeyCycle = this.config.lockpickEquipHotKeyCycle or this.options.lockpick.equipHotKeyCycle.ReequipWeapon
this.config.lockpickEquipOrder = this.config.lockpickEquipOrder or this.options.lockpick.equipOrder.BestLockpickFirst
this.config.lockpickAutoEquipOnActivate = this.config.lockpickAutoEquipOnActivate or this.options.lockpick.autoEquipOnActivate.On
this.config.lockpickAutoEquipOnBreak = this.config.lockpickAutoEquipOnBreak or this.options.lockpick.autoEquipOnBreak.Off

-- Initialize probe settings.
this.config.probeEquipHotKey = this.config.probeEquipHotKey or {
    keyCode = tes3.scanCode.p,
    isShiftDown = false,
    isAltDown = false,
    isControlDown = false,
}
this.config.probeEquipHotKeyCycle = this.config.probeEquipHotKeyCycle or this.options.probe.equipHotKeyCycle.ReequipWeapon
this.config.probeEquipOrder = this.config.probeEquipOrder or this.options.probe.equipOrder.BestProbeFirst
this.config.probeAutoEquipOnActivate = this.config.probeAutoEquipOnActivate or this.options.probe.autoEquipOnActivate.On
this.config.probeAutoEquipOnBreak = this.config.probeAutoEquipOnBreak or this.options.probe.autoEquipOnBreak.Off

-- Initialize other settings.
this.config.enableKeyPossessionIndicator = this.config.enableKeyPossessionIndicator or this.options.general.enableKeyPossessionIndicator.On
this.config.debugMode = this.config.debugMode or this.options.general.debugMode.On

this.debug = function (message)
    if (this.config.debugMode == this.options.general.debugMode.On) then
        local prepend = '[Security Enhanced: DEBUG] '
        mwse.log(prepend .. message)
        tes3.messageBox(prepend .. message)
    end
end

-- Store currently equipped weapon for re-equip.
this.lastWeapon = {}
this.saveCurrentEquipment = function ()
    if (lastWeapon) then
        return
    end
    lastWeapon = nil

    -- Store the currently equipped weapon, if any.
    local weaponStack = tes3.getEquippedItem({
        actor = tes3.player,
        objectType = tes3.objectType.weapon
    })
    if (weaponStack) then
        this.debug('Saving Weapon ID: ' .. weaponStack.object.id)
        lastWeapon = weaponStack.object
    end
end

this.reequipEquipment = function ()
    -- If we had a weapon equipped before, re-equip it.
    if (lastWeapon) then
        mwscript.equip{ reference = tes3.player, item = lastWeapon }
    end
end

this.getSortedInventoryByObjectType = function (objectType)
    local objects = {}
    for node in tes3.iterate(tes3.player.object.inventory.iterator) do
        if (node.object.objectType == objectType) then
            table.insert(objects, node.object)
        end
    end
    table.sort(
        objects,
        function(a, b)
            return a.quality < b.quality
        end
    )
    return objects
end

this.getBestObjectByObjectType = function (objectType)
    local objects = this.getSortedInventoryByObjectType(objectType)
    local object = objects[#objects]

    this.debug("Found Best Object: Selected Object:" .. object.id)
    return object
end

this.getNextBestObjectByObjectType = function (objectType, currentObject)
    local objects = this.getSortedInventoryByObjectType(objectType)
    local object

    for i = 1,#objects do
        local nodeObject = objects[i]
        if (nodeObject.quality > currentObject.quality) then
            object = nodeObject
            break
        end
    end

    if (object == nil) then
        object = objects[1]
    end

    this.debug("Found Next Best Object: Selected Object:" .. object.id)
    return object
end


this.getWorstObjectByObjectType = function (objectType)
    local objects = this.getSortedInventoryByObjectType(objectType)
    local object = objects[1]

    this.debug("Found Worst Object: Selected Object:" .. object.id)
    return object
end

return this