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

if (GVAR(maplock)) then {
	// Save new style to profile namespace.
	SETPRVAR(drawStyle, _type);
    
    GVAR(drawPaper) = [false, true] select (_type == "paper");
    //GVAR(drawPaper) = if (_type == "paper") then {true} else {false};

	if (GVAR(isOpen)) then {
        call FUNC(refreshMap);
	};
};
