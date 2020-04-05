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

Player tier formula:
Player tier = floor (intelligence / 2 + willpower / 2 ) / 15

This mod IS NOT compatible with OpenMW, at least until support for MWSE mods is added.

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