#include "script_component.hpp"

// Get a rsc layer from the BI system.
tao_foldmap_rscLayer = ["TMR_FoldMap"] call BIS_fnc_rscLayer;

// Set appropriate map scale for the world being used.
// Default map scale computed as 0.2 * 8192 / mapsize
GVAR(mapScale) = 0.2;
private _name = worldName;

if (!isNil "_name") then {
	private _worldsize = worldSize;
	GVAR(mapScale) = 0.2 * 8192 / _worldsize;
};

// Scale tracking globals.
GVAR(needsScaleReset) = false;
GVAR(baseScale) = GVAR(mapScale);

// Is the map open?
GVAR(isOpen) = false;

// Main GUI positioning data.
// -----
// Get positions from config.

private _posX = GETPRVAR(mapPosX, DEFAULT_MAP_XPOS);
private _posY = GETPRVAR(mapPosY, DEFAULT_MAP_YPOS);

// Make sure it's on the screen.
if (typeName _posX == "SCALAR" && {typeName _posY == "SCALAR" && {_posX > safeZoneXAbs && {_posY > SAFEZONE_Y && {_posX < safeZoneWAbs && {_posY < SAFEZONE_H}}}}}) then {
	SETPRVAR(mapPosX, _posX);
	SETPRVAR(mapPosY, _posY);
};
