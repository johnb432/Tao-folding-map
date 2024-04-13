#include "..\script_component.hpp"

/*
 * Author: johnb43
 * Finds out if the unit has access to a GPS panel.
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * player call tao_rewrite_main_fnc_findGPS;
 *
 * Public: No
 */

// Small piece of code from ACE
private _gpsOpened = visibleGPS;
private _gpsAvailable = openGPS true;

if (!_gpsOpened) then {openGPS false};

_gpsAvailable && {(GVAR(itemsGPS) findAny (items _this)) != -1};
