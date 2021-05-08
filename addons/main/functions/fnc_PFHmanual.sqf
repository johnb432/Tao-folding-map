#include "script_component.hpp"
/*
 * Author: johnb43
 * Opens foldmap for the manual tracking mode and monitors it until receiving a signal to close (GVAR(doShow) == false).
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call tao_rewrite_main_fnc_PFHmanual;
 *
 * Public: No
 */

[{
    params ["_time", "_handleid"];

    if (!GVAR(enableMap) || {!GVAR(doShow)} || {visibleMap && GVAR(closeMap)} || {!(shownMap || shownGPS)} || {!(cameraView in GVAR(closeView))} || {!alive player}) exitWith {
        [_handleid] call CBA_fnc_removePerFrameHandler;
        // Scroll the map off the screen.
        [SCROLLTIME] call FUNC(moveMapOffscreen);
        // Destroy the rsc after waiting for it to be put away.
        [{ctrlCommitted (FOLDMAP displayCtrl GVAR(mapCtrlActive))}, {GVAR(mapRscLayer) cutText ["", "PLAIN"]}, [], -1, {}] call CBA_fnc_waitUntilAndExecute;
        // Map is now scrolled away and can be opened again.
        GVAR(isOpen) = false;
    };

    // Match background color to map darkening code if night.
    _color = 0.28 max (sunOrMoon);
    (FOLDMAP displayCtrl BACKGROUND) ctrlSetTextColor [_color, _color, _color, 1];

    // If in tablet mode, update the time on the tablet status bar. Paper map doesn't get a magic arrow.
    if (!GVAR(drawPaper)) then {
        (FOLDMAP displayCtrl STATUSRIGHT) ctrlSetText (format ["%1/%2/%3  %4  ||||||", date select 0, date select 1, date select 2, [dayTime] call BIS_fnc_timeToString]);

        // If setting "enable gridref" is enabled and a GPS panel is available, draw the grid reference on the status bar of the tablet.
        (FOLDMAP displayCtrl STATUSLEFT) ctrlSetText (["", format ["GRID %1", mapGridPosition player]] select (shownGPS && {GVAR(gridRef)}));
    };

    if (ctrlCommitted (FOLDMAP displayCtrl BACKGROUND) && {GVAR(allowShakeMap)}) then {
        // If the player is moving, shake the map back and forth a little.
        _velocity = vectorMagnitude velocity player;

        // On foot, running.
        if (isNull objectParent player && {_velocity > 2} && {time >= _time + SHAKETIME}) then {
            // Shake back and forth by flipping the value.
            GVAR(shake) = !GVAR(shake);

            // More shake at higher v
            _shakeMod = [0, safeZoneW * 0.005] select (_velocity > 4.8);

            _shakeX = [-(safeZoneW * 0.0014 + _shakeMod + random (safeZoneW * 0.002)), safeZoneW * 0.0015] select GVAR(shake);
            _shakeY = [safeZoneH * 0.0016 + _shakeMod + random (safeZoneW * 0.002), -safeZoneH * 0.0002] select GVAR(shake);

            // Do shake.
            (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlSetPosition [MAP_XPOS + _shakeX, MAP_YPOS + _shakeY];
            (FOLDMAP displayCtrl BACKGROUND) ctrlSetPosition [GVAR(backgroundXPos) + _shakeX, GVAR(backgroundYPos) + _shakeY];
            (FOLDMAP displayCtrl STATUSBAR) ctrlSetPosition [MAP_XPOS + _shakeX, MAP_YPOS - GVAR(statusYOffset) + _shakeY];
            (FOLDMAP displayCtrl STATUSRIGHT) ctrlSetPosition [MAP_XPOS + _shakeX , MAP_YPOS - GVAR(statusYOffset) + _shakeY];
            (FOLDMAP displayCtrl STATUSLEFT) ctrlSetPosition [MAP_XPOS + _shakeX, MAP_YPOS - GVAR(statusYOffset) + _shakeY];

            (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlCommit SHAKETIME;
            (FOLDMAP displayCtrl BACKGROUND) ctrlCommit SHAKETIME;
            (FOLDMAP displayCtrl STATUSBAR) ctrlCommit SHAKETIME;
            (FOLDMAP displayCtrl STATUSRIGHT) ctrlCommit SHAKETIME;
            (FOLDMAP displayCtrl STATUSLEFT) ctrlCommit SHAKETIME;

            _time = time;
        } else {
            // Restore map to neutral position.
            if ((ctrlPosition (FOLDMAP displayCtrl BACKGROUND)) select 0 isNotEqualTo GVAR(backgroundXPos)) then {
                [0.1] call FUNC(moveMapOnscreen);
            };
        };
    };

    // Update the delta number for map paging updates if needed.
    if (GVAR(needsScaleReset) || {isNil QGVAR(pageWidth)}) then {
        private _ctrlPos = ctrlPosition (FOLDMAP displayCtrl GVAR(mapCtrlActive));
        private _upperLeftCornerPos = (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapScreenToWorld [MAP_XPOS, MAP_YPOS];
        private _bottomRightCornerPos = (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapScreenToWorld [MAP_XPOS + (_ctrlPos select 2), MAP_YPOS + (_ctrlPos select 3)];

        // Compute page width and height (in meters on the map) for paging.
        GVAR(pageWidth) = abs ((_upperLeftCornerPos select 0) - (_bottomRightCornerPos select 0));
        GVAR(pageHeight) = abs ((_upperLeftCornerPos select 1) - (_bottomRightCornerPos select 1));
    };

    // Need to page left?
    if (GVAR(left)) then {
        GVAR(centerPos) set [0, (GVAR(centerPos) select 0) - GVAR(pageWidth) / 2 + 176 * GVAR(mapScale) / GVAR(baseScale)];
        (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
        ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));
        GVAR(left) = false;
    };

    // Need to page right?
    if (GVAR(right)) then {
        GVAR(centerPos) set [0, (GVAR(centerPos) select 0) + GVAR(pageWidth) / 2 - 176 * GVAR(mapScale) / GVAR(baseScale)];
        (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
        ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));
        GVAR(right) = false;
    };

    // Need to page up?
    if (GVAR(up)) then {
        GVAR(centerPos) set [1, (GVAR(centerPos) select 1) + GVAR(pageHeight) / 2 - 176 * GVAR(mapScale) / GVAR(baseScale)];
        (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
        ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));
        GVAR(up) = false;
    };

    // Need to page down?
    if (GVAR(down)) then {
        GVAR(centerPos) set [1, (GVAR(centerPos) select 1) - GVAR(pageHeight) / 2 + 176 * GVAR(mapScale) / GVAR(baseScale)];
        (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
        ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));
        GVAR(down) = false;
    };
}, GVAR(refreshRate), time] call CBA_fnc_addPerFrameHandler;
