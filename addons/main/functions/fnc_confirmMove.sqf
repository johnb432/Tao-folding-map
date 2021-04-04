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

// Get current repositioning display data and close repositioning afterwards
ctrlPosition (MOVEME displayCtrl 10) params ["_posX", "_posY"];
MOVEME closeDisplay 0;

// Make sure new positions are reasonable.
if (_posX > safeZoneXAbs && {_posY > safeZoneY} && {_posX < safeZoneWAbs} && {_posY < safeZoneH}) then {
    // Save to profile namespace.
    GVAR(backgroundXPos) = (_posX - MAP_XPOS) + GVAR(backgroundXPos);
    GVAR(backgroundYPos) = (_posY - MAP_YPOS) + GVAR(backgroundYPos);

    MAP_XPOS_SET(_posX);
    MAP_YPOS_SET(_posY);

    [0.2] call FUNC(moveMapOnscreen);
} else {
    systemChat "Invalid position.";
};
