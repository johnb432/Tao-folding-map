#include "script_component.hpp"
/*
 * Author: johnb43
 * onLoad function for foldmap dialog.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call tao_rewrite_main_fnc_onLoadDialog;
 *
 * Public: No
 */

// If config set, change to paper map.
if (GVAR(drawPaper)) then {
    // Change to paper background.
    (FOLDMAP displayCtrl BACKGROUND) ctrlSetText "\x\tao_rewrite\addons\main\data\paper_ca.paa";

    // Hide the status bar.
    (FOLDMAP displayCtrl STATUSBAR) ctrlShow false;
    (FOLDMAP displayCtrl STATUSLEFT) ctrlShow false;
    (FOLDMAP displayCtrl STATUSRIGHT) ctrlShow false;
};

private _arrayTypes = [DAYMAP, DAYMAP_ZOOM_1, DAYMAP_ZOOM_2, NIGHTMAP, NIGHTMAP_ZOOM_1, NIGHTMAP_ZOOM_2];

private _selection = ([0, 3] select (!GVAR(drawPaper) && {GVAR(isNightMap)})) + (round (log (MAP_SIZE) / log (0.9)));
GVAR(mapCtrlActive) = _arrayTypes select _selection;
GVAR(mapCtrlInactive) = [NIGHTMAP, NIGHTMAP_ZOOM_1, NIGHTMAP_ZOOM_2, DAYMAP, DAYMAP_ZOOM_1, DAYMAP_ZOOM_2] select _selection;

// On first run, get the center pos. This is used for all paging thereafter.
// [a, b] select (true) --> b              tao_rewrite_main_ for GVAR
if (isNil QGVAR(centerPos)) then {
    GVAR(centerPos) = [[worldSize / 2, worldSize / 2, 0], getPos player] select (GVAR(adjustMode) isNotEqualTo 1 && (GVAR(foundGPS) || {!GVAR(GPSAdjust)}));
};

// Off-map check for non-manual modes: If the player passed off the map while it was closed, recenter it. Fudge factor here to avoid opening on the edge of the map, which isn't very helpful.
if (GVAR(adjustMode) isNotEqualTo 1 && {GVAR(foundGPS) || !GVAR(GPSAdjust)} && {abs ((GVAR(centerPos) select 0) - (getPos player select 0)) + 150 > GVAR(pageWidth) || abs ((GVAR(centerPos) select 1) - (getPos player select 1)) + 150 > GVAR(pageHeight)}) then {
    GVAR(centerPos) = getPos player;
};

// Center map on current centering position.
(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));

// Hide the unused map.
{
    (FOLDMAP displayCtrl _x) ctrlShow false;
} forEach [DAYMAP, DAYMAP_ZOOM_1, DAYMAP_ZOOM_2, NIGHTMAP, NIGHTMAP_ZOOM_1, NIGHTMAP_ZOOM_2];
(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlShow true;

// Place everything in position to be scrolled.
[0] call FUNC(moveMapOffscreen);

// Find out which maps are being used, so we apply EH to those only
private _index = _arrayTypes findIf {_x isEqualTo GVAR(mapCtrlActive)};

if (_index < 3) then {
    GVAR(activeDayMap) = _arrayTypes select _index;
    GVAR(activeNightMap) = _arrayTypes select (_index +  3);
} else {
    GVAR(activeDayMap) = _arrayTypes select (_index -  3);
    GVAR(activeNightMap) = _arrayTypes select _index;
};

// Add per-frame draw handler to update the player marker and darken map.
if (GVAR(drawPaper)) then {
    // Darken paper map based on time. Based on ShackTac Map Brightness by zx64 & Dslyecxi. Draw a dark rectangle covering the map.
    (FOLDMAP displayCtrl GVAR(activeDayMap)) ctrlAddEventHandler ["Draw", {
        (FOLDMAP displayCtrl GVAR(activeDayMap)) drawRectangle [((FOLDMAP displayCtrl GVAR(activeDayMap)) ctrlMapScreenToWorld [MAP_XPOS, MAP_YPOS]), GVAR(pageWidth) * 3, GVAR(pageHeight) * 3, 0, [0, 0, 0, (0.72 min (1 - sunOrMoon))], "#(rgb,1,1,1)color(0,0,0,1)"];
    }];
} else {
    (FOLDMAP displayCtrl GVAR(activeDayMap)) ctrlAddEventHandler ["Draw", {
        if (GVAR(mapIcon) && {GVAR(foundGPS)}) then {
            (FOLDMAP displayCtrl GVAR(activeDayMap)) drawIcon [getText(configFile >> "CfgMarkers" >> "mil_arrow2" >> "icon"), [0.06, 0.08, 0.06, 0.87], getPos player, 19, 25, direction vehicle player, "", false];
        };
    }];

    (FOLDMAP displayCtrl GVAR(activeNightMap)) ctrlAddEventHandler ["Draw", {
        if (GVAR(mapIcon) && {GVAR(foundGPS)}) then {
            (FOLDMAP displayCtrl GVAR(activeNightMap)) drawIcon [getText(configFile >> "CfgMarkers" >> "mil_arrow2" >> "icon"), [0.9, 0.9, 0.9, 0.8], getPos player, 19, 25, direction vehicle player, "", false];
        };
    }];
};
