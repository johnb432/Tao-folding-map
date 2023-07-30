#include "script_component.hpp"

/*
 * Author: johnb43
 * Menu definition.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Fleximenu <ARRAY>
 *
 * Example:
 * call tao_rewrite_main_fnc_fleximenu;
 *
 * Public: No
 */

[
    ["main", COMPONENT_NAME, "popup"],
    [
        [
            // Change to tablet/paper
            format ["Change to %1", ["paper", "tablet"] select GVAR(drawPaper)],
            {
                GVAR(drawPaper) = !GVAR(drawPaper);

                if (GVAR(isOpen)) then {
                    call FUNC(refreshMap);
                };
            },
            "",
            "Toggles the map type.",
            [],
            DIK_T,
            GETMVAR("CBA_settings_ready",false) && {GVAR(enableMap)} && {!GVAR(mapTypeLocked)} && {!GVAR(requireMapForPaperMap) || shownMap || GVAR(drawPaper)} && {!GVAR(requireGPSForTablet) || GVAR(hasGPS) || !GVAR(drawPaper)},
            true
        ], [
            // Switch to day/night mode
            format ["Switch to %1 mode", ["night", "day"] select GVAR(isNightMap)],
            {
                call FUNC(toggleNvMode);
            },
            "",
            "Toggles the map mode.",
            [],
            DIK_S,
            GETMVAR("CBA_settings_ready",false) && {GVAR(enableMap)} && {GVAR(isOpen)} && {!GVAR(drawPaper)},
            true
        ], [
            // Switch to manual tracking mode
            "Switch to Manual Tracking",
            {
                GVAR(adjustMode) = MANUAL;
            },
            "",
            "Switches the map to manual tracking mode.",
            [],
            DIK_M,
            GETMVAR("CBA_settings_ready",false) && {GVAR(enableMap)} && {GVAR(isOpen)} && {GVAR(adjustMode) != MANUAL} && {!GVAR(allowAdjustSettingIsLocked)},
            true
        ], [
            // Switch to automatic tracking mode
            "Switch to Automatic Tracking",
            {
                GVAR(adjustMode) = AUTOMATIC;
            },
            "",
            "Switches the map to automatic tracking mode.",
            [],
            DIK_A,
            GETMVAR("CBA_settings_ready",false) && {GVAR(enableMap)} && {GVAR(isOpen)} && {GVAR(adjustMode) != AUTOMATIC} && {!GVAR(allowAdjustSettingIsLocked)} && {GVAR(hasGPS) || !GVAR(GPSAdjust)},
            true
        ], [
            // Switch to centered tracking mode
            "Switch to Centered Tracking",
            {
                GVAR(adjustMode) = CENTERED;
            },
            "",
            "Switches the map to centered tracking mode.",
            [],
            DIK_C,
            GETMVAR("CBA_settings_ready",false) && {GVAR(enableMap)} && {GVAR(isOpen)} && {GVAR(adjustMode) != CENTERED} && {!GVAR(allowAdjustSettingIsLocked)} && {GVAR(hasGPS) || !GVAR(GPSAdjust)},
            true
        ]
    ]
]
