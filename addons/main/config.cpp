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
            "A3_UI_F"
        };
        author = "johnb43";
        authors[] = {"johnb43", "Taosenai"};
        url = "https://github.com/johnb432/Tao-folding-map";
        VERSION_CONFIG;
    };
};

class CfgMods {
    class Mod_Base;
    class PREFIX: Mod_Base {
        name = "Tao's Folding Map Rewrite";
        author = "johnb43";
        tooltip = "Tao's Folding Map Rewrite";
        tooltipOwned = "Tao's Folding Map Rewrite";
        hideName = 0;
        hidePicture = 0;
        dir = "@tao_rewrite";
        actionName = "Github";
        action = "https://github.com/johnb432/Tao-folding-map";
        description = "Adds a small map/tablet similar but bigger than the Vanilla GPS. Originally made Taosenai, continued by johnb43.";
        overview = "Adds a small map/tablet similar but bigger than the Vanilla GPS. Originally made Taosenai, continued by johnb43.";
        picture = "\x\tao_rewrite\addons\main\ui\logo_tao_folding_map.paa";
        logo = "\x\tao_rewrite\addons\main\ui\logo_tao_folding_map.paa";
        logoOver = "\x\tao_rewrite\addons\main\ui\logo_tao_folding_map.paa";
        logoSmall = "\x\tao_rewrite\addons\main\ui\logo_tao_folding_map.paa";
        overviewPicture = "\x\tao_rewrite\addons\main\ui\logo_tao_folding_map.paa";
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgRsc.hpp"
#include "CfgUIGrids.hpp"
