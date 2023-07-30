#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "cba_main",
            "cba_xeh",
            "A3_Data_F_AoW_Loadorder"
        };
        author = "johnb43, Taosenai";
        authors[] = {"johnb43", "Taosenai"};
        url = "https://github.com/johnb432/Tao-folding-map";
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgUIGrids.hpp"
#include "CfgVersioning.hpp"
#include "gui.hpp"
