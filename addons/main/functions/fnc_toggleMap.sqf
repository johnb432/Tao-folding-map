#include "script_component.hpp"

/*
 * Author: johnb43
 * Toggle the folding map open and closed.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call tao_rewrite_main_fnc_toggleMap;
 *
 * Public: No
 */

// Don't turn on map if CBA settings not initialised
if !(GETMVAR("CBA_settings_ready",false)) exitWith {
    WARNING("CBA settings not initialised yet!");
};

if (!GVAR(isOpen)) then {
    private _player = call CBA_fnc_currentUnit;
    GVAR(hasGPS) = _player call FUNC(findGPS);

    // Exit if in an invalid state for foldmap to open
    if (!GVAR(enableMap) || {GVAR(closeMap) && {visibleMap}} || {GVAR(requireMapForPaperMap) && {GVAR(drawPaper)} && {!shownMap}} || {GVAR(requireGPSForTablet) && {!GVAR(drawPaper)} && {!GVAR(hasGPS)}} || {!(cameraView in GVAR(closeView))} || {!alive _player}) exitWith {};

    call FUNC(openFoldmap);

    // Best wait 2 frames
    {
        {
            // If CLib is present, register this as a map
            if (!isNil "CLib_fnc_registerMapControl") then {
                (FOLDMAP displayCtrl GVAR(mapCtrlActive)) call CLib_fnc_registerMapControl;
            };

            // If FKFramework is present, tell it to rebuild all markers
            if (!isNil "fkf_groupMarkers_fnc_addMarker") then {
                "fkf_groupMarkers_rebuildMarkers" call CLib_fnc_localEvent;
            };
        } call CBA_fnc_execNextFrame;
    } call CBA_fnc_execNextFrame;
} else {
    GVAR(doShow) = false;
};
