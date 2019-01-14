if (mwse.buildDate == nil) or (mwse.buildDate < 20181211) then
    local function warning()
        tes3.messageBox(
            "[Realistic Movement Speeds ERROR] Your MWSE is out of date!"
            .. " You will need to update to a more recent version to use this mod."
        )
    end
    event.register("initialized", warning)
    event.register("loaded", warning)
    return
end

local function onCalcMoveSpeed(e)
    if e.mobile.isMovingBack then
        e.speed = e.speed * .6
    elseif e.mobile.isMovingLeft or e.mobile.isMovingRight then
        e.speed = e.speed * .8
    end
end

local function initialized()
    event.register("calcMoveSpeed", onCalcMoveSpeed)

	print("[Realistic Movement Speeds: INFO] Initialized Realistic Movement Speeds")
end
event.register("initialized", initialized)