#include "script_component.hpp"

/*
 * Author: johnb43
 * Center map and zoom in.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call tao_rewrite_main_fnc_zoomIn;
 *
 * Public: No
 */

// Don't allow excessive zoom
if (GVAR(mapScale) / 2 < 0.005) exitWith {};

GVAR(mapScale) = GVAR(mapScale) / 2;

private _controlActiveMap = FOLDMAP displayCtrl GVAR(mapCtrlActive);

_controlActiveMap ctrlMapAnimAdd [0, GVAR(mapScale), ([GVAR(centerPos), getPosATL (call CBA_fnc_currentUnit)] select (GVAR(adjustMode) isNotEqualTo 1 && {GVAR(hasGPS) || {!GVAR(GPSAdjust)}}))];
ctrlMapAnimCommit _controlActiveMap;
GVAR(needsScaleReset) = true;
