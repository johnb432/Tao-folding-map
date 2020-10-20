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

// Determine if it's day or night so we can use the correct map (tablet only).
GVAR(mapCtrlActive) = DAYMAP;
GVAR(mapCtrlInactive) = NIGHTMAP;

if (!GVAR(drawPaper) && {GVAR(isNightMap)}) then {
	GVAR(mapCtrlActive) = NIGHTMAP;
	GVAR(mapCtrlInactive) = DAYMAP;
};

// On first run, get the center pos. This is used for all paging thereafter.
if (isNil QUOTE(GVAR(centerPos))) then {
	if (GVAR(allowadjust) == 1) then {
		GVAR(centerPos) = [worldSize / 2, worldSize / 2];
	} else {
		GVAR(centerPos) = getPos player;
	};
};

if (GVAR(allowadjust) != 1) then {
	// Off-map check: if the player passed off the map while it was closed, recenter it.
	private _dX = abs ((GVAR(centerPos) select 0) - (getPos player select 0));
	private _dY = abs ((GVAR(centerPos) select 1) - (getPos player select 1));

	// Fudge factor here to avoid opening on the edge of the map, which isn't very helpful.
	if (_dX + 150 > GVAR(pageWidth) || _dY + 150 > GVAR(pageHeight)) then {
		GVAR(centerPos) = getPos player;
	};
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
	(FOLDMAP displayCtrl DAYMAP) ctrlAddEventHandler ["Draw", QUOTE(call FUNC(drawUpdatePaper))];
} else {
	(FOLDMAP displayCtrl DAYMAP) ctrlAddEventHandler ["Draw", QUOTE(call FUNC(drawUpdateTablet))];
	(FOLDMAP displayCtrl NIGHTMAP) ctrlAddEventHandler ["Draw", QUOTE(call FUNC(drawUpdateTablet))];
};
