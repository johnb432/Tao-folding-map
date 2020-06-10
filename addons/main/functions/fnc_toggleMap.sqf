#include "script_component.hpp"
/*
 * Author: johnb43
 * Toggle the folding map open and closed.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tao_rewrite_main_fnc_toggleMap;
 *
 * Public: No
 */

if (GVAR(enablemap) && {!visibleMap && {("ItemMap" in assignedItems player)}}) then {
	if (!GVAR(isOpen)) then {
		call FUNC(openFoldmap);
	} else {
		GVAR(doShow) = false; // Ends the monitor loop. Map is not ready again until scroll away finishes.
	};
};