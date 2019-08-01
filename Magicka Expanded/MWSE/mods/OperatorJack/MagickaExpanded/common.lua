local this = {}
local debug = true
this.debugMessage = function(string)
	if debug then
		tes3.messageBox(string)
		mwse.log("[Magicka Expanded: DEBUG] " .. string)
	end
end

this.linearInterpolation = function(x1, y1, x2, y2, percent)
	return (x1 + ((x2 - x1) * percent)), (y1 + ((y2 - y1) * percent))
end

this.ternary = function(condition, T, F)
	if condition then return T else return F end
end

lthis.claimSpellEffectId = function(name, id)
	assert(tes3.effect[name] == nil, "Effect name is not unique.")
	assert(table.find(tes3.effect, id) == nil, "Effect id is not unique.")
	tes3.effect[name] = id
end

this.createSimpleSpell = function(params)
	local spell = tes3.getObject(params.id) or tes3spell.create(params.id, params.name)
	local effect = spell.effects[1]
	effect.id = params.effect
	effect.rangeType = params.range or tes3.effectRange.self
	effect.min = params.min or 0
	effect.max = params.max or 0
    effect.duration = params.duration or 0
    
    return spell
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
