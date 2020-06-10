#include "script_component.hpp"
/*
 * Author: johnb43
 * Function to determine the text for the "Change to X" interface button.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Returns the opposite style from whatever is selected.
 *
 * Example:
 * call tao_rewrite_main_getNotSelectedStyleName;
 *
 * Public: No
 */

private _style = GETPRVAR(drawStyle, "paper");

private _return = "tablet";
if (_style == "tablet") then {
	_return = "paper";
};

_return;