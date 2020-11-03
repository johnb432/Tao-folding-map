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

GVAR(mapCtrlActive) = [DAYMAP, NIGHTMAP] select (!GVAR(drawPaper) && {GVAR(isNightMap)});
GVAR(mapCtrlInactive) = [NIGHTMAP, DAYMAP] select (!GVAR(drawPaper) && {GVAR(isNightMap)});

// On first run, get the center pos. This is used for all paging thereafter.
if (isNil QGVAR(centerPos)) then {
    GVAR(centerPos) = [getPos player, [worldSize / 2, worldSize / 2]] select (GVAR(allowAdjust) == 1);
};

// Off-map check for non-manual modes: if the player passed off the map while it was closed, recenter it. Fudge factor here to avoid opening on the edge of the map, which isn't very helpful.
if (GVAR(allowAdjust) != 1 && {abs ((GVAR(centerPos) select 0) - (getPos player select 0)) + 150 > GVAR(pageWidth) || abs ((GVAR(centerPos) select 1) - (getPos player select 1)) + 150 > GVAR(pageHeight)}) then {
	   GVAR(centerPos) = getPos player;
};

// Center map on current centering position.
(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));

// Hide the unused map.
(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlShow true;
(FOLDMAP displayCtrl GVAR(mapCtrlInactive)) ctrlShow false;

// Place everything in position to be scrolled.
[0] call FUNC(moveMapOffscreen);

// Add per-frame draw handler to update the player marker and darken map.
if (GVAR(drawPaper)) then {
    // Darken paper map based on time. Based on ShackTac Map Brightness by zx64 & Dslyecxi. Draw a dark rectangle covering the map.
	   (FOLDMAP displayCtrl DAYMAP) ctrlAddEventHandler ["Draw", {
        (FOLDMAP displayCtrl DAYMAP) drawRectangle [((FOLDMAP displayCtrl DAYMAP) ctrlMapScreenToWorld [MAP_XPOS, MAP_YPOS]), GVAR(pageWidth) * 3, GVAR(pageHeight) * 3, 0, [0, 0, 0, (0.72 min (1 - sunOrMoon))], "#(rgb,1,1,1)color(0,0,0,1)"];
    }];
} else {
   	(FOLDMAP displayCtrl DAYMAP) ctrlAddEventHandler ["Draw", {
         if (GVAR(mapIcon) && {visibleGPS}) then {
             (FOLDMAP displayCtrl DAYMAP) drawIcon [getText(configFile >> "CfgMarkers" >> "mil_arrow2" >> "icon"), [0.06, 0.08, 0.06, 0.87], getPos player, 19, 25, direction vehicle player, "", false];
         };
    }];
   	(FOLDMAP displayCtrl NIGHTMAP) ctrlAddEventHandler ["Draw", {
        if (GVAR(mapIcon) && {visibleGPS}) then {
            (FOLDMAP displayCtrl NIGHTMAP) drawIcon [getText(configFile >> "CfgMarkers" >> "mil_arrow2" >> "icon"), [0.9, 0.9, 0.9, 0.8], getPos player, 19, 25, direction vehicle player, "", false];
        };
    }];
};
