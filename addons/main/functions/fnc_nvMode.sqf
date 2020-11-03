#include "script_component.hpp"
/*
 * Author: johnb43
 * Toggle the map's nightvision view (if using tablet map).
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call tao_rewrite_main_fnc_nvMode;
 *
 * Public: No
 */

// Change which map is in use
GVAR(isNightMap) = !GVAR(isNightMap);

GVAR(mapCtrlActive) = [DAYMAP, NIGHTMAP] select (GVAR(isNightMap));
GVAR(mapCtrlInactive) = [NIGHTMAP, DAYMAP] select (GVAR(isNightMap));

// Give new map the scale/centering properties of the old map.
(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), [GVAR(centerPos) select 0, GVAR(centerPos) select 1, 0]];
ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));

// Show the new map.
(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlSetPosition (ctrlPosition (FOLDMAP displayCtrl GVAR(mapCtrlInactive)));
(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlCommit 0;
(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlShow true;

// Hide the old map.
(FOLDMAP displayCtrl GVAR(mapCtrlInactive)) ctrlShow false;
(FOLDMAP displayCtrl GVAR(mapCtrlInactive)) ctrlSetPosition [MAP_XPOS, SAFEZONE_H];
(FOLDMAP displayCtrl GVAR(mapCtrlInactive)) ctrlCommit 0;

//'Refolds' the map to recenter it.
if (GVAR(allowAdjust) == 0) then {
   	private _pos = getPos player;
   	(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), [_pos select 0, _pos select 1, 0]];
   	ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));
   	GVAR(centerPos) = [_pos select 0, _pos select 1];
};
