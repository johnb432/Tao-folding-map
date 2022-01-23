#include "script_component.hpp"

/*
 * Author: johnb43
 * Does automatic tracking.
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Active map control <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, (uiNamespace getVariable ["tao_rewrite_main_foldmap", displayNull]) displayCtrl tao_rewrite_main_mapCtrlActive] call tao_rewrite_main_fnc_PFHautomatic;
 *
 * Public: No
 */

params ["_player", "_controlActiveMap"];

private _playerPos = getPosATL _player;
private _ctrlPos = ctrlPosition _controlActiveMap;
(_controlActiveMap ctrlMapWorldToScreen _playerPos) params ["_xPos", "_yPos"];

// If the player has gotten off the page somehow, re-center the map.
if (_xPos < MAP_XPOS - FUDGEFACTOR || {_yPos < MAP_YPOS - FUDGEFACTOR} || {_xPos > MAP_XPOS + (_ctrlPos select 2) + FUDGEFACTOR} || {_yPos > MAP_YPOS + (_ctrlPos select 3) + FUDGEFACTOR}) then {
    GVAR(centerPos) = _playerPos;
    _controlActiveMap ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
    ctrlMapAnimCommit _controlActiveMap;
};

GVAR(centerPos) params ["_oldX", "_oldY"];

// Deltas between player pos and map center pos.
private _deltaX = _oldX - (_playerPos select 0);
private _deltaY = _oldY - (_playerPos select 1);

// Prevent flickering along edges and ensure paging before too close.
private _pagingFudgeFactor = 80 * GVAR(mapScale) / GVAR(baseScale);

// Need to page left?
if (_deltaX > GVAR(pageWidth) / 2 - _pagingFudgeFactor) exitWith {
    GVAR(centerPos) set [0, _oldX - GVAR(pageWidth) + _pagingFudgeFactor * 2.2];
    _controlActiveMap ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
    ctrlMapAnimCommit _controlActiveMap;
};

// Need to page right?
if (_deltaX < -GVAR(pageWidth) / 2 + _pagingFudgeFactor) exitWith {
    GVAR(centerPos) set [0, _oldX + GVAR(pageWidth) - _pagingFudgeFactor * 2.2];
    _controlActiveMap ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
    ctrlMapAnimCommit _controlActiveMap;
};

// Need to page up?
if (_deltaY < -GVAR(pageHeight) / 2 + _pagingFudgeFactor) exitWith {
    GVAR(centerPos) set [1, _oldY + GVAR(pageHeight) - _pagingFudgeFactor * 2.2];
    _controlActiveMap ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
    ctrlMapAnimCommit _controlActiveMap;
};

// Need to page down?
if (_deltaY > GVAR(pageHeight) / 2 - _pagingFudgeFactor) exitWith {
    GVAR(centerPos) set [1, _oldY - GVAR(pageHeight) + _pagingFudgeFactor * 2.2];
    _controlActiveMap ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
    ctrlMapAnimCommit _controlActiveMap;
};
