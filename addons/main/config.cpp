#include "script_component.hpp"

class CfgPatches {
   	class ADDON {
      		name = COMPONENT_NAME;
      		units[] = {};
      		weapons[] = {};
      		requiredVersion = REQUIRED_VERSION;
      		requiredAddons[] = {"cba_main", "cba_xeh", "A3_UI_F"};
      		authors[] = {"Taosenai", "johnb43"};
      		authorUrl = "http://ryanschultz.org/tmr/foldmap/";
      		VERSION_CONFIG;
   	};
};
class CfgMods {
    class PREFIX {
        dir = "@tao";
        name = "Tao's folding map";
        hideName = "true";
        actionName = "GitHub";
        action = "https://github.com/johnb432/TAO_rewrite";
        description = "Tao's folding map";
    };
};
class RscText;
class RscPicture;
class RscButton;
class RscMapControl;
class RscTitles {
   	class Tao_FoldMap {
      		idd = -1;
      		duration = 1000000;
      		fadeIn = 0;
      		fadeOut = 0;
      		onLoad = QUOTE(with uiNameSpace do {Tao_FoldMap = _this select 0}; call FUNC(onLoadDialog););
      		onUnload = "";
      		controls[] = {
         			"Tao_FoldMapBack",
         			"Tao_FoldMapStatusBar",
         			"Tao_FoldMapStatusBarTextRight",
         			"Tao_FoldMapStatusBarTextLeft",
         			"Tao_Foldmap",
         			"Tao_Foldmap_NightRed"
      		};
      		//background picture: base tablet
      		class Tao_FoldMapBack: RscPicture {
         			idc = 23;
         			type = 0;
         			style = 48;
         			x = QUOTE(SAFEZONE_X);
         			y = QUOTE(SAFEZONE_Y);
         			w = QUOTE(SAFEZONE_H * 0.55);
         			h = QUOTE(SAFEZONE_H * 0.745);
         			colorBackground[] = {0, 0, 0, 0};
         			colorText[] = {1, 1, 1, 1};
         			shadow = 0;
         			text = "\x\tao_rewrite\addons\main\data\datapad_ca.paa";
      		};
      		//Top bar with dates and gridref: base class
      		class Tao_FoldMapStatusBar: RscText {
         			idc = 30;
         			style = 1;
         			x = QUOTE(SAFEZONE_X);
         			y = QUOTE(SAFEZONE_Y);
         			w = QUOTE(SAFEZONE_H * 0.363);
         			h = QUOTE(SAFEZONE_H * 0.015);
         			colorBackground[] = {0.09, 0.1, 0.13, 1};
         			colorText[] = {1, 1, 1, 1};
         			sizeEx = "0.015 / (getResolution select 5)";
         			font = "PuristaMedium";
         			size = 2.3;
         			shadow = 2;
         			text = "";
      		};
      		//Top bar with date
      		class Tao_FoldMapStatusBarTextRight: Tao_FoldMapStatusBar {
         			idc = 31;
         			colorBackground[] = {1, 0, 0, 0};
      		};
        //Top bar with gridref
      		class Tao_FoldMapStatusBarTextLeft: Tao_FoldMapStatusBar {
         			idc = 32;
         			style = 0;
         			colorBackground[] = {1, 0, 0, 0};
      		};
      		class Tao_FoldMap: RscMapControl {
         			idc = 40;
         			x = QUOTE(SAFEZONE_X);
         			y = QUOTE(SAFEZONE_Y);
         			w = QUOTE(SAFEZONE_H * 0.363);
         			h = QUOTE(SAFEZONE_H * 0.629);
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
         			stickX[] = {0.2, {
            					"Gamma",
            					1,
            					1.5
            				}
         			};
         			stickY[] = {0.2, {
            					"Gamma",
            					1,
            					1.5
            				}
         			};
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
      		class Tao_Foldmap_NightRed: Tao_FoldMap {
         			idc = 41;
         			type = 101;
         			style = 48;
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
         			text = "#(argb,8,8,3)color(0,0,0,1)";
         			font = "PuristaMedium";
         			sizeEx = 0.027;
         			scaleMin = 1e-006;
         			scaleMax = 1000;
         			scaleDefault = 0.18;
         			stickX[] = {0.2, {
            					"Gamma",
            					1,
            					1.5
            				}
         			};
         			stickY[] = {0.2, {
            					"Gamma",
            					1,
            					1.5
            				}
         			};
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
         			sizeExUnits = 0.0301;
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
   	};
};
class Tao_Foldmap_MovingDialog {
   	idd = -1;
   	movingEnable = 1;
   	enableSimulation = 1;
   	onLoad = QUOTE(with uiNameSpace do {Tao_FoldMap_MovingDialog = _this select 0;}; call FUNC(onLoadMovingDialog););
   	onUnload = "";
   	controlsBackground[] = {"MoveMeBack"};
   	controls[] = {
      		"MoveMe",
      		"ConfirmButton"
   	};

   	class MoveMeBack: RscText {
      		idc = 10;
      		moving = 1;
      		colorBackground[] = {0.1, 1, 0.1, 0.6};
      		colorText[] = {0, 0, 0, 1};
      		x = QUOTE(SAFEZONE_X);
      		y = QUOTE(SAFEZONE_Y);
      		w = QUOTE(SAFEZONE_H * 0.363);
      		h = QUOTE(SAFEZONE_H * 0.629);
   	};
   	class MoveMe: RscText {
      		idc = 11;
      		style = 2;
      		moving = 0;
      		colorBackground[] = {0, 0, 0, 0};
      		colorText[] = {0, 0, 0, 1};
      		lineSpacing = 1.1;
      		shadow = 0;
      		text = "Move me. Press Esc to cancel.";
      		x = QUOTE(SAFEZONE_X);
      		y = QUOTE(SAFEZONE_Y);
      		w = QUOTE(SAFEZONE_H * 0.1815);
      		h = QUOTE(SAFEZONE_H * 0.07548);
   	};
   	class ConfirmButton: RscButton {
      		idc = 12;
      		moving = 0;
      		x = QUOTE(SAFEZONE_X);
      		y = QUOTE(SAFEZONE_Y);
      		w = QUOTE(SAFEZONE_H * 0.1815);
      		h = QUOTE(SAFEZONE_H * 0.03145);
      		colorBackground[] = {0, 0, 0, 0.5};
      		text = "Confirm";
      		onButtonClick = QUOTE(0 = call FUNC(confirmMove));
   	};
};

#include "CfgEventHandlers.hpp"
