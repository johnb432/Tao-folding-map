#include "script_component.hpp"
/*
 * Author: johnb43
 * 'Refolds' the map to recenter it.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call tao_rewrite_main_fnc_refold;
 *
 * Public: No
 */

if (GVAR(isOpen) && {GVAR(allowAdjust) != 1}) then {
   	private _pos = getPos player;
   	(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), [_pos select 0, _pos select 1, 0]];
   	ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));
   	GVAR(centerPos) = [_pos select 0, _pos select 1];
};
