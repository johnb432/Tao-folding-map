#include "script_component.hpp"

// Get a rsc layer from the BI system.
GVAR(mapRscLayer) = ["TMR_FoldMap"] call BIS_fnc_rscLayer;

// Set appropriate map scale for the world being used. Default map scale computed as 0.2 * 8192 / mapsize
GVAR(mapScale) = 0.2;

if (!isNil {worldName}) then {
	GVAR(mapScale) = 1638.4 / worldSize;
};

// Scale tracking globals.
GVAR(needsScaleReset) = false;
GVAR(baseScale) = GVAR(mapScale);

// Is the map open?
GVAR(isOpen) = false;

// Main GUI positioning data. Get positions from config.
private _posX = MAP_XPOS;
private _posY = MAP_YPOS;

// Make sure it's on the screen.
if (typeName _posX == "SCALAR" && {typeName _posY == "SCALAR" && {_posX > safeZoneXAbs && {_posY > SAFEZONE_Y && {_posX < safeZoneWAbs && {_posY < SAFEZONE_H}}}}}) then {
	SETPRVAR(mapPosX, _posX);
	SETPRVAR(mapPosY, _posY);
};
