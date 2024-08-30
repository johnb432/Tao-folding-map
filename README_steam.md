[b]Tao's Folding Map Rewrite[/b] is a client side mod that lets you open a tactical map while in game which is bigger and more useful than the GPS. To move or resize the map, use the in game UI layout editor under Options -> Game -> Layout.

[h2]CBA Settings[/h2]

When the term "GPS device" is used, it means you need to have access to a GPS panel, which can come from a Vanilla GPS, UAV Terminals, Firewill's PDU, BWA's Navipad and more, but also from vehicles.
The items in "Items that provide GPS" are also considered GPS devices.

[list]
[*] [b]Map:[/b] Allows the addons to be effectively toggled off if necessary.
[*] [b]Preferred map type:[/b] Sets which map type should be selected when you first load into a mission.
[*] [b]Close map:[/b] If set to disabled it will stay open when you open the vanilla map. If enabled the map will close.
[*] [b]Keep map open in:[/b] Allows you to define in which perspectives Tao's folding map will not be closed in.
[*] [b]Refresh rate:[/b] Allows you to set the refresh interval at which the map refreshes itself.
[*] [b]Zoom step:[/b] Allows you to set how much the map zooms in and out with every key press.
[*] [b]Keep player on map:[/b] Always keeps you on the map if set to automatic. On manual, you need to use the "Move up/down/left/right" keys to move the map around. Useful if want to disable automatic centering.
[*] [b]Require GPS to adjust automatically:[/b] This setting is set to "Yes" by default [b][i]and can only be changed by the server[/i][/b].
When set to "Yes" a GPS device will be required in order to have automatic position tracking. The idea is that you need a GPS device to be able to track your position automatically but this can be turned off, if the mission maker/admin wants to.
[*] [b]Lock map type:[/b] Locks the map type to the paper map. Useful for pre-GPS missions. [b]Note:[/b] This overrides the "Preferred map type" setting.
[*] [b]Require a paper map for paper map:[/b] If enabled, a paper map will be required to open the paper version of the map.
[*] [b]Allow paper map darkening:[/b] Allows you to disable the darkening of the paper map.
[*] [b]Require GPS for tablet:[/b] If enabled, it will require a GPS device to be able to open the tablet.
[*] [b]Require GPS for displaying icon:[/b] If enabled, it will require a GPS device to be able to display the arrow indicating where you are.
[*] [b]Require GPS for displaying gridref:[/b] If enabled, it will require a GPS device to be able to display your grid reference on the tablet.
[*] [b]Items that provide GPS:[/b] You can add additional items that provide GPS capabilities. This setting is an array of strings.
[*] [b]Icon on map:[/b] Specifically for the tablet. It will draw your location on the map if you have a GPS device.
[*] [b]Tablet gridref:[/b] Specifically for the tablet. It will display your grid coordinates if you have a GPS device.
[*] [b]Preferred tablet mode:[/b] Sets which tablet mode should be selected when you first load into a mission.
[/list]

[h2]CBA Keybinds[/h2]
[list]
[*] Press [b]Alt-M[/b] to open the map.
[*] While the map is open, press [b]Alt-Numpad +/-[/b] to zoom in and out.
[*] Press [b]Ctrl-Alt-N[/b] to change to night mode and back.
[*] Press [b]Shift-Ctrl-M[/b] to "refold" the map (recenters the map on your position) when "Keep player on map" setting is set to "Automatic".
[*] Press [b]Shift-Ctrl-M[/b] to set the minimap on the current cursor position when having the main map open and "Keep player on map" setting is set to "Manual". The zoom level is also copied from the main map to the minimap.
[*] Press [b]Ctrl-Alt-M[/b] while having the map open to change multiple settings. Shortcut keys are highlighted at the beginning of words (e.g. 'M' for 'Switch to [b]M[/b]anual Tracking')..
[*] Use [b]Alt-ArrowKeys[/b] to move the map around if "Keep player on map" setting is set to "Manual".
[/list]

[h2]Links[/h2]
[list]
[*] [url=https://steamcommunity.com/sharedfiles/filedetails/?id=2110586494]Steam Workshop[/url]
[*] [url=https://github.com/johnb432/Tao-folding-map]GitHub[/url]
[/list]

[h2]Credit[/h2]
[list]
[*] Original [url=https://steamcommunity.com/sharedfiles/filedetails/?id=1207709270&searchtext=tao%27s]mod[/url] by Taosenai. (C) 2013-2014 Ryan Schultz. (Workshop item has been removed, this was noticed on the 8.2.2021, but the link will be kept nonetheless.)
[*] [url=http://forums.bistudio.com/showthread.php?148517-Tao-Folding-Map]BI forum thread[/url] for original mod
[*] Dystopian for the updated darkening script, from [url=https://github.com/acemod/ACE3/blob/master/addons/map/functions/fnc_determineMapLight.sqf]ACE3[/url]
[*] drzdo for [url=https://github.com/johnb432/Tao-folding-map/issues/17]copying position and zoom in manual mode[/url]
[*] Mod overhaul by johnb43
[/list]

[h2]License[/h2]
See LICENSE.
