#include "script_component.hpp"
/*
 * Author: johnb43
 * Calculates the position where all things must be according to scale.
 * Called for calculating new values only!
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call tao_rewrite_main_fnc_calcPosUI;
 *
 * Public: No
 */

// Get current data
private _scale = MAP_SIZE;

// Reset everything to default
GVAR(mapScaleResize) = 1;

GVAR(backgroundXPos) = MAP_XPOS - (safeZoneH * 0.093);
GVAR(backgroundYPos) = MAP_YPOS - (safeZoneH * 0.046);

GVAR(statusYOffset) = safeZoneH * 0.015;
GVAR(statusTextYOffset) = GVAR(statusYOffset) + (safeZoneH * 0.001);

// Calculate new data if necessary
if (GVAR(mapNeedsResize) && {_scale isNotEqualTo 1}) then {
    GVAR(mapScaleResize) = _scale;
    GVAR(mapNeedsResize) = false;

    private _type = (DRAW_STYLE isEqualTo "tablet");

    // If paper map, don't care about status bar
    GVAR(statusYOffset) = [0, _scale * GVAR(statusYOffset)] select _type;

    // Tablet and paper bases are offset differently; backgroundPos is absolute
    GVAR(backgroundXPos) = ((OFFSET_X - (_scale * OFFSET_X)) * _scale * pixelW) + GVAR(backgroundXPos);
    private _offsetY = [OFFSET_Y_PAPER, OFFSET_Y_TABLET] select _type;
    GVAR(backgroundYPos) = ((_offsetY - (_scale * _offsetY)) * _scale * pixelH) + GVAR(backgroundYPos);
};
