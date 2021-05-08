#include "script_component.hpp"

// Get a rsc layer from the BI system.
GVAR(mapRscLayer) = [QGVAR(layer)] call BIS_fnc_rscLayer;

// Set appropriate map scale for the world being used. Default map scale computed as 0.2 * 8192 / mapsize
GVAR(mapScale) = [0.2, 1638.4 / worldSize] select (!isNil {worldName});

// Scale tracking globals.
GVAR(baseScale) = GVAR(mapScale);
GVAR(needsScaleReset) = false;

// Is the map open?
GVAR(isOpen) = false;

// Initialize shaking values.
GVAR(shake) = false;

// Initialize map refresh value
GVAR(isRefreshing) = false;

// Move old data to new position name. To be deleted after a while
if (!isNil {GETPRVAR(mapPosX,nil)}) then {
    private _mapX = GETPRVAR(mapPosX,nil);
    MAP_XPOS_SET(_mapX);
    SETPRVAR(mapPosX,nil);
};

if (!isNil {GETPRVAR(mapPosY,nil)}) then {
    private _mapY = GETPRVAR(mapPosY,nil);
    MAP_YPOS_SET(_mapY);
    SETPRVAR(mapPosY,nil);
};

// Main GUI positioning data. Get positions from config.
private _posX = MAP_XPOS;
private _posY = MAP_YPOS;

// Make sure it's on the screen.
if (_posX > safeZoneXAbs && {_posY > safeZoneY} && {_posX < safeZoneWAbs} && {_posY < safeZoneH}) then {
    MAP_XPOS_SET(_posX);
    MAP_YPOS_SET(_posY);
};

// Minimap size
if (isNil {MAP_SIZE}) then {
    MAP_SIZE_SET(1);
};

// Calculate all necessary UI positions
GVAR(mapNeedsResize) = true;
call FUNC(calcPosUI);
