#define COMPONENT main
#define COMPONENT_BEAUTIFIED Main
#include "\x\tao_rewrite\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define CBA_DEBUG_SYNCHRONOUS
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_TAOMAP
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_TAOMAP
    #define DEBUG_SETTINGS DEBUG_SETTINGS_TAOMAP
#endif

#include "\x\tao_rewrite\addons\main\script_macros.hpp"

// Include BI DIK codes.
#include "\a3\ui_f\hpp\defineDIKCodes.inc"