[COMPONENT_NAME, QGVAR(toggleMap), ["Toggle folding map", "Toggles the minimap display."], {
     call FUNC(toggleMap);
     true;
}, {}, [DIK_M, [false, false, true]]] call CBA_fnc_addKeybind;

[COMPONENT_NAME, QGVAR(refoldMap), "Refold map", {
    if (GVAR(isOpen) && {GVAR(adjustMode) isEqualTo 0} && {shownGPS || {!GVAR(GPSAdjust)}}) then {
        GVAR(centerPos) = getPosATL (call CBA_fnc_currentUnit);
       	(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
       	ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));
    };
    true;
}, {}, [DIK_M, [true, true, false]]] call CBA_fnc_addKeybind;

[COMPONENT_NAME, QGVAR(zoomInMap), ["Zoom In", "Zooms in on the minimap display."], {
    if (GVAR(isOpen)) then {
        call FUNC(zoomIn);
    };
    true;
}, {}, [DIK_NUMPADPLUS, [false, false, true]]] call CBA_fnc_addKeybind;

[COMPONENT_NAME, QGVAR(zoomOutMap), ["Zoom Out", "Zooms out on the minimap display."], {
    if (GVAR(isOpen)) then {
        call FUNC(zoomOut);
    };
    true;
}, {}, [DIK_NUMPADMINUS, [false, false, true]]] call CBA_fnc_addKeybind;

[COMPONENT_NAME, QGVAR(nightModeMap), ["Night Mode (tablet only)", "If in tablet mode, you can switch to night mode and back with this keybind."], {
    if (GVAR(isOpen) && {!GVAR(drawPaper)}) then {
        call FUNC(nvMode);
    };
    true;
}, {}, [DIK_N, [false, true, true]]] call CBA_fnc_addKeybind;

[COMPONENT_NAME, QGVAR(moveUpMap), ["Move Up", "If in manual mode, use this keybind to move up."], {
    if (GVAR(isOpen)) then {
        GVAR(up) = true;
    };
    true;
}, {}, [DIK_UPARROW, [false, false, true]]] call CBA_fnc_addKeybind;

[COMPONENT_NAME, QGVAR(moveDownMap), ["Move Down", "If in manual mode, use this keybind to move down."], {
    if (GVAR(isOpen)) then {
        GVAR(down) = true;
    };
    true;
}, {}, [DIK_DOWNARROW, [false, false, true]]] call CBA_fnc_addKeybind;

[COMPONENT_NAME, QGVAR(moveLeftMap), ["Move Left", "If in manual mode, use this keybind to move left."], {
    if (GVAR(isOpen)) then {
        GVAR(left) = true;
    };
    true;
}, {}, [DIK_LEFTARROW, [false, false, true]]] call CBA_fnc_addKeybind;

[COMPONENT_NAME, QGVAR(moveRightMap), ["Move Right", "If in manual mode, use this keybind to move right."], {
    if (GVAR(isOpen)) then {
        GVAR(right) = true;
    };
    true;
}, {}, [DIK_RIGHTARROW, [false, false, true]]] call CBA_fnc_addKeybind;

[COMPONENT_NAME, QGVAR(configureMap), ["Configure Map", "Allows you to change various aspects of the minimap display."],
    ["player", [], -100, QUOTE(call FUNC(fleximenu))],
[DIK_M, [false, true, true]]] call CBA_fnc_addKeybindToFleximenu;
