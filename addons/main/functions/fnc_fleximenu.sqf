#include "script_component.hpp"
/*
 * Author: johnb43
 * Menu definition.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call tao_rewrite_main_fnc_fleximenu;
 *
 * Public: No
 */

[
   ["main", "Tao's Folding Map Rewrite", "popup"],
   [
      [
         "Reposition map", // text on button
         {
            MOVEME closeDisplay 0;
            createDialog "Tao_FoldMap_MovingDialog";
         }, // code to run
         "", // icon
         "", // tooltip
         [], // submenu
         DIK_R, // shortcut key
         GVAR(enableMap) && GVAR(isOpen) && GVAR(reposMap), // enabled?
         true // visible if true
      ],

      [
         // Change to tablet/paper
         format ["Change to %1", ["tablet", "paper"] select (GETPRVAR(drawStyle, "paper") == "tablet")], // text on button
         {
             private _type = ["tablet", "paper"] select (GETPRVAR(drawStyle, "paper") == "tablet");

             // Save new style to profile namespace.
             SETPRVAR(drawStyle, _type);
             GVAR(drawPaper) = [false, true] select (_type == "paper");

             if (GVAR(isOpen)) then {
                 call FUNC(refreshMap);
             };
         }, // code to run
         "", // icon
         "", // tooltip
         [], // submenu
         DIK_C, // shortcut key
         GVAR(enableMap) && GVAR(isOpen) && GVAR(mapTypeUnlocked), // enabled?
         true // visible if true
      ],

      [
         // Switch to day/night mode
         format ["Switch to %1", ["night mode", "day mode"] select (GVAR(isNightMap))], // text on button
         {call FUNC(nvMode)}, // code to run
         "", // icon
         "", // tooltip
         [], // submenu
         DIK_S, // shortcut key
         GVAR(enableMap) && GVAR(isOpen) && !GVAR(drawPaper), // enabled?
         true // visible if true
      ]
   ]
];
