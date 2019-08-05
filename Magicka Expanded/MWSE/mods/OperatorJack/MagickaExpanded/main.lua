local common = require("OperatorJack.MagickaExpanded.common")
local mcm = require("OperatorJack.MagickaExpanded.mcm")

-- Will be moved to build soon.
tes3.effectEventType = {
	["bool"] = 0,
	["boolean"] = 0,
	["int"] = 1,
	["integer"] = 1,
	["float"] = 2,
}
tes3.effectAttribute = {
	["attackBonus"] = 0,
	["sanctuary"] = 1,
	["resistMagicka"] = 2,
	["resistFire"] = 3,
	["resistFrost"] = 4,
	["resistShock"] = 5,
	["resistCommonDisease"] = 6,
	["resistBlightDisease"] = 7,
	["resistCorprus"] = 8,
	["resistPoison"] = 9,
	["resistParalysis"] = 10,
	["chameleon"] = 11,
	["resistNormalWeapons"] = 12,
	["waterBreathing"] = 13,
	["waterWalking"] = 14,
	["swiftSwim"] = 15,
	["jump"] = 16,
	["levitate"] = 17,
	["shield"] = 18,
	["sound"] = 19,
	["silence"] = 20,
	["blind"] = 21,
	["paralyze"] = 22,
	["invisibility"] = 23,
	["fight"] = 24,
	["flee"] = 25,
	["hello"] = 26,
	["alarm"] = 27,
	["nonResistable"] = 28,
}

local function initialized()
    math.randomseed(os.time())
	print("[Magicka Expanded: INFO] Initialized Magicka Expanded Spells")
end
event.register("initialized", initialized)

local function loaded()
    event.trigger("MagickaExpanded:Register")
    common.addTestSpellsToPlayer()
    print("[Magicka Expanded: INFO] Registered Magicka Expanded Spells")
end

event.register("loaded", loaded)