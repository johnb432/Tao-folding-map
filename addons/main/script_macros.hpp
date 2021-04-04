#include "\x\cba\addons\main\script_macros_common.hpp"
#include "\x\cba\addons\xeh\script_xeh.hpp"

//This part includes parts of the CBA and ACE3 macro libraries
#define GETUVAR(var1,var2) (uiNamespace getVariable [ARR_2(QUOTE(var1),var2)])
#define GETPRVAR(var1,var2) (profileNamespace getVariable [ARR_2(QUOTE(var1),var2)])

#define SETPRVAR(var1,var2) (profileNamespace setVariable [ARR_2(QUOTE(var1),var2)])

#define FUNC_PATHTO_SYS(var1,var2,var3) \MAINPREFIX\var1\SUBPREFIX\var2\functions\var3.sqf

#ifdef DISABLE_COMPILE_CACHE
    #define PREPFNC(var1) TRIPLES(ADDON,fnc,var1) = compile preProcessFileLineNumbers 'FUNC_PATHTO_SYS(PREFIX,COMPONENT,DOUBLES(fnc,var1))'
#else
    #define PREPFNC(var1) ['FUNC_PATHTO_SYS(PREFIX,COMPONENT,DOUBLES(fnc,var1))', 'TRIPLES(ADDON,fnc,var1)'] call SLX_XEH_COMPILE_NEW
#endif

// Scroll time for map.
#define SCROLLTIME 0.45

// Prevents flickering along edges.
#define FUDGEFACTOR 0.2

// Hardcoded defaults.
// Where to place the map
#define DEFAULT_MAP_XPOS (safeZoneX + (safeZoneW * 0.035))
#define DEFAULT_MAP_YPOS (safeZoneY + (safeZoneH * 0.304))
// Shaking values
#define SHAKETIME 0.4
// For size reductions of UI
#define DEFAULT_MAP_SIZE 1
#define SIZE_REDUCTION 0.90
#define SIZE_REDUCTION_NUM 3
#define OFFSET_X 210
#define OFFSET_Y_TABLET 70
#define OFFSET_Y_PAPER 64
// Zoom levels
#define ZOOM_CONSTANT 0.9
#define ZOOM_1 ZOOM_CONSTANT
#define ZOOM_2 (ZOOM_1 * ZOOM_CONSTANT)

// Relative positioning defines. Getters
#define MAP_XPOS (GETPRVAR(GVAR(mapPosX),DEFAULT_MAP_XPOS))
#define MAP_YPOS (GETPRVAR(GVAR(mapPosY),DEFAULT_MAP_YPOS))
#define MAP_SIZE (GETPRVAR(GVAR(mapSize),DEFAULT_MAP_SIZE))
#define DRAW_STYLE (GETPRVAR(GVAR(drawStyle),"paper"))

// Setters
#define MAP_XPOS_SET(var) (SETPRVAR(GVAR(mapPosX),var))
#define MAP_YPOS_SET(var) (SETPRVAR(GVAR(mapPosY),var))
#define MAP_SIZE_SET(var) (SETPRVAR(GVAR(mapSize),var))
#define DRAW_STYLE_SET(var) (SETPRVAR(GVAR(drawStyle),var))

// Display control ID defines.
#define FOLDMAP (GETUVAR(GVAR(foldMap),nil))
#define MOVEME (GETUVAR(GVAR(foldMapMovingDialog),nil))
#define BACKGROUND 23
#define DAYMAP 40
#define DAYMAP_ZOOM_1 41
#define DAYMAP_ZOOM_2 42
#define NIGHTMAP 43
#define NIGHTMAP_ZOOM_1 44
#define NIGHTMAP_ZOOM_2 45
#define STATUSBAR 30
#define STATUSRIGHT 31
#define STATUSLEFT 32
