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

private _selection = ([0, 3] select GVAR(isNightMap)) + (round (log (MAP_SIZE) / log (0.9)));
GVAR(mapCtrlActive) = [DAYMAP, DAYMAP_ZOOM_1, DAYMAP_ZOOM_2, NIGHTMAP, NIGHTMAP_ZOOM_1, NIGHTMAP_ZOOM_2] select _selection;
GVAR(mapCtrlInactive) = [NIGHTMAP, NIGHTMAP_ZOOM_1, NIGHTMAP_ZOOM_2, DAYMAP, DAYMAP_ZOOM_1, DAYMAP_ZOOM_2] select _selection;

// Give new map the scale/centering properties of the old map.
(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));

// Show the new map.
(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlSetPosition (ctrlPosition (FOLDMAP displayCtrl GVAR(mapCtrlInactive)));
(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlCommit 0;
(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlShow true;

// Hide the old map.
(FOLDMAP displayCtrl GVAR(mapCtrlInactive)) ctrlShow false;
(FOLDMAP displayCtrl GVAR(mapCtrlInactive)) ctrlSetPosition [MAP_XPOS, safeZoneH];
(FOLDMAP displayCtrl GVAR(mapCtrlInactive)) ctrlCommit 0;

//'Refolds' the map to recenter it.
if (GVAR(adjustMode) isEqualTo 0 && {GVAR(foundGPS) || {!GVAR(GPSAdjust)}}) then {
    private _pos = getPos player;
    (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), _pos];
    ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));
    GVAR(centerPos) = _pos;
};
