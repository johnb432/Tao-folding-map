#include "script_component.hpp"

/*
 * Author: johnb43
 * Center map and zoom out.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call tao_rewrite_main_fnc_zoomOut;
 *
 * Public: No
 */

GVAR(mapScale) = (GVAR(mapScale) * 2) min 1;

private _controlActiveMap = FOLDMAP displayCtrl GVAR(mapCtrlActive);

_controlActiveMap ctrlMapAnimAdd [0, GVAR(mapScale), ([GVAR(centerPos), getPosATL (call CBA_fnc_currentUnit)] select (GVAR(adjustMode) isNotEqualTo 1 && {GVAR(hasGPS) || {!GVAR(GPSAdjust)}}))];
ctrlMapAnimCommit _controlActiveMap;
GVAR(needsScaleReset) = true;
