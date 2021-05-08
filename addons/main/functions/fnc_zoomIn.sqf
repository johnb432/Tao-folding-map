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

(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), ([GVAR(centerPos), getPos player] select (GVAR(adjustMode) isNotEqualTo 1 && {shownGPS || {!GVAR(GPSAdjust)}}))];
ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));
GVAR(needsScaleReset) = true;
