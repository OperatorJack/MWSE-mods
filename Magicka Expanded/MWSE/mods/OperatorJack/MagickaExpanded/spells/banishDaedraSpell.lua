local common = include("OperatorJack.MagickaExpanded.common")

local BanishDaedraSpell = {
    name = "Banish Daedra",
    id = "OJ_ME_BanishDaedra",
}
	
local function registerSpell()
	local spell = common.createSimpleSpell({
		id = BanishDaedraSpell.id,
		name = BanishDaedraSpell.name,
		effect = tes3.effect.banishDaedra,
        range = tes3.effectRange.touch,
        min = 1,
        max = 10
	})
end

event.register("MaggickaExpanded:Register", registerSpell)