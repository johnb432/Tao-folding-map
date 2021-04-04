[
    QGVAR(enableMap),
    "CHECKBOX",
    ["Map", "Enables the addon. Makes it easy to disable instead of unloading the mod."],
    [COMPONENT_NAME, "Locks"],
    true,
    false,
    {
        if (GVAR(isOpen)) then {
            GVAR(doShow) = false;
        };
    },
    false
] call CBA_fnc_addSetting;

[
    QGVAR(mapTypeLocked),
    "CHECKBOX",
    ["Lock map type", "Locks the map type to paper. Handy for pre-GPS missions."],
    [COMPONENT_NAME, "Locks"],
    false,
    false,
    {
        if (GVAR(mapTypeLocked)) then {
            GVAR(drawPaper) = true;
            DRAW_STYLE_SET("paper");

            if (GVAR(isOpen)) then {
                call FUNC(refreshMap);
            };
        };
    },
    false
] call CBA_fnc_addSetting;

[
    QGVAR(allowAdjust),
    "LIST",
    ["Keep player on map", "Automatic adjusts the map to keep you on the map. Always centered keeps the player centered at all times. When set to manual you have to move the map yourself [see keybinds]."],
    [COMPONENT_NAME, "Locks"],
    [[1, 0, 2], ["Manual", "Automatic", "Always centered"], 1],
    false,
    {
        GVAR(adjustMode) = GVAR(allowAdjust);

        if (GVAR(isOpen)) then {
            call FUNC(refreshMap);
        };
    },
    false
] call CBA_fnc_addSetting;

[
    QGVAR(allowAdjustLocked),
    "CHECKBOX",
    ["Lock 'Keep player on map'", "Forces the setting above."],
    [COMPONENT_NAME, "Locks"],
    false,
    false,
    {
        if (GVAR(allowAdjustLocked)) then {
            GVAR(adjustMode) = GVAR(allowAdjust);

            if (GVAR(isOpen)) then {
                call FUNC(refreshMap);
            };
        };
    },
    false
] call CBA_fnc_addSetting;

[
    QGVAR(GPSAdjust),
    "CHECKBOX",
    ["Require GPS panel to adjust automatically", "If set to true, you will need a GPS panel to be able to use the automatic adjusting modes."],
    [COMPONENT_NAME, "Locks"],
    true,
    true,
    {
        if (GVAR(isOpen)) then {
            call FUNC(refreshMap);
        };
    },
    false
] call CBA_fnc_addSetting;

[
    QGVAR(reposMap),
    "CHECKBOX",
    ["Map repositioning", "Allows the repositioning of the map on the player's screen."],
    [COMPONENT_NAME, "Locks"],
    true,
    false,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(prefMap),
    "LIST",
    ["Preferred map type", "Sets preferred map type."],
    [COMPONENT_NAME, "Preferences"],
    [[false, true], ["Tablet", "Paper"], 0],
    false,
    {
        if (!GVAR(mapTypeLocked)) then {
            GVAR(drawPaper) = GVAR(prefMap);

            DRAW_STYLE_SET(["tablet", "paper"] select GVAR(drawPaper));

            if (GVAR(isOpen)) then {
                call FUNC(refreshMap);
            };
        };
    },
    false
] call CBA_fnc_addSetting;

[
    QGVAR(closeMap),
    "CHECKBOX",
    ["Close map", "Closes the map every time the vanilla map is opened."],
    [COMPONENT_NAME, "Preferences"],
    true,
    false,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(closeView),
    "LIST",
    ["Keep map open in", "Keep the map open every time you enter despite switching perspectives."],
    [COMPONENT_NAME, "Preferences"],
    [[["INTERNAL","EXTERNAL"], ["INTERNAL","EXTERNAL","GUNNER"], ["INTERNAL","EXTERNAL","GROUP"], ["INTERNAL","EXTERNAL","GUNNER","GROUP"]], ["1st & 3rd perspectives", "1st, 3rd & gunner perspectives", "1st, 3rd & commander perspectives", "All perspectives"], 0],
    false,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(allowShake),
    "CHECKBOX",
    ["Allow shake", "Allows shaking/bobbling of the map while moving on foot."],
    [COMPONENT_NAME, "Preferences"],
    true,
    false,
    {
        GVAR(allowShakeMap) = GVAR(allowShake);
        if (GVAR(isOpen)) then {
            call FUNC(refreshMap);
        };
    },
    false
] call CBA_fnc_addSetting;

[
    QGVAR(refreshRate),
    "SLIDER",
    ["Refresh rate", "Sets the refresh time in seconds. 0 is every frame. Anything above 0.1 turns off map shake."],
    [COMPONENT_NAME, "Preferences"],
    [0, 2, 0, 2],
    false,
    {
        if (GVAR(refreshRate) > 0.1) then {
            GVAR(allowShakeMap) = false;
        };

        if (GVAR(isOpen)) then {
            call FUNC(refreshMap);
        };
    },
    false
] call CBA_fnc_addSetting;

[
    QGVAR(mapIcon),
    "CHECKBOX",
    ["Icon on map", "Enables tracking of a person on the tablet. An arrow is placed where the person is currently at. A vanilla GPS/NAV panel has to be present for it to work (not necessarily open!)."],
    [COMPONENT_NAME, "Tablet"],
    true,
    false,
    {
        if (!GVAR(drawPaper) && {GVAR(isOpen)}) then {
            call FUNC(refreshMap);
        };
    },
    false
] call CBA_fnc_addSetting;

[
    QGVAR(gridRef),
    "CHECKBOX",
    ["Tablet gridref", "Enables a grid reference on the tablet if the person has a vanilla GPS/NAV panel."],
    [COMPONENT_NAME, "Tablet"],
    true,
    false,
    {
        if (!GVAR(drawPaper) && {GVAR(isOpen)}) then {
            call FUNC(refreshMap);
        };
    },
    false
] call CBA_fnc_addSetting;

[
    QGVAR(isNightMap),
    "LIST",
    ["Preferred tablet mode", "Sets the preferred tablet mode."],
    [COMPONENT_NAME, "Tablet"],
    [[true, false], ["Night", "Day"], 1],
    false,
    {
        if (!GVAR(drawPaper) && {GVAR(isOpen)}) then {
            call FUNC(refreshMap);
        };
    },
    false
] call CBA_fnc_addSetting;
