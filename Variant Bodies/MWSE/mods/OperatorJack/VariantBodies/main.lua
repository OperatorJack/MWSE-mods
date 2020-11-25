-- Check MWSE Build --
if (mwse.buildDate == nil) or (mwse.buildDate < 20200122) then
    local function warning()
        tes3.messageBox(
            "[Variant Bodies ERROR] Your MWSE is out of date!"
            .. " You will need to update to a more recent version to use this mod."
        )
    end
    event.register("initialized", warning)
    event.register("loaded", warning)
    return
end
----------------------------
local configurationTypes = {
    gsub = "gsub"
}

local configurations = {
    argonianConfigurationOne = {
        type = configurationTypes.gsub,
        typeParameters = {
            source = "textures\\arg\\00",
            pattern = "\\00\\",
            replace = "\\01\\"
        }
    }
}

local randomizationConfiguration = {
    configuration = configurations.argonianConfigurationOne
}

local randomizationRaces = {
    ["argonian"] = {
        configurations = {
            [0] = configurations.argonianConfigurationOne
        }
    }
}

local npcOverrides = {
    ["onlyhestandsthere"] = {
        configuration = configurations.argonianConfigurationOne
    }
}

 local function process_gsub(configuration, base_map)
    if (string.find(base_map.texture.fileName, configuration.typeParameters.source)) then
        mwse.log("Current filepath: %s", base_map.texture.fileName)

        local newTextureFilepath = base_map.texture.fileName:gsub(configuration.typeParameters.pattern, configuration.typeParameters.replace)
        mwse.log("New filepath: %s", newTextureFilepath)

        base_map.texture = niSourceTexture.createFromPath(newTextureFilepath)
    end
end

local function dispatch(configuration, base_map)
    if (configuration.type == configurationTypes.gsub) then
        process_gsub(configuration, base_map)
    end
end

local function getBaseMap(ref, bodyPartManagerNodeIndex)
    local node = ref.bodyPartManager.attachNodes[bodyPartManagerNodeIndex].node
    local texturing_property = node:getProperty(0x4)
    if (texturing_property) then
        local base_map = texturing_property.maps[1]
        if (base_map) then
            return base_map
        end
    end
    return nil
end

local function onBodyPartAssigned(e)
    local ref = e.reference
    if (ref.object.objectType == tes3.objectType.npc) then
        local npcOverride = npcOverrides[ref.baseObject.id:lower()]
        local raceRanzomidation = randomizationRaces[ref.object.race.id:lower()]

        if (npcOverride) then
            local base_map = getBaseMap(ref, e.index)
            if (base_map) then
                dispatch(npcOverride.configuration, base_map)
            end

            -- Skip remainder of function as NPC has been handled.
            return
        end

        if (raceRanzomidation) then
            if (math.random(0, 100) > 50) then
                local index = math.random(0, #raceRanzomidation.configurations - 1)
                local configuration = raceRanzomidation.configurations[index]

                local base_map = getBaseMap(ref, e.index)
                if (base_map) then
                    dispatch(configuration, base_map)
                end

                -- Save configuration for NPC.
                mwse.log("TODO: Save NPC Configuration after random selection.")

                -- Skip remainder of function as NPC has been handled.
                return
            end
        end
    end
end
event.register("bodyPartAssigned", onBodyPartAssigned)

local function initialized()

    print("[Variant Bodies: INFO] Variant Bodies Initialized")
end

event.register("initialized", initialized)