#include "script_component.hpp"
/*
 * Author: johnb43
 * Move the map off screen in time.
 *
 * Arguments:
 * 0: Time duration of animation <INTEGER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [2] call tao_foldmap_fnc_moveMapOffscreen;
 *
 * Public: No
 */

params ["_time"];

private _mapPosY = GVAR(backgroundYPos) - MAP_YPOS;
private _statusPosY = safeZoneH - GVAR(statusTextYOffset) - _mapPosY;

(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlSetPosition [MAP_XPOS, safeZoneH - _mapPosY];
(FOLDMAP displayCtrl BACKGROUND) ctrlSetPosition [GVAR(backgroundXPos), safeZoneH];
(FOLDMAP displayCtrl STATUSBAR) ctrlSetPosition [MAP_XPOS, _statusPosY];
(FOLDMAP displayCtrl STATUSRIGHT) ctrlSetPosition [MAP_XPOS, _statusPosY];
(FOLDMAP displayCtrl STATUSLEFT) ctrlSetPosition [MAP_XPOS, _statusPosY];

(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlCommit _time;
(FOLDMAP displayCtrl BACKGROUND) ctrlCommit _time;
(FOLDMAP displayCtrl STATUSBAR) ctrlCommit _time;
(FOLDMAP displayCtrl STATUSRIGHT) ctrlCommit _time;
(FOLDMAP displayCtrl STATUSLEFT) ctrlCommit _time;
