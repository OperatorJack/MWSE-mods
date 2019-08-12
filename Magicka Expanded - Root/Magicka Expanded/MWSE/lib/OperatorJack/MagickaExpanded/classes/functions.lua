local this = {}

this.getEffectFromEffectOnCollisionEvent = function (event, effectId)
	for i=1,8 do
		local effect = event.sourceInstance.source.effects[i]
		if (effect ~= nil) then
			if (effect.id == effectId) then
				return effect
			end
		end
	end
	return nil
end

this.getCalculatedMagnitudeFromEffect = function(effect)
	local minMagnitude = math.floor(effect.min)
	local maxMagnitude = math.floor(effect.max)
	local magnitude = math.random(minMagnitude, maxMagnitude)
	return magnitude
end

this.linearInterpolation = function(x1, y1, x2, y2, percent)
	return (x1 + ((x2 - x1) * percent)), (y1 + ((y2 - y1) * percent))
end

this.ternary = function(condition, T, F)
	if condition then return T else return F end
end

return this