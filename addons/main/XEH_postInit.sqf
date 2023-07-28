#include "script_component.hpp"

// CBA keybinds
#include "initKeybinds.sqf"

// Make sure data exists, sometimes it fails
if (GETPRVAR("igui_grid_tao_folding_map_rewrite_x",0) == 0) then {
    MAP_XPOS_SET(POS_X(5));
    WARNING("Restored x to default value.");
};

if (GETPRVAR("igui_grid_tao_folding_map_rewrite_y",0) == 0) then {
    MAP_YPOS_SET(POS_Y(5));
    WARNING("Restored y to default value.");
};

if (GETPRVAR("igui_grid_tao_folding_map_rewrite_w",0) == 0) then {
    MAP_WIDTH_SET(POS_W(20));
    WARNING("Restored w to default value.");
};

if (GETPRVAR("igui_grid_tao_folding_map_rewrite_h",0) == 0) then {
    MAP_HEIGHT_SET(POS_H(20));
    WARNING("Restored h to default value.");
};
