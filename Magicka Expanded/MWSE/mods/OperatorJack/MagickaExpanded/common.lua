local this = {}
local debug = true
this.debugMessage = function(string)
	if debug then
		tes3.messageBox(string)
		mwse.log("[Spells Module: DEBUG] " .. string)
	end
end

this.linearInterpolation = function(x1, y1, x2, y2, percent)
	return (x1 + ((x2 - x1) * percent)), (y1 + ((y2 - y1) * percent))
end

this.ternary = function(condition, T, F)
	if condition then return T else return F end
end

this.hasSpell =  function(actor, spell)
	return actor.object.spells:contains(spell)
end

this.canCastSpell = function(actor, spell)
    if not this.hasSpell(actor, spell) then
        return false
    end

    if (actor.magicka.current <= spell.magickaCost) then
        return false
    end

    return true
end

this.castSpell = function(actor, target, spell)
    tes3.cast({
        reference = actor,
        target = target,
        spell = spell
    })

    actor.magicka.current = actor.magicka.current - spell.magickaCost
end




return this
