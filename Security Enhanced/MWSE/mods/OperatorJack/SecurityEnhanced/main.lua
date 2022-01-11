local config = require("OperatorJack.SecurityEnhanced.config")

-- Register the mod config menu (using EasyMCM library).
event.register("modConfigReady", function()
    require("OperatorJack.SecurityEnhanced.mcm")
end)

local options = require("OperatorJack.SecurityEnhanced.options")
local common = require("OperatorJack.SecurityEnhanced.common")

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
        common.saveCurrentEquipment()
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
    local equipOrder = config.lockpickEquipOrder
    if (equipOrder == options.lockpick.equipOrder.BestLockpickFirst) then
        -- Choose highest level lockpick first.
        common.debug("Equipping Lockpick: Best Lockpick First")
        if (cycle) then
            lockpick = common.getNextBestObjectByObjectType(
                tes3.objectType.lockpick,
                currentLockpick
            )
        else
            lockpick = common.getBestObjectByObjectType(tes3.objectType.lockpick)
        end
    elseif (equipOrder == options.lockpick.equipOrder.WorstLockpicKFirst) then
        -- Choose lowest level lockpick first.
        common.debug("Equipping Lockpick: Worst Lockpick First")
        if (cycle) then
            lockpick = common.getNextBestObjectByObjectType(
                tes3.objectType.lockpick,
                currentLockpick
            )
        else
            lockpick = common.getWorstObjectByObjectType(tes3.objectType.lockpick)
        end
    end

    if (lockpick == nil) then
        common.debug("Could not find Lockpick.")
        return;
    end

    common.debug("Equipping Lockpick.")
    tes3.mobilePlayer:equip{
        item = lockpick
    }
end

local function cycleLockpick()
    -- Check for cycle option.
    local hotkeyCycle = config.lockpickEquipHotKeyCycle
    if (hotkeyCycle == options.lockpick.equipHotKeyCycle.ReequipWeapon) then
        common.debug("Cycling: Requipping weapon.")
        -- Re-equip Weapon
        unequipTool(tes3.objectType.lockpick)
        common.reequipEquipment()
    elseif (hotkeyCycle == options.lockpick.equipHotKeyCycle.NextLockpick) then
        common.debug("Cycling: Moving to next lockpick.")
        -- Cycle to Next Lockpick
        equipLockpick(false, true)
    end
end

local function keybindTest(b, e)
    return (b.keyCode == e.keyCode) and
    (b.isShiftDown == e.isShiftDown) and
    (b.isAltDown == e.isAltDown) and
    (b.isControlDown == e.isControlDown)
end

local function toggleLockpick(e)
    if (not keybindTest(config.lockpickEquipHotKey, e)) then
        common.debug("In hotkey event, invalid key pressed. Exiting event.")
        return
    end

    common.debug("Registered hotkey event.")

    -- Don't do anything in menu mode.
    if tes3.menuMode() then
        return
    end

    -- Check if lockpick is available.
    if (hasTool(tes3.objectType.lockpick)) then
        -- Check if a lockpick is already equipped.
        if (isToolEquipped(tes3.objectType.lockpick)) then
            common.debug("Lockpick is equipped. Cycling.")
            -- Cycle to next item based on configuration.
            cycleLockpick()
        else
            common.debug("Lockpick is not equipped. Equipping.")
            -- Equip lockpick based on configuration.
            equipLockpick(true, false)
        end
    end
end

local function equipProbe(saveEquipment, cycle)
    if (saveEquipment) then
        -- Store current equipment.
        common.saveCurrentEquipment()
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
    local equipOrder = config.probeEquipOrder
    if (equipOrder == options.probe.equipOrder.BestProbeFirst) then
        -- Choose highest level Probe first.
        common.debug("Equipping Probe: Best Probe First")
        if (cycle) then
            probe = common.getNextBestObjectByObjectType(
                tes3.objectType.probe,
                currentProbe
            )
        else
            probe = common.getBestObjectByObjectType(tes3.objectType.probe)
        end
    elseif (equipOrder == options.probe.equipOrder.WorstProbeFirst) then
        -- Choose lowest level Probe first.
        common.debug("Equipping Probe: Worst Probe First")
        if (cycle) then
            probe = common.getNextBestObjectByObjectType(
                tes3.objectType.probe,
                currentProbe
            )
        else
            probe = common.getWorstObjectByObjectType(tes3.objectType.probe)
        end
    end

    if (probe == nil) then
        common.debug("Could not find Probe.")
        return;
    end

    common.debug("Equipping Probe.")
    tes3.mobilePlayer:equip{
        item = probe
    }
end

local function cycleProbe()
    -- Check for cycle option.
    local hotkeyCycle = config.probeEquipHotKeyCycle
    if (hotkeyCycle == options.probe.equipHotKeyCycle.ReequipWeapon) then
        common.debug("Cycling: Requipping weapon.")
        -- Re-equip Weapon
        unequipTool(tes3.objectType.probe)
        common.reequipEquipment()
    elseif (hotkeyCycle == options.probe.equipHotKeyCycle.NextProbe) then
        common.debug("Cycling: Moving to next Probe.")
        -- Cycle to Next Probe
        equipProbe(false, true)
    end
end

local function toggleProbe(e)
    if (not keybindTest(config.probeEquipHotKey, e)) then
        common.debug("In hotkey event, invalid key pressed. Exiting event.")
        return
    end

    common.debug("Registered hotkey event.")

    -- Don't do anything in menu mode.
    if tes3.menuMode() then
        return
    end

    -- Check if Probe is available.
    if (hasTool(tes3.objectType.probe)) then
        -- Check if a Probe is already equipped.
        if (isToolEquipped(tes3.objectType.probe)) then
            common.debug("Probe is equipped. Cycling.")
            -- Cycle to next item based on configuration.
            cycleProbe()
        else
            common.debug("Probe is not equipped. Equipping.")
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

    common.debug("Registered auto-equip for locked object event.")

    -- Check for Probe first.
    if  config.probeAutoEquipOnActivate and
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
                            common.reequipEquipment()
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
                                    common.reequipEquipment()
                                end
                            })
                        end
                    end
                })

                return -- Exit event handler.
            end
        end

    -- Check for lockpick second.
    elseif config.lockpickAutoEquipOnActivate and
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
                            common.reequipEquipment()
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
                                    common.reequipEquipment()
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
    event.register("keyDown", toggleLockpick, { filter = config.lockpickEquipHotKey.keyCode })
    event.register("keyDown", toggleProbe, { filter = config.probeEquipHotKey.keyCode })


    if (config.lockpickAutoEquipOnActivate or config.probeAutoEquipOnActivate) then
        event.register("activate", autoEquipTool)
    end

    print("[Security Enhanced: INFO] Security Enhanced Initialized")
end

event.register("initialized", initialized)