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

if (GVAR(mapScale) / 2 > 0.005) then { // Don't allow excessive zoom
    GVAR(mapScale) = GVAR(mapScale) / 2;

    private _pos = [getPos player, GVAR(centerPos)] select (GVAR(allowAdjust) == 1);

    (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), [_pos select 0, _pos select 1, 0]];
    ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));
    GVAR(needsScaleReset) = true;
};
