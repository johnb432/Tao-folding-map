#include "script_component.hpp"
/*
 * Author: johnb43
 * Change map type to "paper" or "tablet."
 *
 * Arguments:
 * 0: The map type <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * call tao_rewrite_main_fnc_changeType;
 *
 * Public: No
 */

params ["_type"];

if (GVAR(maplock) && {(_type == "paper" || _type == "tablet")}) then {
	// Save new style to profile namespace.
	SETPRVAR(drawStyle, _type);

	// If paper was selected, turn on alternate render codepath.
	if (_type == "paper") then {
		GVAR(drawPaper) = true;
	} else {
		GVAR(drawPaper) = false;
	};

	if (GVAR(isOpen)) then {
			call FUNC(refreshMap);
	};
};