#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

// CBA settings & keybinds
#include "initSettings.sqf"
#include "initKeybinds.sqf"

// Get a rsc layer from the BI system
GVAR(mapRscLayer) = [QGVAR(layer)] call BIS_fnc_rscLayer;

// Set appropriate map scale for the world being used. Default map scale computed as 0.2 * 8192 / mapsize
GVAR(mapScale) = [0.2, 1638.4 / worldSize] select (worldName != "");

// Initialize values
GVAR(baseScale) = GVAR(mapScale);
GVAR(isOpen) = false;
GVAR(drawPaper) = [GVAR(prefMap), true] select GVAR(mapTypeLocked);
DRAW_STYLE_SET([ARR_2("tablet","paper")] select GVAR(drawPaper));
GVAR(CBASettingsInitialized) = false;
GVAR(allowAdjustSettingIsLocked) = true;
GVAR(hasGPS) = false;

// Enable map after CBA settings have been initialised
["CBA_settingsInitialized", {
    GVAR(CBASettingsInitialized) = true;

    GVAR(hasGPS) = (call CBA_fnc_currentUnit) call FUNC(findGPS);
}] call CBA_fnc_addEventHandler;

// Refresh map after layout has been changed
["CBA_layoutEditorSaved", {
    MAP_WIDTH_SET(MAP_HEIGHT / RATIO_H_W);

    if !(GVAR(isOpen) && {isNil QGVAR(isRefreshing)}) exitWith {};

    GVAR(isRefreshing) = true;

    [{
        // Wait until the pause menu has been closed
        !((findDisplay IDD_INTERRUPT) in allDisplays)
    }, {
        call FUNC(refreshMap);

        GVAR(isRefreshing) = nil;
    }] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_addEventHandler;

// Refresh map if any CBA settings of this mod have been changed
["CBA_SettingChanged", {
    params ["_setting"];

    if !((QUOTE(ADDON) in _setting) && {GVAR(isOpen)} && {isNil QGVAR(isRefreshing)}) exitWith {};

    GVAR(isRefreshing) = true;

    [{
        // Wait until the pause menu has been closed
        !((findDisplay IDD_INTERRUPT) in allDisplays)
    }, {
        call FUNC(refreshMap);

        GVAR(isRefreshing) = nil;
    }] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_addEventHandler;

ADDON = true;
