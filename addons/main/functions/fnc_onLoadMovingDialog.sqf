#include "script_component.hpp"
/*
 * Author: johnb43
 * onLoad function for the MoveMe dialog.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call tao_rewrite_main_fnc_onLoadMovingDialog;
 *
 * Public: No
 */

// Put the Moving Dialog right on top of the existing map.
private _width = (ctrlPosition (MOVEME displayCtrl 10)) select 2;
private _height = (ctrlPosition (MOVEME displayCtrl 10)) select 3;

(MOVEME displayCtrl 10) ctrlSetPosition [MAP_XPOS, MAP_YPOS];
(MOVEME displayCtrl 11) ctrlSetPosition [MAP_XPOS, MAP_YPOS];
(MOVEME displayCtrl 12) ctrlSetPosition [MAP_XPOS + (_width / 4), MAP_YPOS + (_height / 8)];

(MOVEME displayCtrl 10) ctrlCommit 0;
(MOVEME displayCtrl 11) ctrlCommit 0;
(MOVEME displayCtrl 12) ctrlCommit 0;
