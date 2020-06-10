#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.sqf"

["Tao's Folding Map Rewrite", "toggle", "Toggle folding map", {
  call FUNC(toggleMap); true
}, {}, [DIK_M, [false, false, true]]] call cba_fnc_addKeybind;

["Tao's Folding Map Rewrite", "refold", "Refold map", {
  if (GVAR(allowadjust)) then {
    call FUNC(refold);
  }; true
}, {}, [DIK_M, [true, true, false]]] call cba_fnc_addKeybind;

["Tao's Folding Map Rewrite", "zoomin", "Zoom In", {
  call FUNC(zoomIn); true
}, {}, [DIK_NUMPADPLUS, [false, false, true]]] call cba_fnc_addKeybind;

["Tao's Folding Map Rewrite", "zoomout", "Zoom Out", {
  call FUNC(zoomOut); true
}, {}, [DIK_NUMPADMINUS, [false, false, true]]] call cba_fnc_addKeybind;

["Tao's Folding Map Rewrite", "nightmode", "Night Mode (tablet only)", {
  call FUNC(nvMode); true
}, {}, [DIK_N, [false, true, true]]] call cba_fnc_addKeybind;

["Tao's Folding Map Rewrite", "configure", "Configure Map",
  ["player", [], -100, QUOTE(if(GVAR(isOpen)) then {call FUNC(fleximenu);};)],
[DIK_M, [false, true, true]]] call CBA_fnc_addKeybindToFleximenu;

["Tao's Folding Map Rewrite", "moveup", "Move Up", {
  GVAR(up) = true; true
}, {}, [DIK_UPARROW, [false, false, true]]] call cba_fnc_addKeybind;

["Tao's Folding Map Rewrite", "movedown", "Move Down", {
  GVAR(down) = true; true
}, {}, [DIK_DOWNARROW, [false, false, true]]] call cba_fnc_addKeybind;

["Tao's Folding Map Rewrite", "moveleft", "Move Left", {
  GVAR(left) = true; true
}, {}, [DIK_LEFTARROW, [false, false, true]]] call cba_fnc_addKeybind;

["Tao's Folding Map Rewrite", "moveright", "Move Right", {
  GVAR(right) = true; true
}, {}, [DIK_RIGHTARROW, [false, false, true]]] call cba_fnc_addKeybind;

ADDON = true;