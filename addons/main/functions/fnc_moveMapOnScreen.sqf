#include "script_component.hpp"
/*
 * Author: johnb43
 * Move the map to its displayed position in time.
 *
 * Arguments:
 * 0: Time duration of animation <INTEGER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [2] call tao_foldmap_fnc_moveMapOnscreen;
 *
 * Public: No
 */

params ["_time"];

// If the UI needs to be calculated due to scale change
if (MAP_SIZE isNotEqualTo GVAR(mapScaleResize)) then {
    call FUNC(calcPosUI);
};

// Rescale minimap elements, except map due to bugginess
(FOLDMAP displayCtrl BACKGROUND) ctrlSetScale GVAR(mapScaleResize);
(FOLDMAP displayCtrl STATUSBAR) ctrlSetScale GVAR(mapScaleResize);
(FOLDMAP displayCtrl STATUSRIGHT) ctrlSetScale GVAR(mapScaleResize);
(FOLDMAP displayCtrl STATUSLEFT) ctrlSetScale GVAR(mapScaleResize);

(FOLDMAP displayCtrl BACKGROUND) ctrlCommit 0;
(FOLDMAP displayCtrl STATUSBAR) ctrlCommit 0;
(FOLDMAP displayCtrl STATUSRIGHT) ctrlCommit 0;
(FOLDMAP displayCtrl STATUSLEFT) ctrlCommit 0;

// Set position of minimap
private _mapPosY = MAP_YPOS - GVAR(statusYOffset);

(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlSetPosition [MAP_XPOS, MAP_YPOS];
(FOLDMAP displayCtrl BACKGROUND) ctrlSetPosition [GVAR(backgroundXPos), GVAR(backgroundYPos)];
(FOLDMAP displayCtrl STATUSBAR) ctrlSetPosition [MAP_XPOS, _mapPosY];
(FOLDMAP displayCtrl STATUSRIGHT) ctrlSetPosition [MAP_XPOS, _mapPosY];
(FOLDMAP displayCtrl STATUSLEFT) ctrlSetPosition [MAP_XPOS, _mapPosY];

(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlCommit _time;
(FOLDMAP displayCtrl BACKGROUND) ctrlCommit _time;
(FOLDMAP displayCtrl STATUSBAR) ctrlCommit _time;
(FOLDMAP displayCtrl STATUSRIGHT) ctrlCommit _time;
(FOLDMAP displayCtrl STATUSLEFT) ctrlCommit _time;
