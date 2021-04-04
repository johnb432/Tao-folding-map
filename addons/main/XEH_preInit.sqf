#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.sqf"

[COMPONENT_NAME, QGVAR(toggleMap), "Toggle folding map", {
     call FUNC(toggleMap);
     true
}, {}, [DIK_M, [false, false, true]]] call CBA_fnc_addKeybind;

[COMPONENT_NAME, QGVAR(refoldMap), "Refold map", {
    if (GVAR(isOpen) && {GVAR(adjustMode) isEqualTo 0} && {GVAR(foundGPS) || {!GVAR(GPSAdjust)}}) then {
        GVAR(centerPos) = getPos player;
       	(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), GVAR(centerPos)];
       	ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));
    };
    true
}, {}, [DIK_M, [true, true, false]]] call CBA_fnc_addKeybind;

[COMPONENT_NAME, QGVAR(zoomInMap), "Zoom In", {
    if (GVAR(isOpen)) then {
        call FUNC(zoomIn);
    };
    true
}, {}, [DIK_NUMPADPLUS, [false, false, true]]] call CBA_fnc_addKeybind;

[COMPONENT_NAME, QGVAR(zoomOutMap), "Zoom Out", {
    if (GVAR(isOpen)) then {
        call FUNC(zoomOut);
    };
    true
}, {}, [DIK_NUMPADMINUS, [false, false, true]]] call CBA_fnc_addKeybind;

[COMPONENT_NAME, QGVAR(nightModeMap), "Night Mode (tablet only)", {
    if (GVAR(isOpen) && {!GVAR(drawPaper)}) then {
        call FUNC(nvMode);
    };
    true
}, {}, [DIK_N, [false, true, true]]] call CBA_fnc_addKeybind;

[COMPONENT_NAME, QGVAR(moveUpMap), "Move Up", {
    if (GVAR(isOpen)) then {
        GVAR(up) = true;
    };
    true
}, {}, [DIK_UPARROW, [false, false, true]]] call CBA_fnc_addKeybind;

[COMPONENT_NAME, QGVAR(moveDownMap), "Move Down", {
    if (GVAR(isOpen)) then {
        GVAR(down) = true;
    };
    true
}, {}, [DIK_DOWNARROW, [false, false, true]]] call CBA_fnc_addKeybind;

[COMPONENT_NAME, QGVAR(moveLeftMap), "Move Left", {
    if (GVAR(isOpen)) then {
        GVAR(left) = true;
    };
    true
}, {}, [DIK_LEFTARROW, [false, false, true]]] call CBA_fnc_addKeybind;

[COMPONENT_NAME, QGVAR(moveRightMap), "Move Right", {
    if (GVAR(isOpen)) then {
        GVAR(right) = true;
    };
    true
}, {}, [DIK_RIGHTARROW, [false, false, true]]] call CBA_fnc_addKeybind;

[COMPONENT_NAME, QGVAR(configureMap), "Configure Map",
    ["player", [], -100, QUOTE(call FUNC(fleximenu))],
[DIK_M, [false, true, true]]] call CBA_fnc_addKeybindToFleximenu;

ADDON = true;
