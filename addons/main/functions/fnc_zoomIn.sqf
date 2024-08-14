#include "..\script_component.hpp"
/*
 * Author: johnb43
 * Zoom in.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call tao_rewrite_main_fnc_zoomIn
 *
 * Public: No
 */

// Don't allow excessive zoom
if (GVAR(mapScale) / GVAR(zoomStep) < 0.005) exitWith {};

GVAR(mapScale) = GVAR(mapScale) / GVAR(zoomStep);

private _controlActiveMap = FOLDMAP displayCtrl GVAR(mapCtrlActive);

_controlActiveMap ctrlMapAnimAdd [0, GVAR(mapScale), ([GVAR(centerPos), getPosATL (call CBA_fnc_currentUnit)] select (GVAR(adjustMode) != MANUAL && {GVAR(hasGPS) || {!GVAR(GPSAdjust)}}))];
ctrlMapAnimCommit _controlActiveMap;
