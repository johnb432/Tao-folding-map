#include "script_component.hpp"
/*
 * Author: johnb43
 * Opens foldmap and monitors it until receiving a signal to close (GVAR(doShow) == false).
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call tao_rewrite_main_fnc_openFoldmap;
 *
 * Public: No
 */

// Exit if in an invalid state for foldmap to open or if map is already open.
if (!GVAR(enableMap) || {GVAR(isOpen)} || {!(cameraView in GVAR(closeView))} || {!alive player}) exitWith {};

// Initialize the dialog.
GVAR(isOpen) = true;
GVAR(mapRscLayer) cutRsc ["Tao_FoldMap","PLAIN", 0];

// Scroll up map and decorations.
[SCROLLTIME] call FUNC(moveMapOnscreen);

// Monitor and update map until closed.
GVAR(doShow) = true;

if (isNil QGVAR(shake)) then {
   	GVAR(shake) = false;
};

// Initialize shaking values.
private _time = time;
private _shakeX = 0;
private _shakeY = 0;
private _shakeMod = 0;
private _color = 0.28 max (sunOrMoon);
private _velocity = 0;

if (GVAR(allowAdjust) == 0) exitWith { //only adjusts when player gets off screen
    [{
        params ["_args", "_handleid"];
        _args params ["_time", "_shakeX", "_shakeY", "_shakeMod", "_color", "_velocity"];

       	if (!GVAR(enableMap) || {!GVAR(doShow)} || {visibleMap && GVAR(closeMap)} || {!(cameraView in GVAR(closeView))} || {!alive player}) exitWith {
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

       	// If in tablet mode, update the time on the tablet status bar.
        if (!GVAR(drawPaper)) then {
            (FOLDMAP displayCtrl STATUSRIGHT) ctrlSetText (format ["%1/%2/%3  %4:%5  ||||||", date select 0, date select 1, date select 2, date select 3, (if (date select 4 < 10) then { "0" } else { "" }) + str (date select 4)]);

            // If setting "enable gridref" is enabled and has a GPS open, draw the grid reference on the status bar of the tablet.
            if (visibleGPS && {GVAR(gridRef)}) then {
                (FOLDMAP displayCtrl STATUSLEFT) ctrlSetText (format ["GRID %1", mapGridPosition player]);
            } else {
                (FOLDMAP displayCtrl STATUSLEFT) ctrlSetText "";
            };
        };

        if (ctrlCommitted (FOLDMAP displayCtrl BACKGROUND) && GVAR(allowShake)) then {
            // If the player is moving, shake the map back and forth a little.
            _velocity = vectorMagnitude velocity player;

            // On foot, running.
            if (vehicle player == player && {_velocity > 2} && {time >= _time + SHAKETIME}) then {
                // Shake back and forth by flipping the value.
                GVAR(shake) = !GVAR(shake);

                if (_velocity > 4.8) then {
                    _shakeMod = SAFEZONE_W * 0.005; // More shake at higher v
                };

                if (GVAR(shake)) then {
                    _shakeX = SAFEZONE_W * 0.0015;
                    _shakeY = SAFEZONE_H * -0.0002;
                } else {
                    _shakeX = -(SAFEZONE_W * 0.0014 + _shakeMod + random (SAFEZONE_W * 0.002));
                    _shakeY = SAFEZONE_H * 0.0016 + _shakeMod + random (SAFEZONE_W * 0.002);
                };

                // Do shake.
                (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlSetPosition [MAP_XPOS + _shakeX, MAP_YPOS + _shakeY];
                (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlCommit SHAKETIME;
                (FOLDMAP displayCtrl BACKGROUND) ctrlSetPosition [BACK_XPOS + _shakeX, BACK_YPOS + _shakeY];
                (FOLDMAP displayCtrl BACKGROUND) ctrlCommit SHAKETIME;
                (FOLDMAP displayCtrl STATUSBAR) ctrlSetPosition [MAP_XPOS + _shakeX, MAP_YPOS - STATUS_YOFFSET + _shakeY];
                (FOLDMAP displayCtrl STATUSBAR) ctrlCommit SHAKETIME;
                (FOLDMAP displayCtrl STATUSRIGHT) ctrlSetPosition [MAP_XPOS + _shakeX , MAP_YPOS - STATUSTEXT_YOFFSET + _shakeY];
                (FOLDMAP displayCtrl STATUSRIGHT) ctrlCommit SHAKETIME;
                (FOLDMAP displayCtrl STATUSLEFT) ctrlSetPosition [MAP_XPOS + _shakeX, MAP_YPOS - STATUSTEXT_YOFFSET + _shakeY];
                (FOLDMAP displayCtrl STATUSLEFT) ctrlCommit SHAKETIME;

                _time = time;
            } else {
                // Restore map to neutral position.
                if ((ctrlPosition (FOLDMAP displayCtrl BACKGROUND)) select 0 != BACK_XPOS) then {
                    [0.1] call FUNC(moveMapOnscreen);
                };
            };
        };

       	// Update the delta number for map paging updates if needed.
       	if (GVAR(needsScaleReset) || {isNil QGVAR(pageWidth)}) then {
          		private _mapWidth = (ctrlPosition (FOLDMAP displayCtrl GVAR(mapCtrlActive))) select 2;
          		private _mapHeight = (ctrlPosition (FOLDMAP displayCtrl GVAR(mapCtrlActive))) select 3;

          		private _upperLeftCornerPos = (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapScreenToWorld [MAP_XPOS, MAP_YPOS];
          		private _bottomRightCornerPos = (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapScreenToWorld [MAP_XPOS + _mapWidth, MAP_YPOS + _mapHeight];

          		// Compute page width and height (in meters on the map) for paging.
          		GVAR(pageWidth) = abs ((_upperLeftCornerPos select 0) - (_bottomRightCornerPos select 0));
          		GVAR(pageHeight) = abs ((_upperLeftCornerPos select 1) - (_bottomRightCornerPos select 1));
       	};

        if (visibleGPS || {GVAR(GPSAdjust)}) then {
            // If the player has gotten off the page somehow, re-center the map.
            private _wts = (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapWorldToScreen getPos player;
            private _mapWidth = (ctrlPosition (FOLDMAP displayCtrl GVAR(mapCtrlActive))) select 2;
            private _mapHeight = (ctrlPosition (FOLDMAP displayCtrl GVAR(mapCtrlActive))) select 3;
            private _upperLeftCorner = [MAP_XPOS, MAP_YPOS];
            private _lowerRightCorner = [MAP_XPOS + _mapWidth, MAP_YPOS + _mapHeight];

            if (_wts select 0 < (_upperLeftCorner select 0) - FUDGEFACTOR || {_wts select 1 < (_upperLeftCorner select 1) - FUDGEFACTOR} || {_wts select 0 > (_lowerRightCorner select 0) + FUDGEFACTOR} || {_wts select 1 > (_lowerRightCorner select 1) + FUDGEFACTOR}) then {
                GVAR(centerPos) = getPos player;
                (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), [GVAR(centerPos) select 0, GVAR(centerPos) select 1, 0]];
                ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));
            };

            private _oldX = GVAR(centerPos) select 0;
            private _oldY = GVAR(centerPos) select 1;

            // Deltas between player pos and map center pos.
            private _deltaX = _oldX - (getPos player select 0);
            private _deltaY = _oldY - (getPos player select 1);

            // Prevent flickering along edges and ensure paging before too close.
            private _pagingFudgeFactor = 80 * GVAR(mapScale) / GVAR(baseScale);

            // Need to page left?
            if (_deltaX > GVAR(pageWidth) / 2 - _pagingFudgeFactor) exitWith {
                GVAR(centerPos) = [_oldX - GVAR(pageWidth) + _pagingFudgeFactor * 2.2, _oldY];
                (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
                ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));
            };

            // Need to page right?
            if (_deltaX < -GVAR(pageWidth) / 2 + _pagingFudgeFactor) exitWith {
                GVAR(centerPos) = [_oldX + GVAR(pageWidth) - _pagingFudgeFactor * 2.2, _oldY];
                (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
                ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));
            };

            // Need to page up?
            if (_deltaY < -GVAR(pageHeight) / 2 + _pagingFudgeFactor) exitWith {
                GVAR(centerPos) = [_oldX, _oldY + GVAR(pageHeight) - _pagingFudgeFactor * 2.2];
                (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
                ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));
            };

            // Need to page down?
            if (_deltaY > GVAR(pageHeight) / 2 - _pagingFudgeFactor) exitWith {
                GVAR(centerPos) = [_oldX, _oldY - GVAR(pageHeight) + _pagingFudgeFactor * 2.2];
                (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
                ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));
            };
        };
    }, 0, [_time, _shakeX, _shakeY, _shakeMod, _color, _velocity]] call CBA_fnc_addPerFrameHandler;
};


if (GVAR(allowAdjust) == 1) exitWith { //needs to be manually adjusted
    [{
        params ["_args", "_handleid"];
        _args params ["_time", "_shakeX", "_shakeY", "_shakeMod", "_color", "_velocity"];

       	if (!GVAR(enableMap) || {!GVAR(doShow)} || {visibleMap && GVAR(closeMap)} || {!(cameraView in GVAR(closeView))} || {!alive player}) exitWith {
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

       	// If in tablet mode, update the time on the tablet status bar.
        if (!GVAR(drawPaper)) then {
            (FOLDMAP displayCtrl STATUSRIGHT) ctrlSetText (format ["%1/%2/%3  %4:%5  ||||||", date select 0, date select 1, date select 2, date select 3, (if (date select 4 < 10) then { "0" } else { "" }) + str (date select 4)]);

            // If setting "enable gridref" is enabled and has a GPS open, draw the grid reference on the status bar of the tablet.
            if (visibleGPS && {GVAR(gridRef)}) then {
                (FOLDMAP displayCtrl STATUSLEFT) ctrlSetText (format ["GRID %1", mapGridPosition player]);
            } else {
                (FOLDMAP displayCtrl STATUSLEFT) ctrlSetText "";
            };
        };

        if (ctrlCommitted (FOLDMAP displayCtrl BACKGROUND) && GVAR(allowShake)) then {
            // If the player is moving, shake the map back and forth a little.
            _velocity = vectorMagnitude velocity player;

            // On foot, running.
            if (vehicle player == player && {_velocity > 2} && {time >= _time + SHAKETIME}) then {
                // Shake back and forth by flipping the value.
                GVAR(shake) = !GVAR(shake);

                if (_velocity > 4.8) then {
                    _shakeMod = SAFEZONE_W * 0.005; // More shake at higher v
                };

                if (GVAR(shake)) then {
                    _shakeX = SAFEZONE_W * 0.0015;
                    _shakeY = SAFEZONE_H * -0.0002;
                } else {
                    _shakeX = -(SAFEZONE_W * 0.0014 + _shakeMod + random (SAFEZONE_W * 0.002));
                    _shakeY = SAFEZONE_H * 0.0016 + _shakeMod + random (SAFEZONE_W * 0.002);
                };

                // Do shake.
                (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlSetPosition [MAP_XPOS + _shakeX, MAP_YPOS + _shakeY];
                (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlCommit SHAKETIME;
                (FOLDMAP displayCtrl BACKGROUND) ctrlSetPosition [BACK_XPOS + _shakeX, BACK_YPOS + _shakeY];
                (FOLDMAP displayCtrl BACKGROUND) ctrlCommit SHAKETIME;
                (FOLDMAP displayCtrl STATUSBAR) ctrlSetPosition [MAP_XPOS + _shakeX, MAP_YPOS - STATUS_YOFFSET + _shakeY];
                (FOLDMAP displayCtrl STATUSBAR) ctrlCommit SHAKETIME;
                (FOLDMAP displayCtrl STATUSRIGHT) ctrlSetPosition [MAP_XPOS + _shakeX , MAP_YPOS - STATUSTEXT_YOFFSET + _shakeY];
                (FOLDMAP displayCtrl STATUSRIGHT) ctrlCommit SHAKETIME;
                (FOLDMAP displayCtrl STATUSLEFT) ctrlSetPosition [MAP_XPOS + _shakeX, MAP_YPOS - STATUSTEXT_YOFFSET + _shakeY];
                (FOLDMAP displayCtrl STATUSLEFT) ctrlCommit SHAKETIME;

                _time = time;
            } else {
                // Restore map to neutral position.
                if ((ctrlPosition (FOLDMAP displayCtrl BACKGROUND)) select 0 != BACK_XPOS) then {
                    [0.1] call FUNC(moveMapOnscreen);
                };
            };
        };

       	// Update the delta number for map paging updates if needed.
       	if (GVAR(needsScaleReset) || {isNil QGVAR(pageWidth)}) then {
          		private _mapWidth = (ctrlPosition (FOLDMAP displayCtrl GVAR(mapCtrlActive))) select 2;
          		private _mapHeight = (ctrlPosition (FOLDMAP displayCtrl GVAR(mapCtrlActive))) select 3;

          		private _upperLeftCornerPos = (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapScreenToWorld [MAP_XPOS, MAP_YPOS];
          		private _bottomRightCornerPos = (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapScreenToWorld [MAP_XPOS + _mapWidth, MAP_YPOS + _mapHeight];

          		// Compute page width and height (in meters on the map) for paging.
          		GVAR(pageWidth) = abs ((_upperLeftCornerPos select 0) - (_bottomRightCornerPos select 0));
          		GVAR(pageHeight) = abs ((_upperLeftCornerPos select 1) - (_bottomRightCornerPos select 1));
       	};

      		// Need to page left?
      		if (GVAR(left)) exitWith {
         			GVAR(centerPos) = [(GVAR(centerPos) select 0) - GVAR(pageWidth) / 2 + 176 * GVAR(mapScale) / GVAR(baseScale), GVAR(centerPos) select 1];
         			(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
         			ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));
         			GVAR(left) = false;
      		};

      		// Need to page right?
      		if (GVAR(right)) exitWith {
         			GVAR(centerPos) = [(GVAR(centerPos) select 0) + GVAR(pageWidth) / 2 - 176 * GVAR(mapScale) / GVAR(baseScale), GVAR(centerPos) select 1];
         			(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
         			ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));
         			GVAR(right) = false;
      		};

      		// Need to page up?
      		if (GVAR(up)) exitWith {
         			GVAR(centerPos) = [GVAR(centerPos) select 0, (GVAR(centerPos) select 1) + GVAR(pageHeight) / 2 - 176 * GVAR(mapScale) / GVAR(baseScale)];
         			(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
         			ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));
         			GVAR(up) = false;
      		};

      		// Need to page down?
      		if (GVAR(down)) exitWith {
         			GVAR(centerPos) = [GVAR(centerPos) select 0, (GVAR(centerPos) select 1) - GVAR(pageHeight) / 2 + 176 * GVAR(mapScale) / GVAR(baseScale)];
         			(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
         			ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));
         			GVAR(down) = false;
      		};
    }, 0, [_time, _shakeX, _shakeY, _shakeMod, _color, _velocity]] call CBA_fnc_addPerFrameHandler;
};


if (GVAR(allowAdjust) == 2) exitWith { //always centers player
    private _pos = getPos player;
    [{
        params ["_args", "_handleid"];
        _args params ["_time", "_shakeX", "_shakeY", "_shakeMod", "_color", "_velocity", "_pos"];

        if (!GVAR(enableMap) || {!GVAR(doShow)} || {visibleMap && GVAR(closeMap)} || {!(cameraView in GVAR(closeView))} || {!alive player}) exitWith {
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

       	// If in tablet mode, update the time on the tablet status bar.
        if (!GVAR(drawPaper)) then {
            (FOLDMAP displayCtrl STATUSRIGHT) ctrlSetText (format ["%1/%2/%3  %4:%5  ||||||", date select 0, date select 1, date select 2, date select 3, (if (date select 4 < 10) then { "0" } else { "" }) + str (date select 4)]);

            // If setting "enable gridref" is enabled and has a GPS open, draw the grid reference on the status bar of the tablet.
            if (visibleGPS && {GVAR(gridRef)}) then {
                (FOLDMAP displayCtrl STATUSLEFT) ctrlSetText (format ["GRID %1", mapGridPosition player]);
            } else {
                (FOLDMAP displayCtrl STATUSLEFT) ctrlSetText "";
            };
        };

       	if (ctrlCommitted (FOLDMAP displayCtrl BACKGROUND) && GVAR(allowShake)) then {
          		// If the player is moving, shake the map back and forth a little.
          		_velocity = vectorMagnitude velocity player;

          		// On foot, running.
          		if (vehicle player == player && {_velocity > 2} && {time >= _time + SHAKETIME}) then {
             			// Shake back and forth by flipping the value.
             			GVAR(shake) = !GVAR(shake);

             			if (_velocity > 4.8) then {
             				   _shakeMod = SAFEZONE_W * 0.005; // More shake at higher v
             			};

            				if (GVAR(shake)) then {
               					_shakeX = SAFEZONE_W * 0.0015;
               					_shakeY = -SAFEZONE_H * 0.0002;
            				} else {
               					_shakeX = -(SAFEZONE_W * 0.0014 + _shakeMod + random (SAFEZONE_W * 0.002));
               					_shakeY = SAFEZONE_H * 0.0016 + _shakeMod + random (SAFEZONE_W * 0.002);
            				};

             			// Do shake.
             			(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlSetPosition [MAP_XPOS + _shakeX, MAP_YPOS + _shakeY];
             			(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlCommit SHAKETIME;
             			(FOLDMAP displayCtrl BACKGROUND) ctrlSetPosition [BACK_XPOS + _shakeX, BACK_YPOS + _shakeY];
             			(FOLDMAP displayCtrl BACKGROUND) ctrlCommit SHAKETIME;
             			(FOLDMAP displayCtrl STATUSBAR) ctrlSetPosition [MAP_XPOS + _shakeX, MAP_YPOS - STATUS_YOFFSET + _shakeY];
             			(FOLDMAP displayCtrl STATUSBAR) ctrlCommit SHAKETIME;
             			(FOLDMAP displayCtrl STATUSRIGHT) ctrlSetPosition [MAP_XPOS + _shakeX , MAP_YPOS - STATUSTEXT_YOFFSET + _shakeY];
             			(FOLDMAP displayCtrl STATUSRIGHT) ctrlCommit SHAKETIME;
             			(FOLDMAP displayCtrl STATUSLEFT) ctrlSetPosition [MAP_XPOS + _shakeX, MAP_YPOS - STATUSTEXT_YOFFSET + _shakeY];
             			(FOLDMAP displayCtrl STATUSLEFT) ctrlCommit SHAKETIME;

             			_time = time;
          		} else {
             			// Restore map to neutral position.
             			if ((ctrlPosition (FOLDMAP displayCtrl BACKGROUND)) select 0 != BACK_XPOS) then {
             				   [0.1] call FUNC(moveMapOnscreen);
             			};
          		};
       	};

       	// Update the delta number for map paging updates if needed.
       	if (GVAR(needsScaleReset) || {isNil QGVAR(pageWidth)}) then {
          		private _mapWidth = (ctrlPosition (FOLDMAP displayCtrl GVAR(mapCtrlActive))) select 2;
          		private _mapHeight = (ctrlPosition (FOLDMAP displayCtrl GVAR(mapCtrlActive))) select 3;

          		private _upperLeftCornerPos = (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapScreenToWorld [MAP_XPOS, MAP_YPOS];
          		private _bottomRightCornerPos = (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapScreenToWorld [MAP_XPOS + _mapWidth, MAP_YPOS + _mapHeight];

          		// Compute page width and height (in meters on the map) for paging.
          		GVAR(pageWidth) = abs ((_upperLeftCornerPos select 0) - (_bottomRightCornerPos select 0));
          		GVAR(pageHeight) = abs ((_upperLeftCornerPos select 1) - (_bottomRightCornerPos select 1));
       	};

        if (visibleGPS || {GVAR(GPSAdjust)}) then {
            _pos = getPos player;
            (FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), [_pos select 0, _pos select 1, 0]];
            ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));
            GVAR(centerPos) = [_pos select 0, _pos select 1];
        };
    }, 0, [_time, _shakeX, _shakeY, _shakeMod, _color, _velocity, _pos]] call CBA_fnc_addPerFrameHandler;
};
