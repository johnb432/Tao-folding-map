#include "script_component.hpp"
/*
 * Author: johnb43
 * Reposition the map.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call tao_rewrite_main_fnc_reposition;
 *
 * Public: No
 */

if (!hasInterface) exitWith {};

if (GVAR(reposmap)) then {
	if (GVAR(isOpen)) then {
		// Close any other moving dialogs.
		MOVEME closeDisplay 0;
		createDialog "Tao_FoldMap_MovingDialog";
	};
} else {
	if (GVAR(isOpen)) then {
		systemChat "Repositioning map disabled in mission config.";
	};
};