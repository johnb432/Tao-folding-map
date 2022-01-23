class CfgUIGrids {
    class IGUI {
        class Presets {
            class Arma3 {
                class Variables {
                    grid_tao_folding_map_rewrite[] = {
                        {
                            QUOTE(safezoneX + safezoneW - POS_W(11)), // x
                            QUOTE(safezoneY + safezoneH - POS_H(15)), // y
                            QUOTE(POS_H(10) / RATIO_H_W), // w
                            QUOTE(POS_H(10)) // h
                        },
                        QUOTE(pixelW / RATIO_H_W), // steps for changing width
                        QUOTE(pixelW) // steps for changing height
                    };
                };
            };
        };

        class Variables {
            class grid_tao_folding_map_rewrite {
                canResize = 1;
                description = "When resizing, it will take only the height into account, as a fixed ratio is required between height and width.";
                displayName = COMPONENT_NAME;
                preview = QPATHTOF(ui\paper.paa);
                saveToProfile[] = {0, 1, 2, 3};
            };
        };
    };
};
