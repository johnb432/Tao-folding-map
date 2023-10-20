#include "..\script_component.hpp"

/*
 * Author: johnb43
 * onLoad function for foldmap dialog.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * call tao_rewrite_main_fnc_onLoadDialog;
 *
 * Public: No
 */

// Set main control
SETUVAR(QGVAR(foldMap),_this);

// Set active map
GVAR(mapCtrlActive) = [IDC_DAYMAP, IDC_NIGHTMAP] select (!GVAR(drawPaper) && {GVAR(nightMap)});
GVAR(mapCtrlInactive) = [IDC_NIGHTMAP, IDC_DAYMAP] select (!GVAR(drawPaper) && {GVAR(nightMap)});

private _controlGroup = _this displayCtrl IDC_GROUP;
private _controlBackground = _this displayCtrl IDC_BACKGROUND;
private _controlStatusbar = _this displayCtrl IDC_STATUSBAR;
private _controlStatusbarRight = _this displayCtrl IDC_STATUSRIGHT;
private _controlStatusbarLeft = _this displayCtrl IDC_STATUSLEFT;
private _controlActiveMap = _this displayCtrl GVAR(mapCtrlActive);
private _controlInactiveMap = _this displayCtrl GVAR(mapCtrlInactive);

private _player = call CBA_fnc_currentUnit;
GVAR(hasGPS) = _player call FUNC(findGPS);

// Change to paper map if wanted
if (GVAR(drawPaper)) then {
    // Change to paper background
    _controlBackground ctrlSetText QPATHTOF(ui\paper.paa);

    // Hide the status bar
    _controlStatusbar ctrlShow false;
    _controlStatusbarRight ctrlShow false;
    _controlStatusbarLeft ctrlShow false;
};

private _posATL = getPosATL _player;

// On first run, get the center pos; This is used for all paging thereafter
if (isNil QGVAR(centerPos)) then {
    GVAR(centerPos) = [[worldSize / 2, worldSize / 2, 0], _posATL] select (GVAR(adjustMode) != 1 && (GVAR(hasGPS) || {!GVAR(GPSAdjust)}));
};

// Off-map check for non-manual modes: If the player passed off the map while it was closed, recenter it; Fudge factor here to avoid opening on the edge of the map, which isn't very helpful
if (GVAR(adjustMode) != MANUAL && {GVAR(hasGPS) || !GVAR(GPSAdjust)} && {abs ((GVAR(centerPos) select 0) - (_posATL select 0)) + 150 > GVAR(pageWidth) || abs ((GVAR(centerPos) select 1) - (_posATL select 1)) + 150 > GVAR(pageHeight)}) then {
    GVAR(centerPos) = _posATL;
};

// Center map on current centering position
_controlActiveMap ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
ctrlMapAnimCommit _controlActiveMap;

// Set group position
_controlGroup ctrlSetPosition [MAP_XPOS, MAP_YPOS, MAP_WIDTH, MAP_HEIGHT];

private _scale = SCALE;

// Set scales; Does not work on map controls
_controlGroup ctrlSetScale _scale;
_controlBackground ctrlSetScale _scale;
_controlStatusbar ctrlSetScale _scale;
_controlStatusbarRight ctrlSetScale _scale;
_controlStatusbarLeft ctrlSetScale _scale;

// Set position, size and scale of all controls
_controlStatusbar ctrlSetPosition [POS_X(6.45) + pixelW * OFFSET_X * (_scale - 1), POS_Y(0.72) + pixelH * OFFSET_Y_TABLET * (_scale - 1)];
_controlStatusbarRight ctrlSetPosition [POS_X(6.45) + pixelW * OFFSET_X * (_scale - 1), POS_Y(0.72) + pixelH * OFFSET_Y_TABLET * (_scale - 1)];
_controlStatusbarLeft ctrlSetPosition [POS_X(6.45) + pixelW * OFFSET_X * (_scale - 1), POS_Y(0.72) + pixelH * OFFSET_Y_TABLET * (_scale - 1)];

// Set font height
_controlStatusbarRight ctrlSetFontHeight (0.02 * sqrt _scale);
_controlStatusbarLeft ctrlSetFontHeight (0.02 * sqrt _scale);

_controlGroup ctrlCommit 0;
_controlBackground ctrlCommit 0;
_controlStatusbar ctrlCommit 0;
_controlStatusbarRight ctrlCommit 0;
_controlStatusbarLeft ctrlCommit 0;

// Set map position once it get in place
(ctrlPosition _controlStatusbar) params ["", "", "_width", "_height"];
_controlActiveMap ctrlMapSetPosition [
    POS_X(6.45) + pixelW * OFFSET_X * (_scale - 1),
    POS_Y(1.42) + (_height + pixelH * ([OFFSET_Y_TABLET, OFFSET_Y_PAPER] select GVAR(drawPaper))) * (_scale - 1),
    _width * _scale,
    _width * _scale * RATIO_H_W_MAP
];
_controlInactiveMap ctrlMapSetPosition [
    POS_X(6.45) + pixelW * OFFSET_X * (_scale - 1),
    POS_Y(1.42) + (_height + pixelH * ([OFFSET_Y_TABLET, OFFSET_Y_PAPER] select GVAR(drawPaper))) * (_scale - 1),
    _width * _scale,
    _width * _scale * RATIO_H_W_MAP
];

// Hide the unused map
_controlInactiveMap ctrlShow false;

// Add per-frame draw handler to update the player marker and darken map
if (GVAR(drawPaper)) then {
    if (!GVAR(allowPaperMapDarkening)) exitWith {};

    // Darken paper map based on time. Based on ShackTac Map Brightness by zx64 & Dslyecxi. Draw a dark rectangle covering the map
    (_this displayCtrl IDC_DAYMAP) ctrlAddEventHandler ["Draw", {
        params ["_mapControl"];

        private _player = call CBA_fnc_currentUnit;

        if (isNil QGVAR(pageWidth) || {isNil QGVAR(pageHeight)} || {!alive _player}) exitWith {
            _mapControl ctrlRemoveEventHandler [_thisEvent, _thisEventHandler];
        };

        // Script by Dystopian for the ACE3 mod https://github.com/acemod/ACE3/blob/master/addons/map/functions/fnc_determineMapLight.sqf
        (getLightingAt _player) params ["_ambientLightColor", "_ambientLightBrightness", "_dynamicLightColor", "_dynamicLightBrightness"];

        private _brightness = _ambientLightBrightness + _dynamicLightBrightness;
        private _lighting = if (_brightness > 3000) then {
            GVAR(lighting) = [1, 1, 1, 1];
            [1, 1, 1, 0]
        } else {
            private _alpha = switch (true) do {
                case (_brightness <= 0.2):  {1};
                case (_brightness <= 2):    {linearConversion [0.2, 2, _brightness, 1, 0.86]};
                case (_brightness <= 10):   {linearConversion [2, 10, _brightness, 0.86, 0.6]};
                case (_brightness <= 100):  {linearConversion [10, 100, _brightness, 0.6, 0.3]};
                case (_brightness <= 200):  {linearConversion [100, 200, _brightness, 0.3, 0.14]};
                default                     {linearConversion [200, 3000, _brightness, 0.14, 0]};
            };

            private _finalLightColorMap = [];
            private _finalLightColorBackground = [];
            private _finalColor = 0;

            _alpha = _alpha min 0.92;

            {
                _finalColor = (_ambientLightBrightness * _x + _dynamicLightBrightness * (_dynamicLightColor select _forEachIndex)) / _brightness;

                if (_alpha > 0.5) then {
                    _finalColor = _finalColor * (1 - _alpha) / 3;
                };

                _finalLightColorMap pushBack _finalColor;
            } forEach _ambientLightColor;

            private _color = 1 - _alpha;
            GVAR(lighting) = [_color, _color, _color, 1];

            _finalLightColorMap pushBack _alpha;

            _finalLightColorMap
        };

        _mapControl drawRectangle [_mapControl ctrlMapScreenToWorld [MAP_XPOS, MAP_YPOS], GVAR(pageWidth) * 3, GVAR(pageHeight) * 3, 0, _lighting, "#(rgb,1,1,1)color(0,0,0,1)"];
    }];
} else {
    // Draw map icon
    (_this displayCtrl IDC_DAYMAP) ctrlAddEventHandler ["Draw", {
        if (GVAR(mapIcon) && {GVAR(hasGPS) || !GVAR(requireGPSmapIcon)}) then {
            private _player = call CBA_fnc_currentUnit;
            (_this select 0) drawIcon [getText (configFile >> "CfgMarkers" >> "mil_arrow2" >> "icon"), [0.06, 0.08, 0.06, 0.87], getPosATL _player, 19, 25, direction vehicle _player, "", false];
        };
    }];

    (_this displayCtrl IDC_NIGHTMAP) ctrlAddEventHandler ["Draw", {
        if (GVAR(mapIcon) && {GVAR(hasGPS) || !GVAR(requireGPSmapIcon)}) then {
            private _player = call CBA_fnc_currentUnit;
            (_this select 0) drawIcon [getText (configFile >> "CfgMarkers" >> "mil_arrow2" >> "icon"), [0.9, 0.9, 0.9, 0.8], getPosATL _player, 19, 25, direction vehicle _player, "", false];
        };
    }];
};
