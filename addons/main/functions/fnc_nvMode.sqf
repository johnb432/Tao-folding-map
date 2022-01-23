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

GVAR(mapCtrlActive) = [IDC_DAYMAP, IDC_NIGHTMAP] select (!GVAR(drawPaper) && {GVAR(isNightMap)});
GVAR(mapCtrlInactive) = [IDC_NIGHTMAP, IDC_DAYMAP] select (!GVAR(drawPaper) && {GVAR(isNightMap)});

private _foldmap = FOLDMAP;
private _controlActiveMap = _foldmap displayCtrl GVAR(mapCtrlActive);
private _controlInactiveMap = _foldmap displayCtrl GVAR(mapCtrlInactive);

// Give new map the scale/centering properties of the old map.
_controlActiveMap ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
ctrlMapAnimCommit _controlActiveMap;

// Show the new map

/*
2.08

_controlActiveMap ctrlMapSetPosition (ctrlMapPosition _controlInactiveMap);
*/
(ctrlPosition (_foldmap displayCtrl IDC_STATUSBAR)) params ["", "", "_width", "_height"];
_controlActiveMap ctrlMapSetPosition [
    POS_X(6.45) + pixelW * OFFSET_X * (SCALE - 1),
    POS_Y(1.42) + (_height + pixelH * OFFSET_Y_TABLET) * (SCALE - 1),
    _width * SCALE,
    _width * SCALE * RATIO_H_W_MAP
];

_controlActiveMap ctrlShow true;

// Hide the old map
_controlInactiveMap ctrlShow false;

//'Refolds' the map to recenter it
if (GVAR(adjustMode) isEqualTo 0 && {GVAR(hasGPS) || {!GVAR(GPSAdjust)}}) then {
    GVAR(centerPos) = getPosATL (call CBA_fnc_currentUnit);
    _controlActiveMap ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
    ctrlMapAnimCommit _controlActiveMap;
};
