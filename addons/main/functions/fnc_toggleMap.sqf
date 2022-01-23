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

if (!GVAR(isOpen)) then {
    private _player = call CBA_fnc_currentUnit;
    GVAR(hasGPS) = _player call FUNC(findGPS);

    // Exit if in an invalid state for foldmap to open
    if (!GVAR(enableMap) || {GVAR(closeMap) && {visibleMap}} || {GVAR(requireMapForPaperMap) && {GVAR(drawPaper)} && {!shownMap}} || {GVAR(requireGPSForTablet) && {!GVAR(drawPaper)} && {!GVAR(hasGPS)}} || {!(cameraView in GVAR(closeView))} || {!alive _player}) exitWith {};

    call FUNC(openFoldmap);
} else {
    GVAR(doShow) = false;
};
