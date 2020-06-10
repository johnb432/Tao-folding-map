#include "\x\cba\addons\main\script_macros_common.hpp"
#include "\x\cba\addons\xeh\script_xeh.hpp"

//This part includes parts of the CBA/ACE3 macro library

#define GETVAR_SYS(var1,var2) getVariable [ARR_2(QUOTE(var1),var2)]
#define SETVAR_SYS(var1,var2) setVariable [ARR_2(QUOTE(var1),var2)]
#define SETPVAR_SYS(var1,var2) setVariable [ARR_3(QUOTE(var1),var2,true)]

#undef GETVAR
#define GETVAR(var1,var2,var3) (var1 GETVAR_SYS(var2,var3))
#define GETMVAR(var1,var2) (missionNamespace GETVAR_SYS(var1,var2))
#define GETUVAR(var1,var2) (uiNamespace GETVAR_SYS(var1,var2))
#define GETPRVAR(var1,var2) (profileNamespace GETVAR_SYS(var1,var2))
#define GETPAVAR(var1,var2) (parsingNamespace GETVAR_SYS(var1,var2))

#undef SETVAR
#define SETVAR(var1,var2,var3) var1 SETVAR_SYS(var2,var3)
#define SETPVAR(var1,var2,var3) var1 SETPVAR_SYS(var2,var3)
#define SETMVAR(var1,var2) missionNamespace SETVAR_SYS(var1,var2)
#define SETUVAR(var1,var2) uiNamespace SETVAR_SYS(var1,var2)
#define SETPRVAR(var1,var2) profileNamespace SETVAR_SYS(var1,var2)
#define SETPAVAR(var1,var2) parsingNamespace SETVAR_SYS(var1,var2)

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
#define SAFEZONE_X safeZoneX
#define SAFEZONE_Y safeZoneY
#define SAFEZONE_H safeZoneH
#define SAFEZONE_W safeZoneW
#define DEFAULT_MAP_XPOS (SAFEZONE_X + (SAFEZONE_W * 0.035))
#define DEFAULT_MAP_YPOS (SAFEZONE_Y + (SAFEZONE_H * 0.304))
#define SHAKETIME 0.4

// Relative positioning defines.
#define MAP_XPOS (GETPRVAR(mapPosX, DEFAULT_MAP_XPOS))
#define MAP_YPOS (GETPRVAR(mapPosY, DEFAULT_MAP_YPOS))
#define BACK_XPOS (MAP_XPOS - (SAFEZONE_H * 0.093))
#define BACK_YPOS (MAP_YPOS - (SAFEZONE_H * 0.046))
#define STATUS_YOFFSET (SAFEZONE_H * 0.015)
#define STATUSTEXT_YOFFSET (STATUS_YOFFSET + (SAFEZONE_H * 0.001))

// Display control ID defines.
#define FOLDMAP (GETUVAR(Tao_FoldMap, nil))
#define MOVEME (GETUVAR(Tao_FoldMap_MovingDialog, nil))
#define BACKGROUND 23
#define DAYMAP 40
#define NIGHTMAP 41
#define STATUSBAR 30
#define STATUSRIGHT 31
#define STATUSLEFT 32