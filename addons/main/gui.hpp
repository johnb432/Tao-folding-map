class RscText;
class RscPicture;
class RscMapControl;
class RscControlsGroupNoScrollbars;
class RscTitles {
    class GVAR(foldMap) {
        idd = -1;
        duration = 1000000;
        fadeIn = 0;
        fadeOut = 0;
        onLoad = QUOTE((_this select 0) call FUNC(onLoadDialog));
        onUnload = "";

        class controls {
            class GVAR(foldMapGroup): RscControlsGroupNoScrollbars {
                idc = IDC_GROUP;
                x = QUOTE(POS_X(5));
                y = QUOTE(POS_Y(5));
                w = QUOTE(POS_W(20));
                h = QUOTE(POS_H(20));
                colorBackground[] = {0, 0, 0, 0};
                colorText[] = {1, 1, 1, 1};
                font = "PuristaMedium";
                sizeEx = 0;
                shadow = 0;
                text = "";

                class controls {
                    // Background picture: base tablet
                    class GVAR(foldMapBackground): RscPicture {
                        idc = IDC_BACKGROUND;
                        type = 0;
                        style = 48;
                        x = 0;
                        y = 0;
                        w = QUOTE(POS_H(20) / RATIO_H_W);
                        h = QUOTE(POS_H(20));
                        colorBackground[] = {0, 0, 0, 0};
                        colorText[] = {1, 1, 1, 1};
                        shadow = 0;
                        text = QPATHTOF(ui\datapad.paa);
                    };

                    // Top bar with dates and gridref: base class
                    class GVAR(foldMapStatusBar): RscText {
                        idc = IDC_STATUSBAR;
                        x = QUOTE(POS_X(6.45));
                        y = QUOTE(POS_Y(0.72));
                        w = QUOTE(POS_W(12.4));
                        h = QUOTE(POS_H(0.7));
                        colorBackground[] = {0.09, 0.1, 0.13, 1};
                        colorText[] = {1, 1, 1, 1};
                        sizeEx = 0.01;
                        font = "PuristaMedium";
                        size = 2.3;
                        shadow = 2;
                        style = 1;
                        text = "";
                    };

                    // Top bar with date
                    class GVAR(foldMapStatusBarTextRight): GVAR(foldMapStatusBar) {
                        idc = IDC_STATUSRIGHT;
                        colorBackground[] = {1, 0, 0, 0};
                    };

                    // Top bar with gridref
                    class GVAR(foldMapStatusBarTextLeft): GVAR(foldMapStatusBar) {
                        idc = IDC_STATUSLEFT;
                        w = QUOTE(POS_W(6.2));
                        colorBackground[] = {1, 0, 0, 0};
                        style = 0;
                    };

                    // Map itself
                    class GVAR(dayMap): RscMapControl {
                        idc = IDC_DAYMAP;
                        x = QUOTE(MAP_XPOS);
                        y = QUOTE(MAP_YPOS);
                        w = QUOTE(MAP_WIDTH);
                        h = QUOTE(MAP_HEIGHT);
                        type = 101;
                        style = 48;
                        colorLevels[] = {0.65, 0.6, 0.55, 1};
                        colorSea[] = {0.46, 0.65, 0.74, 0.5};
                        colorForest[] = {0.02, 0.5, 0.01, 0.3};
                        colorForestBorder[] = {0.02, 0.5, 0.01, 0.27};
                        colorRocks[] = {0, 0, 0, 0.3};
                        colorCountlines[] = {0.65, 0.45, 0.27, 0.7};
                        colorMainCountlines[] = {1, 0.1, 0.1, 0.9};
                        colorCountlinesWater[] = {0.25, 0.4, 0.5, 0.3};
                        colorMainCountlinesWater[] = {0.25, 0.4, 0.5, 0.9};
                        colorBuildings[] = {0.541, 0.216, 0.204, 0.95};
                        colorBuilding[] = {0.541, 0.216, 0.204, 0.95};
                        colorStructures[] = {0.541, 0.216, 0.204, 0.95};
                        colorPowerLines[] = {0.1, 0.1, 0.1, 1};
                        colorRailWay[] = {0.8, 0.2, 0, 1};
                        colorTracks[] = {0.84, 0.76, 0.65, 0.15};
                        colorTracksFill[] = {0.84, 0.76, 0.65, 1};
                        colorRoads[] = {0.7, 0.7, 0.7, 1};
                        colorRoadsFill[] = {1, 1, 1, 1};
                        colorMainRoads[] = {0.9, 0.5, 0.3, 1};
                        colorMainRoadsFill[] = {1, 0.62, 0.4, 1};
                        colorRocksBorder[] = {0, 0, 0, 0};
                        colorNames[] = {0.1, 0.1, 0.1, 0.9};
                        colorInactive[] = {1, 1, 1, 0.5};
                        colorOutside[] = {0.7, 0.5, 0.5, 1};
                        colorBackground[] = {1, 1, 0.85, 0.95};
                        colorText[] = {1, 1, 1, 0.85};
                        colorGrid[] = {0.1, 0.1, 0.1, 0.6};
                        colorGridMap[] = {0.1, 0.1, 0.1, 0.6};
                        text = "#(argb,8,8,3)color(1,1,1,1)";
                        font = "PuristaMedium";
                        sizeEx = 0.027;
                        scaleMin = 1e-006;
                        scaleMax = 1000;
                        scaleDefault = 0.18;
                        stickX[] = {0.2, {"Gamma", 1, 1.5}};
                        stickY[] = {0.2, {"Gamma", 1, 1.5}};
                        ptsPerSquareSea = 6;
                        ptsPerSquareTxt = 8;
                        ptsPerSquareCLn = 8;
                        ptsPerSquareExp = 8;
                        ptsPerSquareCost = 8;
                        ptsPerSquareFor = "4.0f";
                        ptsPerSquareForEdge = "10.0f";
                        ptsPerSquareRoad = 2;
                        ptsPerSquareObj = 10;
                        fontLabel = "PuristaMedium";
                        sizeExLabel = 0.027;
                        fontGrid = "EtelkaMonospaceProBold";
                        sizeExGrid = 0.022;
                        fontUnits = "PuristaMedium";
                        sizeExUnits = 0.031;
                        fontNames = "PuristaMedium";
                        sizeExNames = 0.056;
                        fontInfo = "PuristaMedium";
                        sizeExInfo = 0.0301;
                        fontLevel = "PuristaMedium";
                        sizeExLevel = 0.021;
                        maxSatelliteAlpha = 0;
                        alphaFadeStartScale = 0.1;
                        alphaFadeEndScale = 3;
                        showCountourInterval = 0;
                        onMouseButtonClick = "";
                        onMouseButtonDblClick = "";
                    };

                    // Night map
                    class GVAR(nightMap): GVAR(dayMap) {
                        idc = IDC_NIGHTMAP;
                        colorLevels[] = {0.016, 0.004, 0, 1};
                        colorSea[] = {0.208, 0.05, 0.043, 0.5};
                        colorForest[] = {0.447, 0.122, 0.137, 0.3};
                        colorForestBorder[] = {0.447, 0.122, 0.137, 0.27};
                        colorRocks[] = {0, 0, 0, 0.4};
                        colorCountlines[] = {0.371, 0.124, 0.122, 0.75};
                        colorMainCountlines[] = {0.371, 0.124, 0.122, 0.9};
                        colorCountlinesWater[] = {0.371, 0.124, 0.122, 0.55};
                        colorMainCountlinesWater[] = {0.371, 0.124, 0.122, 0.6};
                        colorTracks[] = {0.447, 0.122, 0.137, 0.15};
                        colorTracksFill[] = {0.467, 0.142, 0.15, 1};
                        colorRoads[] = {0.227, 0.055, 0.051, 1};
                        colorRoadsFill[] = {0.227, 0.055, 0.051, 0.85};
                        colorMainRoads[] = {0.286, 0.071, 0.067, 1};
                        colorMainRoadsFill[] = {0.286, 0.071, 0.067, 0.85};
                        colorPowerLines[] = {0.74, 0.47, 0.49, 0.9};
                        colorRailWay[] = {0.506, 0.235, 0.25, 0.9};
                        colorBuildings[] = {0.541, 0.216, 0.204, 0.95};
                        colorRocksBorder[] = {0, 0, 0, 0.3};
                        colorNames[] = {0.85, 0.62, 0.61, 0.9};
                        colorInactive[] = {0.8, 0.7, 0.7, 0.5};
                        colorOutside[] = {0, 0, 0, 1};
                        colorBackground[] = {0.036, 0.024, 0.02, 0.95};
                        colorText[] = {0.84, 0.61, 0.6, 0.85};
                        colorGrid[] = {0.371, 0.124, 0.122, 0.5};
                        colorGridMap[] = {0.371, 0.124, 0.122, 0.5};
                    };
                };
            };
        };
    };
};
