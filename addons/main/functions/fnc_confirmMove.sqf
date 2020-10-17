#include "script_component.hpp"
/*
 * Author: johnb43
 * Move the foldmap to the position of the moving dialog and save the result.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call tao_rewrite_main_fnc_confirmMove;
 *
 * Public: No
 */

private _pos = ctrlPosition (MOVEME displayCtrl 10);
private _posX = _pos select 0;
private _posY = _pos select 1;

MOVEME closeDisplay 0;

// Make sure new positions are reasonable.
if (_posX > safeZoneXAbs && {_posY > SAFEZONE_Y && {_posX < safeZoneWAbs && {_posY < SAFEZONE_H}}}) then {
	[0.2] call FUNC(moveMapOnscreen);

	// Save to profile namespace.
	SETPRVAR(mapPosX, _posX);
	SETPRVAR(mapPosY, _posY);
} else {
	systemChat "Invalid position.";
};
