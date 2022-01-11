-- Check MWSE Build --
if (mwse.buildDate == nil) or (mwse.buildDate < 20220111) then
    local function warning()
        tes3.messageBox(
            "[Security Enhanced ERROR] Your MWSE is out of date!"
            .. " You will need to update to a more recent version to use this mod."
        )
    end
    event.register("initialized", warning)
    event.register("loaded", warning)
    return
end
----------------------------

local config = require("OperatorJack.SecurityEnhanced.config")
local options = require("OperatorJack.SecurityEnhanced.options")

-- Register the mod config menu (using EasyMCM library).
event.register("modConfigReady", function()
    require("OperatorJack.SecurityEnhanced.mcm")
end)


local function debug(message)
    if (config.debugMode) then
        local prepend = '[Security Enhanced: DEBUG] '
        mwse.log(prepend .. message)
        tes3.messageBox(prepend .. message)
    end
end

-- Store currently equipped weapon for re-equip.
local lastWeaponItem = nil
local lastWeaponItemData = nil
local function saveCurrentEquipment()
    -- Store the currently equipped weapon, if any.
    local weaponStack = tes3.getEquippedItem({
        actor = tes3.player,
        objectType = tes3.objectType.weapon
    })
    if (weaponStack) then
        debug('Saving Weapon ID: ' .. weaponStack.object.id)
        lastWeaponItem = weaponStack.object
        lastWeaponItemData = weaponStack.itemData
    end
end

local function reequipEquipment()
    -- If we had a weapon equipped before, re-equip it.
    if (lastWeaponItem) then
        if (not tes3.mobilePlayer:equip({ item = lastWeaponItem, itemData = lastWeaponItemData })) then
            tes3.mobilePlayer:equip({ item = lastWeaponItem, selectBestCondition = true })
        end

        lastWeaponItem = nil
        lastWeaponItemData = nil
    end
end

local function hasKey(reference)
    if not reference.lockNode then return false end
    if not reference.lockNode.key then return false end
    return tes3.getItemCount({
        reference = tes3.player,
        item = reference.lockNode.key
    }) > 0
end

local function getSortedInventoryByObjectType(objectType)
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

local function getBestObjectByObjectType(objectType)
    local objects = getSortedInventoryByObjectType(objectType)
    local object = objects[#objects]

    debug("Found Best Object: Selected Object:" .. object.id)
    return object
end

local function getNextBestObjectByObjectType(objectType, currentObject)
    local objects = getSortedInventoryByObjectType(objectType)
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

    debug("Found Next Best Object: Selected Object:" .. object.id)
    return object
end


local function getWorstObjectByObjectType(objectType)
    local objects = getSortedInventoryByObjectType(objectType)
    local object = objects[1]

    debug("Found Worst Object: Selected Object:" .. object.id)
    return object
end

local function hasTool(type)
    for node in tes3.iterate(tes3.player.object.inventory.iterator) do
        if (node.object.objectType == type) then
            return true
        end
    end
    return false
end

local function isToolEquipped(type)
    return tes3.getEquippedItem{
        actor = tes3.player,
        objectType = type
    }
end

local function unequipTool(type)
    tes3.mobilePlayer:unequip {
        type = type
    }
end

local function equipLockpick(saveEquipment, cycle)
    if (saveEquipment) then
        saveCurrentEquipment()
    end

    local currentLockpickStack = tes3.getEquippedItem({
        actor = tes3.player,
        objectType = tes3.objectType.lockpick
    })
    local currentLockpick

    if (currentLockpickStack ~= nil) then
        currentLockpick = currentLockpickStack.object
    end

    local lockpick

    -- Lockpick isn't equipped. Equip one.
    local equipOrder = config.lockpick.equipOrder
    if (equipOrder == options.equipOrder.BestFirst) then
        -- Choose highest level lockpick first.
        debug("Equipping Lockpick: Best Lockpick First")
        if (cycle) then
            lockpick = getNextBestObjectByObjectType(
                tes3.objectType.lockpick,
                currentLockpick
            )
        else
            lockpick = getBestObjectByObjectType(tes3.objectType.lockpick)
        end
    elseif (equipOrder == options.equipOrder.WorstFirst) then
        -- Choose lowest level lockpick first.
        debug("Equipping Lockpick: Worst Lockpick First")
        if (cycle) then
            lockpick = getNextBestObjectByObjectType(
                tes3.objectType.lockpick,
                currentLockpick
            )
        else
            lockpick = getWorstObjectByObjectType(tes3.objectType.lockpick)
        end
    end

    if (lockpick == nil) then
        debug("Could not find Lockpick.")
        return;
    end

    debug("Equipping Lockpick.")
    tes3.mobilePlayer:equip{
        item = lockpick
    }
end

local function cycleLockpick()
    -- Check for cycle option.
    local hotkeyCycle = config.lockpick.equipHotKeyCycle
    if (hotkeyCycle == options.equipHotKeyCycle.ReequipWeapon) then
        debug("Cycling: Requipping weapon.")
        -- Re-equip Weapon
        unequipTool(tes3.objectType.lockpick)
        reequipEquipment()
    elseif (hotkeyCycle == options.equipHotKeyCycle.Next) then
        debug("Cycling: Moving to next lockpick.")
        -- Cycle to Next Lockpick
        equipLockpick(false, true)
    end
end


local function toggleLockpick(e)
    if (tes3.isKeyEqual(config.lockpick.equipHotKey, e) == true) then
        debug("In hotkey event, invalid key pressed. Exiting event.")
        return
    end

    debug("Registered hotkey event.")

    -- Don't do anything in menu mode.
    if tes3.menuMode() then
        return
    end

    -- Check if lockpick is available.
    if (hasTool(tes3.objectType.lockpick)) then
        -- Check if a lockpick is already equipped.
        if (isToolEquipped(tes3.objectType.lockpick)) then
            debug("Lockpick is equipped. Cycling.")
            -- Cycle to next item based on configuration.
            cycleLockpick()
        else
            debug("Lockpick is not equipped. Equipping.")
            -- Equip lockpick based on configuration.
            equipLockpick(true, false)
        end
    end
end

local function equipProbe(saveEquipment, cycle)
    if (saveEquipment) then
        -- Store current equipment.
        saveCurrentEquipment()
    end

    local currentProbeStack = tes3.getEquippedItem({
        actor = tes3.player,
        objectType = tes3.objectType.probe
    })
    local currentProbe

    if (currentProbeStack ~= nil) then
        currentProbe = currentProbeStack.object
    end

    local probe

    -- Probe isn't equipped. Equip one.
    local equipOrder = config.probe.equipOrder
    if (equipOrder == options.equipOrder.BestFirst) then
        -- Choose highest level Probe first.
        debug("Equipping Probe: Best Probe First")
        if (cycle) then
            probe = getNextBestObjectByObjectType(
                tes3.objectType.probe,
                currentProbe
            )
        else
            probe = getBestObjectByObjectType(tes3.objectType.probe)
        end
    elseif (equipOrder == options.equipOrder.WorstFirst) then
        -- Choose lowest level Probe first.
        debug("Equipping Probe: Worst Probe First")
        if (cycle) then
            probe = getNextBestObjectByObjectType(
                tes3.objectType.probe,
                currentProbe
            )
        else
            probe = getWorstObjectByObjectType(tes3.objectType.probe)
        end
    end

    if (probe == nil) then
        debug("Could not find Probe.")
        return;
    end

    debug("Equipping Probe.")
    tes3.mobilePlayer:equip{
        item = probe
    }
end

local function cycleProbe()
    -- Check for cycle option.
    local hotkeyCycle = config.probe.equipHotKeyCycle
    if (hotkeyCycle == options.equipHotKeyCycle.ReequipWeapon) then
        debug("Cycling: Requipping weapon.")
        -- Re-equip Weapon
        unequipTool(tes3.objectType.probe)
        reequipEquipment()
    elseif (hotkeyCycle == options.equipHotKeyCycle.Next) then
        debug("Cycling: Moving to next Probe.")
        -- Cycle to Next Probe
        equipProbe(false, true)
    end
end

local function toggleProbe(e)
    if (tes3.isKeyEqual(config.probe.equipHotKey, e) == true) then
        debug("In hotkey event, invalid key pressed. Exiting event.")
        return
    end

    debug("Registered hotkey event.")

    -- Don't do anything in menu mode.
    if tes3.menuMode() then
        return
    end

    -- Check if Probe is available.
    if (hasTool(tes3.objectType.probe)) then
        -- Check if a Probe is already equipped.
        if (isToolEquipped(tes3.objectType.probe)) then
            debug("Probe is equipped. Cycling.")
            -- Cycle to next item based on configuration.
            cycleProbe()
        else
            debug("Probe is not equipped. Equipping.")
            -- Equip Probe based on configuration.
            equipProbe(true, false)
        end
    end
end

local equipTimer
local equipReference
local function autoEquipTool(e)
    if  e.target.object.objectType ~= tes3.objectType.door and
        e.target.object.objectType ~= tes3.objectType.container then
        return
    end

    debug("Registered auto-equip for locked object event.")

    -- Check for Probe first.
    if  config.probe.autoEquipOnActivate and
            tes3.getTrap({reference = e.target}) and
            hasKey(e.target) == false then
          if (hasTool(tes3.objectType.probe)) then
            -- Check if a probe is not already equipped.
            if (isToolEquipped(tes3.objectType.probe) == nil) then
                -- Equip probe based on configuration.
                equipProbe(true, false)

                -- Draw probe
                tes3.mobilePlayer.weaponReady = true

                -- Detect target change and reset to weapon when ready.
                equipReference = e.target
                if equipTimer then equipTimer:cancel() end
                equipTimer = timer.start({
                    duration = .5,
                    iterations = -1,
                    callback = function()
                        local target = tes3.getPlayerTarget()
                        if not target or target ~= equipReference then
                            unequipTool(tes3.objectType.probe)
                            reequipEquipment()
                            equipReference = nil
                            equipTimer:cancel()
                            equipTimer = nil
                        end
                        if equipReference and equipTimer and not tes3.getTrap({reference = equipReference}) then
                            equipReference = nil
                            equipTimer:cancel()
                            equipTimer = nil

                            timer.start({
                                duration = .8,
                                callback = function ()
                                    unequipTool(tes3.objectType.probe)
                                    reequipEquipment()
                                end
                            })
                        end
                    end
                })

                return -- Exit event handler.
            end
        end

    -- Check for lockpick second.
    elseif config.lockpick.autoEquipOnActivate and
            not tes3.getTrap({reference = e.target}) and
            hasKey(e.target) == false then
        if (hasTool(tes3.objectType.lockpick)) then
            -- Check if a lockpick is not already equipped.
            if (isToolEquipped(tes3.objectType.lockpick) == nil) then
                -- Equip lockpick based on configuration.
                equipLockpick(true, false)

                -- Draw lockpick
                tes3.mobilePlayer.weaponReady = true

                -- Detect target change and reset to weapon when ready.
                equipReference = e.target
                if equipTimer then equipTimer:cancel() end
                equipTimer = timer.start({
                    duration = .5,
                    iterations = -1,
                    callback = function()
                        local target = tes3.getPlayerTarget()
                        if not target or target ~= equipReference then
                            unequipTool(tes3.objectType.lockpick)
                            reequipEquipment()
                            equipReference = nil
                            equipTimer:cancel()
                            equipTimer = nil
                        end
                        if equipReference and equipTimer and tes3.getLocked({reference = equipReference}) == false then
                            equipReference = nil
                            equipTimer:cancel()
                            equipTimer = nil

                            timer.start({
                                duration = .8,
                                callback = function ()
                                    unequipTool(tes3.objectType.lockpick)
                                    reequipEquipment()
                                end
                            })
                        end
                    end
                })

                return -- Exit event handler.
            end
        end
    end
end

local function initialized()
    event.register("keyDown", toggleLockpick, { filter = config.lockpick.hotKey.keyCode })
    event.register("keyDown", toggleProbe, { filter = config.probe.hotKey.keyCode })


    if (config.lockpickAutoEquipOnActivate or config.probeAutoEquipOnActivate) then
        event.register("activate", autoEquipTool)
    end

    print("[Security Enhanced: INFO] Security Enhanced Initialized")
end

event.register("initialized", initialized)