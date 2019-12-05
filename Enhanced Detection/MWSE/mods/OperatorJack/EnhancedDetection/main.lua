local modTimer = nil

local actives = {}
local function timerCallback()
	for reference, _ in pairs(actives) do

	end
end

local registered = false
local function onLoaded(e)
  if (registered == false) then
    actives = {}

    modTimer = timer.start({
      iterations = -1,
      duration = .01,
      callback = timerCallback
    })

    print("[Enhanced Detection: INFO] Initialized.")

    registered = true
  end
end
event.register("loaded", onLoaded)

local function onObjectInvalidated(e)
    actives[e.object] = nil
end
event.register("objectInvalidated", onObjectInvalidated)