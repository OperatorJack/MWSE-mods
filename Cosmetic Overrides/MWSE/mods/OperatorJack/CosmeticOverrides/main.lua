local name = "Cosmetic Overrides"
local config = mwse.loadConfig(name, {
    -- Initialize Settings
    logLevel = "ERROR",
    showMessages = true
}); ---@cast config table

local logger = require("logging.logger")
local log = logger.getLogger(name) or logger.new({ name = name, logLevel = config.logLevel })

local function getKeyFromValue(tbl, value)
    for key, tblValue in pairs(tbl) do
        if (tblValue == value) then return key end
    end
    return nil
end

local function getSlotNameFromObject(obj)
    log:debug("Getting slot name from object type %s", obj.objectType)
    local slotName
    if (obj.objectType == tes3.objectType.armor) then
        slotName = getKeyFromValue(tes3.armorSlot, obj.slot)
    else
        slotName = getKeyFromValue(tes3.clothingSlot, obj.slot)
    end

    log:debug("Got slot name %s", slotName)
    if (slotName) then
        return slotName:lower()
    else
        return nil
    end
end

local function triggerBodyPartsUpdate()
    tes3.player:updateEquipment()
    tes3.player1stPerson:updateEquipment()
end

local categories = {
    [mwse.longToString(tes3.objectType.armor)] = {
        text = "Armor",
        types = tes3.armorSlot,
        blockedSlots = { ["shield"] = true }
    },
    [mwse.longToString(tes3.objectType.clothing)] = {
        text = "Clothing",
        types = tes3.clothingSlot,
        blockedSlots = { ["amulet"] = true, ["belt"] = true, ["ring"] = true }
    }
}

local options = {}
local function getOptions(objectTypeId, objectTypeName)
    objectTypeName = objectTypeName:lower()
    local labels = { { label = "-- None --", value = nil } }

    if (tes3.player == nil) then
        log:debug("Getting Options - player is nil, so returning default options.")
        return labels
    elseif (tes3.player.data.OJ_CosmeticOverrides.Possible[objectTypeId] == nil or
            tes3.player.data.OJ_CosmeticOverrides.Possible[objectTypeId][objectTypeName] == nil) then
        log:debug("Getting Options - player vardata is nil, so returning default options.")
        return labels
    end

    for id, text in pairs(
        tes3.player.data.OJ_CosmeticOverrides.Possible[objectTypeId][objectTypeName]) do
        table.insert(labels, { label = text .. " - " .. id, value = id })
    end

    log:debug("Getting Options - checks are passed, so returning valid options.")
    return labels
end

local function updateOptions(objectTypeId, objectTypeName)
    objectTypeName = objectTypeName:lower()

    for key in pairs(options[objectTypeId][objectTypeName]) do
        options[objectTypeId][objectTypeName][key] = nil
    end

    table.insert(options[objectTypeId][objectTypeName], { label = "-- None --", value = nil })

    if (tes3.player ~= nil and tes3.player.data.OJ_CosmeticOverrides.Possible[objectTypeId] ~= nil) then
        for id, text in pairs(tes3.player.data.OJ_CosmeticOverrides.Possible[objectTypeId][objectTypeName]) do
            log:debug("Updating dropdown options.")
            table.insert(
                options[objectTypeId][objectTypeName],
                { label = text .. " - " .. id, value = id }
            )
        end
    end
end

local function initializePlayerData()
    tes3.player.data.OJ_CosmeticOverrides = tes3.player.data
        .OJ_CosmeticOverrides or
        { Active = {}, Possible = {} }
end

local function initializePlayerDataOptions()
    for objectType, objectTypeTbl in pairs(tes3.player.data.OJ_CosmeticOverrides.Possible) do
        for slotName in pairs(objectTypeTbl) do
            updateOptions(objectType, slotName)
        end
    end
end

local function getOverrideItemId(objectType, objectTypeName)
    log:debug("Getting override item id for object type %s and slot %s", objectType, objectTypeName)
    if (tes3.player.data.OJ_CosmeticOverrides.Active[objectType]) then
        return tes3.player.data.OJ_CosmeticOverrides.Active[objectType][objectTypeName]
    end
    return nil
end

local cachedObjects = {}
local function getOverrideObject(objectType, objectTypeName)
    local overrideItemId = getOverrideItemId(objectType, objectTypeName)
    log:debug("Got override item id %s", overrideItemId)
    if (overrideItemId) then
        if (cachedObjects[overrideItemId] == nil) then
            log:debug("No cached override object, loading object")
            cachedObjects[overrideItemId] = tes3.getObject(overrideItemId)
        end

        return cachedObjects[overrideItemId]
    end
    return nil
end

-- Enable costmetic overrides.
local function onBodyPartAssigned(e)
    -- We only care about item-based assignment on the player.
    if (e.reference == tes3.player and e.object) then
        initializePlayerData()
        log:debug("Validating body part - init'd player data")

        -- Do we have an override for it?
        local slotName = getSlotNameFromObject(e.object)
        local objectTypeString = mwse.longToString(e.object.objectType)
        log:debug("Validating body part - slot %s, type %s", slotName,
            objectTypeString)

        local overrideItem = getOverrideObject(objectTypeString, slotName)
        if (overrideItem) then
            log:debug(
                "Validating body part - override found, attempting override")

            -- Find the matching body part index.
            for _, potentialPartPair in ipairs(overrideItem.parts) do
                if (potentialPartPair.type ~= -1 and potentialPartPair.type == e.index) then
                    log:debug("Validating body part - body part match found, attempting override")
                    -- We found the right body part on the item. Use it, based on sex assignment.
                    if (potentialPartPair.female and tes3.player.baseObject.female) then
                        e.bodyPart = potentialPartPair.female
                        log:debug("Validating body part - override with female part")
                    else
                        e.bodyPart = potentialPartPair.male
                        log:debug("Validating body part - override with female part")
                    end

                    return
                end
            end

            -- No matching body part for this index? Block the visual.
            return false
        else
            log:debug("Validating body part - no override found, returning")
        end
    end
end
event.register("bodyPartAssigned", onBodyPartAssigned)

local function onEquipped(e)
    local item = e.item

    if (item.objectType == tes3.objectType.armor or item.objectType == tes3.objectType.clothing) then
        local slotName = getSlotNameFromObject(item)
        local objectTypeString = mwse.longToString(e.item.objectType)
        if (slotName == nil or categories[objectTypeString].blockedSlots[slotName] == true) then
            return
        end

        log:debug("Equipped possible item. Attempting Unlock %s", item.name)

        tes3.player.data.OJ_CosmeticOverrides.Possible[objectTypeString] =
            tes3.player.data.OJ_CosmeticOverrides.Possible[objectTypeString] or
            {}
        tes3.player.data.OJ_CosmeticOverrides.Possible[objectTypeString][slotName] =
            tes3.player.data.OJ_CosmeticOverrides.Possible[objectTypeString][slotName] or
            {}

        if (not tes3.player.data.OJ_CosmeticOverrides.Possible[objectTypeString][slotName][item.id] and
                config.showMessages) then
            log:debug("Unlocked %s", item.name)
            tes3.messageBox("Unlocked '" .. item.name .. "' Cosmetic")
        end

        tes3.player.data.OJ_CosmeticOverrides.Possible[objectTypeString][slotName][item.id] = item.name

        updateOptions(objectTypeString, slotName)
    end
end
event.register("equipped", onEquipped)

local function onLoaded(e)
    initializePlayerData()
    initializePlayerDataOptions()

    triggerBodyPartsUpdate()

    print("[Cosmetic Overrides: INFO] Initialized for current save game.")
end
event.register("loaded", onLoaded)

event.register("menuExit", function() triggerBodyPartsUpdate() end)

-----------------------------------
------------ Add MCM --------------
-----------------------------------
local function sortedKeys(query, sortFunction)
    local keys, len = {}, 0
    for k, _ in pairs(query) do
        len = len + 1
        keys[len] = k
    end
    table.sort(keys, sortFunction)
    return keys
end

local function createDropDownsForCategory(category, typeId, typeObject)
    for _, slotName in pairs(sortedKeys(typeObject.types)) do
        if (not typeObject.blockedSlots[slotName]) then
            local slotNameLower = slotName:lower()
            if (options[typeId] == nil) then options[typeId] = {} end
            options[typeId][slotNameLower] = getOptions(typeId, slotNameLower)

            category:createDropdown({
                label = slotName,
                description = "Set the cosmetic override for the " .. slotName ..
                    " slot.",
                options = options[typeId][slotNameLower],
                variable = mwse.mcm.createPlayerData({
                    id = slotNameLower,
                    path = "OJ_CosmeticOverrides.Active." .. typeId
                })
            })
        end
    end
end

-- Handle mod config menu.
local function createCategory(template, typeId, typeObject)
    local page = template:createSideBarPage {
        label = typeObject.text,
        description = "Hover over a setting to learn more about it."
    }

    local category = page:createCategory {
        label = typeObject.text,
        description = "Manage the cosmetic overrides for " .. typeObject.text ..
            "."
    }

    createDropDownsForCategory(category, typeId, typeObject)
end

local function registerModConfig()
    local template = mwse.mcm.createTemplate(name)

    local page = template:createSideBarPage {
        label = "General",
        description = "Hover over a setting to learn more about it."
    }

    local general = page:createCategory { label = "General Settings" }

    -- Create option to capture debug mode.
    general:createOnOffButton {
        label = "Enable Unlock Messages",
        description = "Use this option to enable unlock messages. You will be notified when you unlock a new cosmetic with a message like, 'Unlocked Daedric Helm Cosmetic'.",
        variable = mwse.mcm.createTableVariable {
            id = "showMessages",
            table = config
        }
    }

    general:createDropdown {
        label = "Logging Level",
        description = "Set the log level.",
        options = {
            { label = "TRACE", value = "TRACE" },
            { label = "DEBUG", value = "DEBUG" },
            { label = "INFO",  value = "INFO" }, { label = "WARN", value = "WARN" },
            { label = "ERROR", value = "ERROR" }, { label = "NONE", value = "NONE" }
        },
        variable = mwse.mcm.createTableVariable {
            id = "logLevel",
            table = config
        },
        callback = function(self) log:setLogLevel(self.variable.value) end
    }

    for key, value in pairs(categories) do
        createCategory(template, key, value)
    end

    template:saveOnClose(name, config)
    mwse.mcm.register(template)
end

event.register("modConfigReady", registerModConfig)
