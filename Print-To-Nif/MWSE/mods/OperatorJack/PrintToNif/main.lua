function printToNif(e)
    if (e.keyCode == tes3.scanCode.p and e.isAltDown == true) then
        local ref = tes3.getPlayerTarget()
        if (ref) then
            ref.sceneNode:saveBinary("Data Files/Print-To-Nif/" .. ref.object.id .. ".nif")
            tes3.messageBox("Saved nif to 'Data Files/Print-To-Nif/" .. ref.object.id .. ".nif'.")
        end
    end
end

-- Filter by the scan code to get Z key presses only.
event.register("key", printToNif)