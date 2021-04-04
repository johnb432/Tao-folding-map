#include "script_component.hpp"
/*
 * Author: johnb43
 * Open and closes the map to refresh the interface (for tablet and paper map).
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tao_rewrite_main_fnc_refreshMap;
 *
 * Public: No
 */

// This prevents the map from refreshing too many times, when multiple settings are changed at once
if (GVAR(isRefreshing)) exitWith {};

call FUNC(toggleMap);
GVAR(isRefreshing) = true;

[{
    call FUNC(toggleMap);
    GVAR(isRefreshing) = false;
}, [], 1] call CBA_fnc_waitAndExecute;
