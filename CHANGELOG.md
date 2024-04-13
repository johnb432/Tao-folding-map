# Changelog for Tao's Folding Map Rewrite 13.4.2023

4.2.6.0
- Fixed bug where GPS was not detected.

# Changelog for Tao's Folding Map Rewrite 13.4.2023

4.2.5.0
- Added latest hemtt support.
- Various fixes.

# Changelog for Tao's Folding Map Rewrite 20.10.2023

4.2.4.0
- Various fixes.

# Changelog for Tao's Folding Map Rewrite 30.7.2023

4.2.3.7
- Hopefully finally fixed weird CBA fleximenu issues.
- Cleanup.

# Changelog for Tao's Folding Map Rewrite 28.7.2023

4.2.3.6
- Hopefully fixed weird CBA fleximenu issues.
- Map can only be opened after CBA settings are initialised.
- Minor improvements.

# Changelog for Tao's Folding Map Rewrite 2.3.2023

4.2.3.5
- Various fixes.

# Changelog for Tao's Folding Map Rewrite 25.2.2023

4.2.3.4
- Added support for map icons drawn by CLib.
- Switched date and time, so that is bounces around less.

# Changelog for Tao's Folding Map Rewrite 26.11.2022

4.2.3.3
- Cleanup.
- Bug fixes.

# Changelog for Tao's Folding Map Rewrite 30.4.2022

4.2.3.2
- Added setting "Items that provide GPS", which adds support for inventory items to provide GPS capabilities.

# Changelog for Tao's Folding Map Rewrite 19.3.2022

4.2.3.1
- Added support for 2.08.
- Removed "Lock 'Keep player on map'" setting - now enforce tracking types via "Keep player on map" directly.
- Minor cleanup.

# Changelog for Tao's Folding Map Rewrite 23.1.2022

4.2.3.0
- Added hemtt support.
- Added support for 2.06.
- Added support for moving and resizing map via in-game UI layout editor.
- Added better darkening/dimming code from Dystopian (ACE3).
- Removed animations (scrolling map on and off screen, shaking). Commands do not make it easily possible with resizable GUI.
- Removed "Allow repositioning" CBA setting, as repositioning is now done via in-game UI layout editor.

# Changelog for Tao's Folding Map Rewrite 8.5.2021

4.2.2.0
- Added support for 3rd party maps and GPS.

# Changelog for Tao's Folding Map Rewrite 2.5.2021

4.2.1.0
- Fixed bug when starting missions where the map type was overwritten by last choice.

# Changelog for Tao's Folding Map Rewrite 4.4.2021

4.2.0.0
- Added 3 different folding map sizes that can be toggled.
- Added ability to change different tracking types in fleximenu. However, it can still be locked using CBA settings.
- Added a settable refresh rate slider to the settings.
- Further overhaul of code
- GPS no longer has to be open to get automatic tracking
- More

# Changelog for Tao's Folding Map Rewrite 12.12.2020

4.1.0.0
- Added "Require GPS to update position automatically" setting which is always set to true, unless the server specifies otherwise.

# Changelog for Tao's Folding Map Rewrite 3.11.2020

4.0.0.0
- Massive clean up. Should be "lighter".

# Changelog for Tao's Folding Map Rewrite 1.6.2020

3.1.3.0
- Clean up. Better README.txt. Changed default keybinds.

# Changelog for Tao's Folding Map Rewrite 28.5.2020

3.1.0.0
- Added a setting where you disabled the automatic tracking of players on the maps (you have to manually move it, using the ALT + arrow keys).

# Changelog for Tao's Folding Map Rewrite 27.5.2020

3.0.0.0
- Complete overhaul of the mod to include CBA Macros and Settings by johnb43.

2.7.0
- Use latest CBA keybinding.

2.5.1
- Fix ctrl modifier for custom key binds.
- Fix duplicate display in Expansions list.

2.5
- Paper map can now be chosen in the user config. Red nightvision mode will not be available. Default is still tablet.
- Re-add zx64 & Dslyecxi-inspired darkening/dimming code for night.
- Fix status bar draw size at interface scales other than Normal.

2.4.1
- Fix variable name in config to make sense.

2.4
- Add configurable keybinds, off by default. See UserConfig\tao_foldmap_a3\tao_foldmap_a3.hpp.
- Resolve some missing semi-colons in config.cpp.

2.3
- Incorporate map scaling fixes by 1212PDMCDMPPM.
- Incorporate and improve zoom feature by 1212PDMCDMPPM. Now works w/ folding. Press Shift-Ctrl-Zoom In/Out (default 'numpad +/-')
- Added night mode -- press Shift-Ctrl-Night Vision (default 'n') while the map is open. Sorry it doesn't look perfect.
- Fixed edge flickering FOREVER.

2.2
- More responsive close.
- Changed to Extended_PostInit from Extended_PreInit.
- New GUI trimmings.
- Map markings changed slightly.
- Use Arma 2 road coloring.

2.1
- Check for map in player's inventory. If player lacks a map, don't show the folding map.

2.0
- Made for Arma 3.
- Fix for another flickering border corner case. I think the flickering bug is gone for good.
- Map made slightly smaller on the screen.
- Signed for online use.

1.1
- Fix flickering map under certain border cross conditions.

1.0
- Initial release.
