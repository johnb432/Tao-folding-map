[
  QGVAR(enablemap),
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
  QGVAR(maplock),
  "LIST",
  ["Lock map type", "Locks the map type to paper. Handy for pre-GPS missions."],
  ["Tao's Folding Map Rewrite", "Locks"],
  [[false, true], ["Locked to Paper", "Unlocked"], 1],
  false,
  {
    if (!GVAR(maplock)) then {
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
  QGVAR(allowadjust),
  "LIST",
  ["Keep player on map", "Automatic adjusts the map to keep you on the map. When set to manual you have to move the map yourself [see keybinds]. Handy if more realism is wished for pre-GPS missions."],
  ["Tao's Folding Map Rewrite", "Locks"],
  [[false, true], ["Manual", "Automatic"], 1],
  false,
  {
    if (GVAR(isOpen)) then {
      call FUNC(refreshMap);
    };
  },
  false
] call CBA_fnc_addSetting;

[
  QGVAR(reposmap),
  "LIST",
  ["Map repositioning", "Allows the repositioning of the map on the player's screen."],
  ["Tao's Folding Map Rewrite", "Locks"],
  [[false, true], ["Locked", "Unlocked"], 1],
  false,
  {},
  false
] call CBA_fnc_addSetting;

[
  QGVAR(prefmap),
  "LIST",
  ["Preferred map type", "Sets preferred map type."],
  ["Tao's Folding Map Rewrite", "Preferences"],
  [[false, true], ["Tablet", "Paper"], 0],
  false,
  {
    if (GVAR(maplock)) then {
      GVAR(drawPaper) = GVAR(prefmap);
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
  QGVAR(closemap),
  "LIST",
  ["Close map", "Closes the map every time the vanilla map is opened."],
  ["Tao's Folding Map Rewrite", "Preferences"],
  [[false, true], ["Disabled", "Enabled"], 1],
  false,
  {},
  false
] call CBA_fnc_addSetting;

[
  QGVAR(allowshake),
  "LIST",
  ["Allow shake", "Allows shaking/bobbling of the map while moving on foot."],
  ["Tao's Folding Map Rewrite", "Preferences"],
  [[false, true], ["Disabled", "Enabled"], 1],
  false,
  {},
  false
] call CBA_fnc_addSetting;

[
  QGVAR(updateInterval),
  "SLIDER",
  ["Update Interval", "Changes the interval at which the map refreshes. 0 is every frame, otherwise Interval is in seconds. This affects the closing time of the map too, so it can act weird. Change at own discretion."],
  ["Tao's Folding Map Rewrite", "Preferences"],
  [0, 10, 0, 2],
  false,
  {
    if (GVAR(updateInterval) != 0) then {
      GVAR(allowshake) = false;
    };
  },
  false
] call CBA_fnc_addSetting;

[
  QGVAR(mapicon),
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
  QGVAR(gridref),
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