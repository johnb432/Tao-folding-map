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

(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), ([GVAR(centerPos), getPos player] select (GVAR(adjustMode) isNotEqualTo 1 && {shownGPS || {!GVAR(GPSAdjust)}}))];
ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));
GVAR(needsScaleReset) = true;
