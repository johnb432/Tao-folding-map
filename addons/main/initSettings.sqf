[
    QGVAR(enableMap),
    "LIST",
    ["Map", "Enables the addon. Makes it easy to disable instead of unloading the mod."],
    ["Tao's Folding Map Rewrite", "Locks"],
    [[false, true], ["Disabled", "Enabled"], 1],
    false,
    {
        if (GVAR(isOpen)) then {
            GVAR(doShow) = false;
        };
    },
    false
] call CBA_fnc_addSetting;

[
    QGVAR(mapTypeUnlocked),
    "LIST",
    ["Lock map type", "Locks the map type to paper. Handy for pre-GPS missions."],
    ["Tao's Folding Map Rewrite", "Locks"],
    [[false, true], ["Locked to Paper", "Unlocked"], 1],
    false,
    {
        if (!GVAR(mapTypeUnlocked)) then {
            GVAR(drawPaper) = true;
            SETPRVAR(drawStyle, "paper");
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
    ["Tao's Folding Map Rewrite", "Locks"],
    [[1, 0, 2], ["Manual", "Automatic", "Always centered"], 1],
    false,
    {
        if (GVAR(isOpen)) then {
            call FUNC(refreshMap);
        };
    },
    false
] call CBA_fnc_addSetting;

[
    QGVAR(reposMap),
    "LIST",
    ["Map repositioning", "Allows the repositioning of the map on the player's screen."],
    ["Tao's Folding Map Rewrite", "Locks"],
    [[false, true], ["Locked", "Unlocked"], 1],
    false,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(prefMap),
    "LIST",
    ["Preferred map type", "Sets preferred map type."],
    ["Tao's Folding Map Rewrite", "Preferences"],
    [[false, true], ["Tablet", "Paper"], 0],
    false,
    {
        if (GVAR(mapTypeUnlocked)) then {
            GVAR(drawPaper) = GVAR(prefMap);
            if (GVAR(drawPaper)) then {
                SETPRVAR(drawStyle, "paper");
            } else {
                SETPRVAR(drawStyle, "tablet");
            };
            if (GVAR(isOpen)) then {
                call FUNC(refreshMap);
            };
        };
    },
    false
] call CBA_fnc_addSetting;

[
    QGVAR(closeMap),
    "LIST",
    ["Close map", "Closes the map every time the vanilla map is opened."],
    ["Tao's Folding Map Rewrite", "Preferences"],
    [[false, true], ["Disabled", "Enabled"], 1],
    false,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(closeView),
    "LIST",
    ["Keep map open in:", "Keep the map open every time you enter despite switching perspectives."],
    ["Tao's Folding Map Rewrite", "Preferences"],
    [[["INTERNAL","EXTERNAL"], ["INTERNAL","EXTERNAL","GUNNER"], ["INTERNAL","EXTERNAL","GROUP"], ["INTERNAL","EXTERNAL","GUNNER","GROUP"]], ["1st & 3rd perspectives", "1st, 3rd & gunner perspectives", "1st, 3rd & commander perspectives", "All perspectives"], 0],
    false,
    {},
    false
] call CBA_fnc_addSetting;

[
    QGVAR(allowShake),
    "LIST",
    ["Allow shake", "Allows shaking/bobbling of the map while moving on foot."],
    ["Tao's Folding Map Rewrite", "Preferences"],
    [[false, true], ["Disabled", "Enabled"], 1],
    false,
    {
        if (GVAR(isOpen)) then {
            call FUNC(refreshMap);
        };
    },
    false
] call CBA_fnc_addSetting;

[
    QGVAR(mapIcon),
    "LIST",
    ["Icon on map", "Enables tracking of a person on the tablet. An arrow is placed where the person is currently at. A vanilla GPS/NAV panel has to be open for it to work (Right-Ctrl M to open it by default)."],
    ["Tao's Folding Map Rewrite", "Tablet"],
    [[false, true], ["Disabled", "Enabled"], 1],
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
    "LIST",
    ["Tablet gridref", "Enables a grid reference on the tablet if the person has a vanilla GPS/NAV panel open."],
    ["Tao's Folding Map Rewrite", "Tablet"],
    [[false, true], ["Disabled", "Enabled"], 1],
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
    ["Tao's Folding Map Rewrite", "Tablet"],
    [[true, false], ["Night", "Day"], 1],
    false,
    {
        if (!GVAR(drawPaper) && {GVAR(isOpen)}) then {
            call FUNC(refreshMap);
        };
    },
    false
] call CBA_fnc_addSetting;
