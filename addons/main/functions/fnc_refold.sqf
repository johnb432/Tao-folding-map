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

if (!hasInterface) exitWith {};

if (GVAR(isOpen) && {GVAR(allowadjust) != 1}) then {
	private _tao_foldmap_centerPos = getPos player;
	private _x = _tao_foldmap_centerPos select 0;
	private _y = _tao_foldmap_centerPos select 1;
	(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), [_x, _y, 0]];
	ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));
	GVAR(centerPos) = [_x, _y];
};