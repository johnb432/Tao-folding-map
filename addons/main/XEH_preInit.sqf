#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.sqf"

["Tao's Folding Map Rewrite", "toggle", "Toggle folding map", {
     call FUNC(toggleMap);
     true
}, {}, [DIK_M, [false, false, true]]] call cba_fnc_addKeybind;

["Tao's Folding Map Rewrite", "refold", "Refold map", {
    if (GVAR(isOpen) && {GVAR(allowAdjust) == 0} && {visibleGPS || GVAR(GPSAdjust)}) then {
        private _pos = getPos player;
       	(FOLDMAP displayCtrl GVAR(mapCtrlActive)) ctrlMapAnimAdd [0, GVAR(mapScale), [_pos select 0, _pos select 1, 0]];
       	ctrlMapAnimCommit (FOLDMAP displayCtrl GVAR(mapCtrlActive));
       	GVAR(centerPos) = [_pos select 0, _pos select 1];
    };
    true
}, {}, [DIK_M, [true, true, false]]] call cba_fnc_addKeybind;

["Tao's Folding Map Rewrite", "zoomin", "Zoom In", {
    if (GVAR(isOpen)) then {
        call FUNC(zoomIn)
    };
    true
}, {}, [DIK_NUMPADPLUS, [false, false, true]]] call cba_fnc_addKeybind;

["Tao's Folding Map Rewrite", "zoomout", "Zoom Out", {
    if (GVAR(isOpen)) then {
        call FUNC(zoomOut)
    };
    true
}, {}, [DIK_NUMPADMINUS, [false, false, true]]] call cba_fnc_addKeybind;

["Tao's Folding Map Rewrite", "nightmode", "Night Mode (tablet only)", {
    if (GVAR(isOpen) && {!GVAR(drawPaper)}) then {
        call FUNC(nvMode);
    };
    true
}, {}, [DIK_N, [false, true, true]]] call cba_fnc_addKeybind;

["Tao's Folding Map Rewrite", "configure", "Configure Map",
  ["player", [], -100, QUOTE(call FUNC(fleximenu))],
[DIK_M, [false, true, true]]] call CBA_fnc_addKeybindToFleximenu;

["Tao's Folding Map Rewrite", "moveup", "Move Up", {
    if (GVAR(isOpen)) then {
        GVAR(up) = true;
    };
    true
}, {}, [DIK_UPARROW, [false, false, true]]] call cba_fnc_addKeybind;

["Tao's Folding Map Rewrite", "movedown", "Move Down", {
    if (GVAR(isOpen)) then {
        GVAR(down) = true;
    };
    true
}, {}, [DIK_DOWNARROW, [false, false, true]]] call cba_fnc_addKeybind;

["Tao's Folding Map Rewrite", "moveleft", "Move Left", {
    if (GVAR(isOpen)) then {
        GVAR(left) = true;
    };
    true
}, {}, [DIK_LEFTARROW, [false, false, true]]] call cba_fnc_addKeybind;

["Tao's Folding Map Rewrite", "moveright", "Move Right", {
    if (GVAR(isOpen)) then {
        GVAR(right) = true;
    };
    true
}, {}, [DIK_RIGHTARROW, [false, false, true]]] call cba_fnc_addKeybind;

ADDON = true;
