local debug = false

local function initialized()
    for leveledList in tes3.iterateObjects({ tes3.objectType.leveledItem, tes3.objectType.leveledCreature }) do
        if debug == true then  mwse.log("List: %s", leveledList) end
        for _, node in pairs(leveledList.list) do
            if debug == true then mwse.log("--- Node: Obj: %s, Level: %s", node.object, node.levelRequired) end

            node.levelRequired = 1

            if debug == true then mwse.log("--- Updated Node: Obj: %s, Level: %s", node.object, node.levelRequired) end
        end 
    end
    print("[OperatorJack's Develer: INFO] Initialized")
end

event.register("initialized", initialized, {priority = -10000})