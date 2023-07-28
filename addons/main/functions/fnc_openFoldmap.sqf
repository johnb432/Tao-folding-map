#include "script_component.hpp"

/*
 * Author: johnb43
 * Opens map if possible.
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

// Initialize the dialog; This calls FUNC(onLoadDialog)
QGVAR(mapRscLayer) cutRsc [QGVAR(foldMap), "PLAIN"];

// Monitor and update map until closed
GVAR(isOpen) = true;
GVAR(doShow) = true;

// Open map
[{
    private _player = call CBA_fnc_currentUnit;
    GVAR(hasGPS) = _player call FUNC(findGPS);

    if (!GVAR(enableMap) || {!GVAR(doShow)} || {GVAR(closeMap) && {visibleMap}} || {GVAR(requireMapForPaperMap) && {GVAR(drawPaper)} && {!shownMap}} || {GVAR(requireGPSForTablet) && {!GVAR(drawPaper)} && {!GVAR(hasGPS)}} || {!(cameraView in GVAR(closeView))} || {!alive _player}) exitWith {
        (_this select 1) call CBA_fnc_removePerFrameHandler;

        // Destroy the rsc
        QGVAR(mapRscLayer) cutText ["", "PLAIN"];

        // Map is gone and can be opened again
        GVAR(isOpen) = false;
    };

    private _foldMap = FOLDMAP;

    // Match background color to map darkening code
    if (GVAR(allowPaperMapDarkening)) then {
        (_foldMap displayCtrl IDC_BACKGROUND) ctrlSetTextColor GVAR(lighting);
    };

    // If in tablet mode, update the time on the tablet status bar; Paper map doesn't get a magic arrow
    if (!GVAR(drawPaper)) then {
        private _date = date;
        (_foldMap displayCtrl IDC_STATUSRIGHT) ctrlSetText (format ["%1  %2/%3/%4  ||||||", dayTime call BIS_fnc_timeToString, _date select 0, _date select 1, _date select 2]);

        // If setting "enable gridref" is enabled and a GPS panel is available, draw the grid reference on the status bar of the tablet
        (_foldMap displayCtrl IDC_STATUSLEFT) ctrlSetText (["", format ["GRID %1", mapGridPosition _player]] select (GVAR(gridRef) && {GVAR(hasGPS) || (!GVAR(requireGPSForGridRef) && {!GVAR(GPSAdjust)})}));
    };

    private _controlActiveMap = _foldMap displayCtrl GVAR(mapCtrlActive);

    // Update the delta number for map paging updates if needed
    private _ctrlPos = ctrlPosition _controlActiveMap;
    private _upperLeftCornerPos = _controlActiveMap ctrlMapScreenToWorld [MAP_XPOS, MAP_YPOS];
    private _bottomRightCornerPos = _controlActiveMap ctrlMapScreenToWorld [MAP_XPOS + (_ctrlPos select 2), MAP_YPOS + (_ctrlPos select 3)];

    // Compute page width and height (in meters on the map) for paging
    GVAR(pageWidth) = abs ((_upperLeftCornerPos select 0) - (_bottomRightCornerPos select 0));
    GVAR(pageHeight) = abs ((_upperLeftCornerPos select 1) - (_bottomRightCornerPos select 1));

    // Open the variations
    if (GVAR(adjustMode) == AUTOMATIC && {GVAR(hasGPS) || !GVAR(GPSAdjust)}) exitWith {
        [_player, _controlActiveMap] call FUNC(PFHautomatic);
    };

    if (GVAR(adjustMode) == CENTERED && {GVAR(hasGPS) || !GVAR(GPSAdjust)}) exitWith {
        GVAR(centerPos) = getPosATL _player;
        _controlActiveMap ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
        ctrlMapAnimCommit _controlActiveMap;
    };

    if (GVAR(adjustMode) == MANUAL) exitWith {
        _controlActiveMap call FUNC(PFHmanual);
    };
}, GVAR(refreshRate)] call CBA_fnc_addPerFrameHandler;
