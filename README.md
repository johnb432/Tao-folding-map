**Tao's Folding Map Rewrite** is a client side mod that lets you open a tactical map while in game which is bigger and more useful than the GPS. To move or resize the map, use the in game UI layout editor under Options -> Game -> Layout.

<h2>CBA Settings</h2>

When "GPS device" is used in this description of the mod, it means you need to have access to a GPS panel, which can come from a Vanilla GPS, UAV Terminals, Firewill's PDU, BWA's Navipad and more, but also from vehicles.

* **Map:** Allows the addons to be effectively toggled off if necessary.
* **Preferred map type:** Sets which map type should be selected when you first load into a mission.
* **Close map:** If set to disabled it will stay open when you open the vanilla map. If enabled the map will close.
* **Keep map open in:** Allows you to define in which perspectives Tao's folding map will not be closed in.
* **Refresh rate:** Allows you to set the refresh interval at which the map refreshes itself.
* **Keep player on map:** Always keeps you on the map if set to automatic. On manual, you need to use the "Move up/down/left/right" keys to move the map around. Useful if want to disable automatic centering.
* **Lock 'Keep player on map':** Enforces the 'Keep player on map' setting, useful for servers.
* **Require GPS to adjust automatically:** This setting is set to "Yes" by default ***and can only be changed by the server***.
If set to "Yes" a GPS device will be required in order to have automatic position tracking. The idea is that you need a GPS device to be able to track your position automatically but this can be turned off, if the mission maker/admin wants to.
* **Lock map type:** Locks the map type to the paper map. Useful for pre-GPS missions. **Note:** This overrides the "Preferred map type" setting.
* **Require a paper map for paper map:** If enabled, a paper map will be required to open the paper version of the map.
* **Allow paper map darkening:** Allows you to disable the darkening of the paper map.
* **Require GPS for tablet:** If enabled, it will require a GPS device to be able to open the tablet.
* **Require GPS for displaying icon:** If enabled, it will require a GPS device to be able to display the arrow indicating where you are.
* **Require GPS for displaying gridref:** If enabled, it will require a GPS device to be able to display your grid reference on the tablet.
* **Icon on map:** Specifically for the tablet. It will draw your location on the map if you have a GPS device.
* **Tablet gridref:** Specifically for the tablet. It will display your grid coordinates if you have a GPS device.
* **Preferred tablet mode:** Sets which tablet mode should be selected when you first load into a mission.

<h2>CBA Keybinds</h2>

* Press **Alt-M** to open the map.
* While the map is open, press **Alt-Numpad +/-** to zoom in and out.
* Press **Ctrl-Alt-N** to change to night mode and back.
* Press **Shift-Ctrl-M** to "refold" the map (recenters the map on your position). Disabled if "Keep player on map" setting is set to "Manual".
* Press **Ctrl-Alt-M** while having the map open to change multiple settings. Shortcut keys are highlighted at the beginning of words (e.g. 'M' for 'Switch to **M**anual Tracking').
* Use **Alt-ArrowKeys** to move the map around if "Keep player on map" setting is set to "Manual".

<h2>Links</h2>

* [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2110586494)
* [GitHub](https://github.com/johnb432/Tao-folding-map)

<h2>Credit</h2>

* Original [mod](https://steamcommunity.com/sharedfiles/filedetails/?id=1207709270&searchtext=tao%27s) by Taosenai. (C) 2013-2014 Ryan Schultz. (Workshop item has been removed, this was noticed on the 8.2.2021, but the link will be kept nonetheless.)
* [BI Forum thread](http://forums.bistudio.com/showthread.php?148517-Tao-Folding-Map) for original mod
* Dystopian for the updated darkening script, from [ACE3](https://github.com/acemod/ACE3/blob/master/addons/map/functions/fnc_determineMapLight.sqf)
* Mod overhaul by johnb43

<h2>How to create PBOs</h2>

* Download and install hemtt from [here](https://github.com/BrettMayson/HEMTT)
* Open command terminal, navigate to said folder (Windows: cd 'insert path')
* Type "hemtt build" for pbo, "hemtt build --release" for entire release
