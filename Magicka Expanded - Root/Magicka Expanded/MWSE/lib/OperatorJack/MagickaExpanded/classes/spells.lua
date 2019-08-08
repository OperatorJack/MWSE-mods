local common = require("OperatorJack.MagickaExpanded.common")

local this = {}

this.createBasicSpell = function(params)
    local spell = tes3.getObject(params.id) or tes3spell.create(params.id, params.name)

    local effect = spell.effects[1]
    effect.id = params.effect
    effect.rangeType = params.range or tes3.effectRange.self
    effect.min = params.min or 0
    effect.max = params.max or 0
    effect.duration = params.duration or 0
    effect.radius = params.radius or 0

    common.addSpellToSpellsList(spell)

    return spell
end

return this