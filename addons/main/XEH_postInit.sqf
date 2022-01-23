#include "script_component.hpp"

// Get a rsc layer from the BI system.
GVAR(mapRscLayer) = [QGVAR(layer)] call BIS_fnc_rscLayer;

// Set appropriate map scale for the world being used. Default map scale computed as 0.2 * 8192 / mapsize
GVAR(mapScale) = [0.2, 1638.4 / worldSize] select (worldName isNotEqualTo "");

// Initialize values
GVAR(baseScale) = GVAR(mapScale);
GVAR(needsScaleReset) = false;
GVAR(isOpen) = false;
GVAR(hasGPS) = (call CBA_fnc_currentUnit) call FUNC(findGPS);
GVAR(drawPaper) = [GVAR(prefMap), true] select GVAR(mapTypeLocked);
DRAW_STYLE_SET([ARR_2("tablet","paper")] select GVAR(drawPaper));

// Move old data to new position name; To be deleted after a while
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

if (!isNil {GETPRVAR(GVAR(mapPosX),nil)}) then {
    private _mapX = GETPRVAR(GVAR(mapPosX),nil);
    MAP_XPOS_SET(_mapX);
    SETPRVAR(GVAR(mapPosX),nil);
};

if (!isNil {GETPRVAR(GVAR(mapPosY),nil)}) then {
    private _mapY = GETPRVAR(GVAR(mapPosY),nil);
    MAP_YPOS_SET(_mapY);
    SETPRVAR(GVAR(mapPosY),nil);
};

if (!isNil {GETPRVAR(GVAR(mapSize),nil)}) then {
    SETPRVAR(GVAR(mapSize),nil);
};
// Old data finished

// Make sure data exists, sometimes it fails
if (GETPRVAR(igui_grid_tao_folding_map_rewrite_x,0) isEqualTo 0) then {
    SETPRVAR(igui_grid_tao_folding_map_rewrite_x,POS_X(5));
};
if (GETPRVAR(igui_grid_tao_folding_map_rewrite_y,0) isEqualTo 0) then {
    SETPRVAR(igui_grid_tao_folding_map_rewrite_y,POS_Y(5));
};
if (GETPRVAR(igui_grid_tao_folding_map_rewrite_w,0) isEqualTo 0) then {
    SETPRVAR(igui_grid_tao_folding_map_rewrite_w,POS_W(20));
};
if (GETPRVAR(igui_grid_tao_folding_map_rewrite_h,0) isEqualTo 0) then {
    SETPRVAR(igui_grid_tao_folding_map_rewrite_h,POS_H(20));
};

// Refresh map after layout has been changed
["CBA_layoutEditorSaved", {
    MAP_WIDTH_SET(MAP_HEIGHT / RATIO_H_W);

    if (!isNil QGVAR(isRefreshing)) exitWith {};

    GVAR(isRefreshing) = true;

    [{
        // Wait until the pause menu has been closed
        !((findDisplay IDD_INTERRUPT) in allDisplays);
    }, {
        if (GVAR(isOpen)) then {
            call FUNC(refreshMap);
        };

        GVAR(isRefreshing) = nil;
    }] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_addEventHandler;

// Refresh map if any CBA settings of this mod have been changed
["CBA_SettingChanged", {
    params ["_setting"];

    if !((QUOTE(ADDON) in _setting) && {isNil QGVAR(isRefreshing)}) exitWith {};

    GVAR(isRefreshing) = true;

    [{
        // Wait until the pause menu has been closed
        !((findDisplay IDD_INTERRUPT) in allDisplays);
    }, {
        if (GVAR(isOpen)) then {
            call FUNC(refreshMap);
        };

        GVAR(isRefreshing) = nil;
    }] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_addEventHandler;
