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
            "Reposition map", // text on button
            {
                MOVEME closeDisplay 0;
                createDialog QGVAR(foldMapMovingDialog);
            }, // code to run
            "", // icon
            "", // tooltip
            [], // submenu,     {"submenu"|["menuName", "", {0/1} (optional - use embedded list menu)]},
            DIK_R, // shortcut key
            GVAR(enableMap) && {GVAR(isOpen)} && {GVAR(reposMap)}, // enabled?
            true // visible if true
        ],

        [
            // Change to tablet/paper
            format ["Change to %1", ["tablet", "paper"] select (DRAW_STYLE isEqualTo "tablet")],
            {
                private _type = ["tablet", "paper"] select (DRAW_STYLE isEqualTo "tablet");

                // Save new style to profile namespace.
                DRAW_STYLE_SET(_type);
                GVAR(drawPaper) = [false, true] select (_type isEqualTo "paper");
                GVAR(mapNeedsResize) = true;

                if (GVAR(isOpen)) then {
                    call FUNC(refreshMap);
                };
            },
            "",
            "",
            [],
            DIK_C,
            GVAR(enableMap) && {GVAR(isOpen)} && {!GVAR(mapTypeLocked)},
            true
        ],

        [
            // Switch to day/night mode
            format ["Switch to %1 mode", ["night", "day"] select (GVAR(isNightMap))],
            {
                if (GVAR(isOpen) && {!GVAR(drawPaper)}) then {
                    call FUNC(nvMode);
                };
            },
            "",
            "",
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
                    GVAR(adjustMode) = 1;
                    call FUNC(refreshMap);
                };
            },
            "",
            "",
            [],
            DIK_M,
            GVAR(enableMap) && {GVAR(isOpen)} && {GVAR(adjustMode) isNotEqualTo 1} && {!GVAR(allowAdjustLocked)},
            true
        ],

        [
            // Switch to automatic tracking mode
            "Switch to Automatic Tracking",
            {
                if (GVAR(isOpen)) then {
                    GVAR(adjustMode) = 0;
                    call FUNC(refreshMap);
                };
            },
            "",
            "",
            [],
            DIK_A,
            GVAR(enableMap) && {GVAR(isOpen)} && {GVAR(adjustMode) isNotEqualTo 0} && {!GVAR(allowAdjustLocked)} && {shownGPS || {!GVAR(GPSAdjust)}},
            true
        ],

        [
            // Switch to centered tracking mode
            "Switch to Centered Tracking",
            {
                if (GVAR(isOpen)) then {
                    GVAR(adjustMode) = 2;
                    call FUNC(refreshMap);
                };
            },
            "",
            "",
            [],
            DIK_T,
            GVAR(enableMap) && {GVAR(isOpen)} && {GVAR(adjustMode) isNotEqualTo 2} && {!GVAR(allowAdjustLocked)} && {shownGPS || {!GVAR(GPSAdjust)}},
            true
        ],

        [
            // Switch to centered tracking mode
            "Toggle Scale",
            {
                if (GVAR(isOpen)) then {
                    // Gets how many times the map has been reduced and sets new factor
                    MAP_SIZE_SET([ARR_2(1, MAP_SIZE * SIZE_REDUCTION)] select (MAP_SIZE > 0.82));
                    GVAR(mapNeedsResize) = true;

                    call FUNC(refreshMap);
                };
            },
            "",
            "",
            [],
            DIK_G,
            GVAR(enableMap) && {GVAR(isOpen)},
            true
        ]
    ]
];
