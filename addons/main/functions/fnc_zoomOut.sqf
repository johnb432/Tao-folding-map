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

GVAR(mapScale) = GVAR(mapScale) * 2;

if (GVAR(mapScale) > 1) then {
	   GVAR(mapScale) = 1;
};

private _pos = [GVAR(centerPos), getPos player] select (GVAR(allowAdjust) != 1 && {visibleGPS || GVAR(GPSAdjust)});

(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), [_pos select 0, _pos select 1, 0]];
ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));
GVAR(needsScaleReset) = true;
