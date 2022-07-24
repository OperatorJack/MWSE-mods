Tiered Magicka
By: OperatorJack


==============
Requirements
==============
- Morrowind
- MGE XE 0.10.1
- MWSE 2.1+

==============
Description
==============
This mod makes it so that all spells have a spell tier and the player has a casting tier.
If the player's casting tier is less than the spell tier, the player cannot cast the spell.
If the player's casting tier is equal to or greater than the spell tier, the player may cast the spell as normal. All other standard game mechanics still apply at this point.

This was inspired by the magic casting language used in "Overlord," a TV show.

The spell tier and player casting tier will both be shown on spell tooltips, below the spell's effects. If the spell tier is higher than the player casting tier, it will be red.

Spell tier formula:
Spell Tier = floor( spellCost / 20 )

Caster tier formula is derived from the proportional level of each magic effect's governing attribute in the given spell, relative to the spell cost of that effect. For example, a mixed-spell that contains paralyze and fire damage will have a level calculated from the Personality and Willpower attributes. The more prominent the spell cost of each effect is in relation to the other, the higher the level is needed in the governing attribute. This means that many spells will have totally unique caster tiers, as it is based on the specific effects within the spell. Single-school spells should stay relatively static in their casting level, unless you increase the related attribute level.

This mod IS NOT compatible with OpenMW.

==============
Permissions
==============
MWSE-Lua code may be used for any purpose for Morrowind. Please do not use it for other games. Please credit OperatorJack as the original author of any code.

==============
Installation
==============
Use a mod management tool to install the mod.

==============
Removal
==============
Use a mod management tool to remove any installed files from your mod directory.

==============
Credits
==============
- The people over on the Morrowind Modding Discord for their help and input.