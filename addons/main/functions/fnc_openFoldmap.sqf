#include "script_component.hpp"
/*
 * Author: johnb43
 * Selects which type of tracking should be applied and then opens the respective PFH.
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
if (!GVAR(enableMap) || {GVAR(isOpen)} || {visibleMap && GVAR(closeMap)} || {!(cameraView in GVAR(closeView))} || {!alive player}
    || {!("ItemMap" in assignedItems player || {(player infoPanelComponents "left") findIf {(_x select 1) isEqualTo "MinimapDisplayComponent" && {_x select 2}} isEqualTo -1})}) exitWith {};

// Initialize the dialog.
GVAR(isOpen) = true;
GVAR(mapRscLayer) cutRsc [QGVAR(foldMap), "PLAIN", 0];

// Scroll up map and decorations.
[SCROLLTIME] call FUNC(moveMapOnscreen);

// Monitor and update map until closed.
GVAR(doShow) = true;

//only adjusts when player gets off screen
if (GVAR(adjustMode) isEqualTo 0) exitWith {
    call FUNC(PFHautomatic);
};

//needs to be manually adjusted
if (GVAR(adjustMode) isEqualTo 1) exitWith {
    call FUNC(PFHmanual);
};

//always centers player
if (GVAR(adjustMode) isEqualTo 2) exitWith {
    call FUNC(PFHcentered);
};
