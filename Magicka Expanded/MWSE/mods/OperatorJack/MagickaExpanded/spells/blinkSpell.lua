local common = include("OperatorJack.MagickaExpanded.common")

local BlinkSpell = {
    name = "Blink",
    id = "OJ_ME_Blink",
}
	
local function registerSpell()
	local spell = common.createSimpleSpell({
		id = BlinkSpell.id,
		name = BlinkSpell.name,
		effect = tes3.effect.blink,
		range = tes3.effectRange.self
	})
end

event.register("MaggickaExpanded:Register", registerSpell)