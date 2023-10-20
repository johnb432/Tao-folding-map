#include "..\script_component.hpp"

/*
 * Author: johnb43
 * Finds out if the unit has access to a GPS panel.
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * Has access to GPS panel <BOOL>
 *
 * Example:
 * player call tao_rewrite_main_fnc_findGPS;
 *
 * Public: No
 */

private _panels = flatten (_this infoPanelComponents "left");
private _index = _panels find "MinimapDisplayComponent";

(_index != -1 && {_panels select (_index + 1)}) || {(GVAR(itemsGPS) findAny (items _this)) != -1}
