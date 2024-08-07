#include "..\script_component.hpp"
/*
 * Author: johnb43
 * Open and closes the map to refresh the interface (for tablet and paper map).
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call tao_rewrite_main_fnc_refreshMap
 *
 * Public: No
 */

call FUNC(toggleMap);

// Best wait 2 frames
[FUNC(toggleMap), [], 2] call CBA_fnc_execAfterNFrames;
