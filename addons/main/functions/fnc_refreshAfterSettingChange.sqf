#include "..\script_component.hpp"
/*
 * Author: johnb43
 * Refreshes the map after a setting has been changed.
 *
 * Arguments:
 * 0: Function to run <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * "tao_rewrite_main_fnc_toggleMap" call tao_rewrite_main_fnc_refreshAfterSettingChange
 *
 * Public: No
 */

if (isNil QGVAR(funcToRun) || {_this == QFUNC(toggleMap)}) then {
    GVAR(funcToRun) = _this;
};

if (!isNil QGVAR(isRefreshing)) exitWith {};

GVAR(isRefreshing) = true;

{
    // Wait until the pause menu has been closed
    if ((findDisplay IDD_INTERRUPT) in allDisplays) exitWith {};

    (_this select 1) call CBA_fnc_removePerFrameHandler;

    call GETMVAR(GVAR(funcToRun),{});

    GVAR(funcToRun) = nil;
    GVAR(isRefreshing) = nil;
} call CBA_fnc_addPerFrameHandler
