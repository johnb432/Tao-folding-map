#include "script_component.hpp"

ADDON = false;

#include "XEH_PREP.hpp"

// CBA Settings
#include "initSettings.inc.sqf"

if (hasInterface) then {
    // Set appropriate map scale for the world being used. Default map scale computed as 0.2 * 8192 / mapsize
    GVAR(baseScale) = [0.2, 1638.4 / worldSize] select (worldName != "");

    // Initialize values
    GVAR(mapScale) = GVAR(baseScale);
    GVAR(isOpen) = false;
    GVAR(drawPaper) = [GVAR(prefMap), true] select GVAR(mapTypeLocked);

    GVAR(allowAdjustSettingIsLocked) = true;
    GVAR(hasGPS) = false;
    GVAR(nightMap) = false;

    // Enable map after CBA settings have been initialised
    ["CBA_settingsInitialized", {
        (call CBA_fnc_currentUnit) call FUNC(findGPS);
    }] call CBA_fnc_addEventHandler;

    // Refresh map after layout has been changed
    ["CBA_layoutEditorSaved", {
        MAP_WIDTH_SET(MAP_HEIGHT / RATIO_H_W);

        INFO_TF(FORMAT_4(QUOTE(New map position: x = ARR_2(%1,y) = ARR_2(%2,w) = ARR_2(%3,h) = %4),MAP_XPOS,MAP_YPOS,MAP_WIDTH,MAP_HEIGHT));

        if (!GVAR(isOpen)) exitWith {};

        QFUNC(refreshMap) call FUNC(refreshAfterSettingChange);
    }] call CBA_fnc_addEventHandler;

    // Refresh map if any CBA settings of this mod have been changed
    ["CBA_SettingChanged", {
        if !(QUOTE(ADDON) in (_this select 0)) exitWith {};

        if (!GVAR(isOpen)) exitWith {};

        QFUNC(refreshMap) call FUNC(refreshAfterSettingChange);
    }] call CBA_fnc_addEventHandler;

    // Remove after a while
    SETPRVAR(QGVAR(drawStyle),nil);
};

ADDON = true;
