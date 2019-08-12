local common = require("OperatorJack.MagickaExpanded.common")

local this = {}

local function getEffectCost(effect)
    local minMagnitude = effect.min or 0
    if (minMagnitude == 0) then
        minMagnitude = 1
    end
    
    local maxMagnitude = effect.max or 0
    if (maxMagnitude == 0) then
        maxMagnitude = 1
    end

    local duration = effect.duration or 0
    if (duration == 0) then
        duration = 1
    end

    local area = effect.radius or 0
    if (area == 0 and effect.rangeType == tes3.effectRange.self) then
        area = 1
    end
    local baseMagickaCost = effect.object.baseMagickaCost

    local effectCost = math.floor(((minMagnitude + maxMagnitude) * (duration + 1) + area) * baseMagickaCost / 40.0)

    if (effect.rangeType == tes3.effectRange.target) then
        effectCost = effectCost * 1.5
    end

    return effectCost
end

this.getSpellCost = function(spell)
    common.debug("Getting Spell Cost for Spell" .. spell.name)
    local spellCost = 0
	for i=1, spell:getActiveEffectCount() do
		local effect = spell.effects[i]
        if (effect ~= nil) then
            spellCost = spellCost + getEffectCost(effect)
		end
    end
    common.debug("Spell Cost for " .. spell.name .. " is " .. spellCost)
	return spellCost
end

this.createBasicSpell = function(params)
    local spell = tes3.getObject(params.id) or tes3spell.create(params.id, params.name)

    local effect = spell.effects[1]
    effect.id = params.effect
    effect.rangeType = params.range or tes3.effectRange.self
    effect.min = params.min or 0
    effect.max = params.max or 0
    effect.duration = params.duration or 0
    effect.radius = params.radius or 0

    spell.magickaCost = this.getSpellCost(spell)

    common.addSpellToSpellsList(spell)

    return spell
end

return this