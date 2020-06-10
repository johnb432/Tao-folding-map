#include "script_component.hpp"
/*
 * Author: johnb43
 * Per-frame draw handler for map.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call tao_foldmap_main_fnc_drawUpdatePaper;
 *
 * Public: No
 */

// Darken paper map based on time. Based on ShackTac Map Brightness by zx64 & Dslyecxi.
private _alpha = (0.72 min (1 - sunOrMoon));
private _rectPos = (FOLDMAP displayCtrl DAYMAP) ctrlMapScreenToWorld [MAP_XPOS, MAP_YPOS];

// Draw a dark rectangle covering the map.
(FOLDMAP displayCtrl DAYMAP) drawRectangle [_rectPos, GVAR(pageWidth) * 3, GVAR(pageHeight) * 3, 0, [0, 0, 0, _alpha], "#(rgb,1,1,1)color(0,0,0,1)"];