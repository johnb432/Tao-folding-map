#include "script_component.hpp"

/*
 * Author: johnb43
 * Menu definition.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
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
                // Save new style to profile namespace.
                DRAW_STYLE_SET([ARR_2("paper","tablet")] select GVAR(drawPaper));
                GVAR(drawPaper) = !GVAR(drawPaper);

                if (GVAR(isOpen)) then {
                    call FUNC(refreshMap);
                };
            },
            "",
            "Toggles the map type.",
            [],
            DIK_T,
            GVAR(enableMap) && {GVAR(CBASettingsInitialized)} && {!GVAR(mapTypeLocked)} && {!GVAR(requireMapForPaperMap) || shownMap || GVAR(drawPaper)} && {!GVAR(requireGPSForTablet) || GVAR(hasGPS) || !GVAR(drawPaper)},
            true
        ],

        [
            // Switch to day/night mode
            format ["Switch to %1 mode", ["night", "day"] select GVAR(isNightMap)],
            {
                if (GVAR(isOpen) && {!GVAR(drawPaper)}) then {
                    call FUNC(nvMode);
                };
            },
            "",
            "Toggles the map mode.",
            [],
            DIK_S,
            GVAR(enableMap) && {GVAR(isOpen)} && {!GVAR(drawPaper)},
            true
        ],

        [
            // Switch to manual tracking mode
            "Switch to Manual Tracking",
            {
                if (GVAR(isOpen)) then {
                    GVAR(adjustMode) = MANUAL;
                };
            },
            "",
            "Switches the map to manual tracking mode.",
            [],
            DIK_M,
            GVAR(enableMap) && {GVAR(isOpen)} && {GVAR(adjustMode) != MANUAL} && {!GVAR(allowAdjustSettingIsLocked)},
            true
        ],

        [
            // Switch to automatic tracking mode
            "Switch to Automatic Tracking",
            {
                if (GVAR(isOpen)) then {
                    GVAR(adjustMode) = AUTOMATIC;
                };
            },
            "",
            "Switches the map to automatic tracking mode.",
            [],
            DIK_A,
            GVAR(enableMap) && {GVAR(isOpen)} && {GVAR(adjustMode) != AUTOMATIC} && {!GVAR(allowAdjustSettingIsLocked)} && {GVAR(hasGPS) || !GVAR(GPSAdjust)},
            true
        ],

        [
            // Switch to centered tracking mode
            "Switch to Centered Tracking",
            {
                if (GVAR(isOpen)) then {
                    GVAR(adjustMode) = CENTERED;
                };
            },
            "",
            "Switches the map to centered tracking mode.",
            [],
            DIK_C,
            GVAR(enableMap) && {GVAR(isOpen)} && {GVAR(adjustMode) != CENTERED} && {!GVAR(allowAdjustSettingIsLocked)} && {GVAR(hasGPS) || !GVAR(GPSAdjust)},
            true
        ]
    ]
];
