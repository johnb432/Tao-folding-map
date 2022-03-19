[
    QGVAR(enableMap),
    "CHECKBOX",
    ["Map", "Enables the addon. Makes it easy to disable instead of unloading the mod."],
    [COMPONENT_NAME, "General"],
    true,
    false,
    {
        if (GVAR(isOpen)) then {
            GVAR(doShow) = false;
        };
    }
] call CBA_fnc_addSetting;

[
    QGVAR(prefMap),
    "LIST",
    ["Preferred map type", "Sets preferred map type."],
    [COMPONENT_NAME, "General"],
    [[false, true], ["Tablet", "Paper"], 0],
    0,
    {
        if (!GVAR(mapTypeLocked)) then {
            GVAR(drawPaper) = _this;

            DRAW_STYLE_SET([ARR_2("tablet","paper")] select _this);
        };
    }
] call CBA_fnc_addSetting;

[
    QGVAR(closeMap),
    "CHECKBOX",
    ["Close map", "Closes the map every time the vanilla map is opened."],
    [COMPONENT_NAME, "General"],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(closeView),
    "LIST",
    ["Keep map open in", "Keep the map open every time you enter despite switching perspectives."],
    [COMPONENT_NAME, "General"],
    [[["INTERNAL","EXTERNAL"], ["INTERNAL","EXTERNAL","GUNNER"], ["INTERNAL","EXTERNAL","GROUP"], ["INTERNAL","EXTERNAL","GUNNER","GROUP"]], ["1st & 3rd perspectives", "1st, 3rd & gunner perspectives", "1st, 3rd & commander perspectives", "All perspectives"], 0]
] call CBA_fnc_addSetting;

[
    QGVAR(refreshRate),
    "SLIDER",
    ["Refresh rate", "Sets the refresh time in seconds."],
    [COMPONENT_NAME, "General"],
    [0, 10, 0, 2]
] call CBA_fnc_addSetting;



[
    QGVAR(allowAdjust),
    "LIST",
    ["Keep player on map", "Automatic adjusts the map to keep you on the map. Always centered keeps the player centered at all times. When set to manual you have to move the map yourself [see keybinds]."],
    [COMPONENT_NAME, "Locks"],
    [[1, 0, 2], ["Manual", "Automatic", "Always centered"], 1],
    0,
    {
        GVAR(adjustMode) = _this;
    }
] call CBA_fnc_addSetting;

[
    QGVAR(GPSAdjust),
    "CHECKBOX",
    ["Require GPS panel to adjust automatically", "If set to true, you will need a GPS panel to be able to use the automatic adjusting modes."],
    [COMPONENT_NAME, "Locks"],
    true,
    1
] call CBA_fnc_addSetting;

[
    QGVAR(mapTypeLocked),
    "CHECKBOX",
    ["Lock map type", "Locks the map type to paper. Handy for pre-GPS missions."],
    [COMPONENT_NAME, "Locks"],
    false,
    0,
    {
        if (_this) then {
            GVAR(drawPaper) = true;
            DRAW_STYLE_SET("paper");
        };
    }
] call CBA_fnc_addSetting;



[
    QGVAR(requireMapForPaperMap),
    "CHECKBOX",
    ["Require a paper map for paper map", "If set, you will require map to show the paper map."],
    [COMPONENT_NAME, "Paper map"],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(allowPaperMapDarkening),
    "CHECKBOX",
    ["Allow paper map darkening", "If set, the paper map will darken with the ambient lighting."],
    [COMPONENT_NAME, "Paper map"],
    true
] call CBA_fnc_addSetting;



[
    QGVAR(requireGPSForTablet),
    "CHECKBOX",
    ["Require GPS panel for tablet", "If set, you will require a GPS panel to show the tablet."],
    [COMPONENT_NAME, "Tablet"],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(requireGPSmapIcon),
    "CHECKBOX",
    ["Require GPS panel for displaying icon", "If set, you will require a GPS panel to show your location on the tablet."],
    [COMPONENT_NAME, "Tablet"],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(requireGPSForGridRef),
    "CHECKBOX",
    ["Require GPS panel for displaying gridref", "If set, you will require a GPS panel to show your grid reference on the tablet."],
    [COMPONENT_NAME, "Tablet"],
    true
] call CBA_fnc_addSetting;



[
    QGVAR(mapIcon),
    "CHECKBOX",
    ["Icon on map", "Enables tracking of the player on the tablet. An arrow is placed where the player is currently at."],
    [COMPONENT_NAME, "Tablet Preferences"],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(gridRef),
    "CHECKBOX",
    ["Tablet gridref", "Enables a grid reference on the tablet if the person has a vanilla GPS/NAV panel."],
    [COMPONENT_NAME, "Tablet Preferences"],
    true
] call CBA_fnc_addSetting;

[
    QGVAR(isNightMap),
    "LIST",
    ["Preferred tablet mode", "Sets the preferred tablet mode."],
    [COMPONENT_NAME, "Tablet Preferences"],
    [[true, false], ["Night", "Day"], 1],
    false
] call CBA_fnc_addSetting;
