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
 * [time] call tao_foldmap_fnc_moveMapOnscreen;
 *
 * Public: No
 */

params ["_time"];

private _mapPosY = MAP_YPOS;

(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlSetPosition [MAP_XPOS, _mapPosY];
(FOLDMAP displayCtrl BACKGROUND) ctrlSetPosition [BACK_XPOS, BACK_YPOS];
(FOLDMAP displayCtrl STATUSBAR) ctrlSetPosition [MAP_XPOS, _mapPosY - STATUS_YOFFSET];
(FOLDMAP displayCtrl STATUSRIGHT) ctrlSetPosition [MAP_XPOS, _mapPosY - STATUSTEXT_YOFFSET];
(FOLDMAP displayCtrl STATUSLEFT) ctrlSetPosition [MAP_XPOS, _mapPosY - STATUSTEXT_YOFFSET];

(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlCommit _time;
(FOLDMAP displayCtrl BACKGROUND) ctrlCommit _time;
(FOLDMAP displayCtrl STATUSBAR) ctrlCommit _time;
(FOLDMAP displayCtrl STATUSRIGHT) ctrlCommit _time;
(FOLDMAP displayCtrl STATUSLEFT) ctrlCommit _time;