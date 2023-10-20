#include "..\script_component.hpp"

/*
 * Author: johnb43
 * Does manual tracking.
 *
 * Arguments:
 * 0: Active map control <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * ((uiNamespace getVariable ["tao_rewrite_main_foldmap", displayNull]) displayCtrl tao_rewrite_main_mapCtrlActive) call tao_rewrite_main_fnc_PFHmanual;
 *
 * Public: No
 */

// Need to page left?
if (GVAR(left)) exitWith {
    GVAR(centerPos) set [0, (GVAR(centerPos) select 0) - GVAR(pageWidth) / 2 + 176 * GVAR(mapScale) / GVAR(baseScale)];
    _this ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
    ctrlMapAnimCommit _this;
    GVAR(left) = false;
};

// Need to page right?
if (GVAR(right)) exitWith {
    GVAR(centerPos) set [0, (GVAR(centerPos) select 0) + GVAR(pageWidth) / 2 - 176 * GVAR(mapScale) / GVAR(baseScale)];
    _this ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
    ctrlMapAnimCommit _this;
    GVAR(right) = false;
};

// Need to page up?
if (GVAR(up)) exitWith {
    GVAR(centerPos) set [1, (GVAR(centerPos) select 1) + GVAR(pageHeight) / 2 - 176 * GVAR(mapScale) / GVAR(baseScale)];
    _this ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
    ctrlMapAnimCommit _this;
    GVAR(up) = false;
};

// Need to page down?
if (GVAR(down)) exitWith {
    GVAR(centerPos) set [1, (GVAR(centerPos) select 1) - GVAR(pageHeight) / 2 + 176 * GVAR(mapScale) / GVAR(baseScale)];
    _this ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
    ctrlMapAnimCommit _this;
    GVAR(down) = false;
};
