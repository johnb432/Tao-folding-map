#include "\x\cba\addons\main\script_macros_common.hpp"

//This part includes parts of the CBA and ACE3 macro libraries
#define GETUVAR(var1,var2) (uiNamespace getVariable [ARR_2(QUOTE(var1),var2)])
#define GETPRVAR(var1,var2) (profileNamespace getVariable [ARR_2(QUOTE(var1),var2)])

#define SETUVAR(var1,var2) (uiNamespace setVariable [ARR_2(QUOTE(var1),var2)])
#define SETPRVAR(var1,var2) (profileNamespace setVariable [ARR_2(QUOTE(var1),var2)])

#define DFUNC(var1) TRIPLES(ADDON,fnc,var1)

#ifdef DISABLE_COMPILE_CACHE
    #undef PREP
    #define PREP(fncName) DFUNC(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)
#else
    #undef PREP
    #define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
#endif

#define POS_CALC ((safezoneW / safezoneH) min 1.2)
#define X_OFF (safezoneX + (safezoneW - POS_CALC) / 2)
#define Y_OFF (safezoneY + (safezoneH - (POS_CALC / 1.2)) / 2)
#define W_OFF (POS_CALC / 40)
#define H_OFF (POS_CALC / 30) // (POS_CALC / 1.2) / 25

#define POS_W(var1) (var1 * W_OFF)
#define POS_H(var1) (var1 * H_OFF)
#define POS_X(var1) (POS_W(var1) + X_OFF)
#define POS_Y(var1) (POS_H(var1) + Y_OFF)

// Prevents flickering along edges
#define FUDGEFACTOR 0.2

// For size reductions of UI
#define OFFSET_X 98.5
#define OFFSET_Y_TABLET 26
#define OFFSET_Y_PAPER 18

#define RATIO_H_W (13.9 / 9.7)
#define RATIO_H_W_MAP 1.81
#define DEFAULT_HEIGHT (POS_H(20))
#define SCALE (MAP_HEIGHT / DEFAULT_HEIGHT)

// Relative positioning defines; Getters
#define MAP_XPOS (GETPRVAR(igui_grid_tao_folding_map_rewrite_x,POS_X(5)))
#define MAP_YPOS (GETPRVAR(igui_grid_tao_folding_map_rewrite_y,POS_Y(5)))
#define MAP_WIDTH (GETPRVAR(igui_grid_tao_folding_map_rewrite_w,POS_W(20)))
#define MAP_HEIGHT (GETPRVAR(igui_grid_tao_folding_map_rewrite_h,POS_H(20)))
#define DRAW_STYLE (GETPRVAR(GVAR(drawStyle),"paper"))

// Setters
#define MAP_XPOS_SET(var) (SETPRVAR(igui_grid_tao_folding_map_rewrite_x,var))
#define MAP_YPOS_SET(var) (SETPRVAR(igui_grid_tao_folding_map_rewrite_y,var))
#define MAP_WIDTH_SET(var) (SETPRVAR(igui_grid_tao_folding_map_rewrite_w,var))
#define MAP_HEIGHT_SET(var) (SETPRVAR(igui_grid_tao_folding_map_rewrite_h,var))
#define DRAW_STYLE_SET(var) (SETPRVAR(GVAR(drawStyle),var))

#define FOLDMAP (GETUVAR(GVAR(foldMap),displayNull))

// Display & control ID defines.
#define IDD_INTERRUPT 49

#define IDC_BACKGROUND 23
#define IDC_GROUP 24
#define IDC_DAYMAP 40
#define IDC_NIGHTMAP 41
#define IDC_STATUSBAR 30
#define IDC_STATUSRIGHT 31
#define IDC_STATUSLEFT 32
