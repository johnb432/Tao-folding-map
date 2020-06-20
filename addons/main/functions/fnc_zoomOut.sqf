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
 * all tao_rewrite_main_fnc_zoomOut;
 *
 * Public: No
 */

if (GVAR(isOpen)) then {
	GVAR(mapScale) = GVAR(mapScale) * 2;

	if (GVAR(mapScale) > 1) then {
		GVAR(mapScale) = 1;
	};

	private _tao_foldmap_centerPos = getPos player;
	private _x = _tao_foldmap_centerPos select 0;
	private _y = _tao_foldmap_centerPos select 1;

	if (GVAR(allowadjust) == 1) then {
		_x = GVAR(centerPos) select 0;
		_y = GVAR(centerPos) select 1;
	};
	(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), [_x, _y, 0]];
	ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));
	GVAR(needsScaleReset) = true;
};