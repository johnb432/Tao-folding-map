#include "..\script_component.hpp"

/*
 * Author: johnb43
 * Toggle the map's nightvision view (if using tablet map).
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call tao_rewrite_main_fnc_toggleNvMode;
 *
 * Public: No
 */

GVAR(mapCtrlActive) = [IDC_DAYMAP, IDC_NIGHTMAP] select (!GVAR(drawPaper) && {GVAR(nightMap)});
GVAR(mapCtrlInactive) = [IDC_NIGHTMAP, IDC_DAYMAP] select (!GVAR(drawPaper) && {GVAR(nightMap)});

private _foldmap = FOLDMAP;
private _controlActiveMap = _foldmap displayCtrl GVAR(mapCtrlActive);
private _controlInactiveMap = _foldmap displayCtrl GVAR(mapCtrlInactive);

// Give new map the scale/centering properties of the old map
_controlActiveMap ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
ctrlMapAnimCommit _controlActiveMap;

// Show the new map
_controlActiveMap ctrlMapSetPosition (ctrlMapPosition _controlInactiveMap);
_controlActiveMap ctrlShow true;

// Hide the old map
_controlInactiveMap ctrlShow false;

// 'Refolds' the map to recenter it
if (GVAR(adjustMode) == AUTOMATIC && {GVAR(hasGPS) || {!GVAR(GPSAdjust)}}) then {
    GVAR(centerPos) = getPosATL (call CBA_fnc_currentUnit);
    _controlActiveMap ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
    ctrlMapAnimCommit _controlActiveMap;
};
