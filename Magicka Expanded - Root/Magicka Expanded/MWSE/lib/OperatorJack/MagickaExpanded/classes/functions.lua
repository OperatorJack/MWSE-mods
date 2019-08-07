local this = {}

this.linearInterpolation = function(x1, y1, x2, y2, percent)
	return (x1 + ((x2 - x1) * percent)), (y1 + ((y2 - y1) * percent))
end

this.ternary = function(condition, T, F)
	if condition then return T else return F end
end

return this