#include "script_component.hpp"
/*
 * Author: johnb43
 * Per-frame draw handler for map.
 * Draw location of player if map icon is enabled and has a GPS and is tablet (no magic for paper map)
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call tao_foldmap_main_fnc_drawUpdateTablet;
 *
 * Public: No
 */

if (GVAR(mapicon) && {visibleGPS}) then {
	private _pos = getPos player;

	if (!GVAR(isNightMap)) then {
		(FOLDMAP displayCtrl DAYMAP) drawIcon [getText(configFile >> "CfgMarkers" >> "mil_arrow2" >> "icon"), [0.06, 0.08, 0.06, 0.87], _pos, 19, 25, direction vehicle player, "", false];
	} else {
		(FOLDMAP displayCtrl NIGHTMAP) drawIcon [getText(configFile >> "CfgMarkers" >> "mil_arrow2" >> "icon"), [0.9, 0.9, 0.9, 0.8], _pos, 19, 25, direction vehicle player, "", false];
	};
};