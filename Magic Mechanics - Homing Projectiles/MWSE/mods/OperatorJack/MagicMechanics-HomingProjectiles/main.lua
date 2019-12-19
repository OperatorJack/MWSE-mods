local actives = {}
local function projectileTimerCallback()
	for reference, _ in pairs(actives) do
		local mobile = reference.mobile
		if (mobile) then
			if (mobile.flags ~= 108) then
				mobile.position = mobile.position + tes3.getPlayerEyeVector() * 15
			end
		end
    end
end

local registered = false
local projectileTimer = nil
local function onLoaded(e)
  if (registered == false) then
    actives = {}

    projectileTimer = timer.start({
      iterations = -1,
      duration = .01,
      callback = projectileTimerCallback
    })

    print("[Magic Mechanics - Homing Projectiles: INFO] Initialized.")

    registered = true
  end
end
event.register("loaded", onLoaded)

local function onObjectInvalidated(e)
    actives[e.object] = nil
end
event.register("objectInvalidated", onObjectInvalidated)

local function onMobileActivated(e)
	local mobile = e.mobile
	if (mobile == nil) then
		return
	end

	local spellInstance = mobile.spellInstance
	if (spellInstance == nil) then
		return
	end

	if (spellInstance.caster ~= tes3.player) then
		return
	end

	actives[e.reference] = true
end
event.register("mobileActivated", onMobileActivated)