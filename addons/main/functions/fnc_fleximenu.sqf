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
 * [] call tao_rewrite_main_fnc_fleximenu;
 *
 * Public: No
 */

[
  ["main", "Tao's Folding Map Rewrite", "popup"],
  [
    [
      "Reposition map", // text on button
      {[] call FUNC(reposition)}, // code to run
      "", // icon
      "", // tooltip
      [], // submenu
      DIK_R, // shortcut key
      GVAR(reposmap) , // enabled?
      true // visible if true
    ],

    [
    	// Change to tablet/paper
      format ["Change to %1", [] call FUNC(getNotSelectedStyleName)], // text on button
      {[[] call FUNC(getNotSelectedStyleName)] call FUNC(changeType)}, // code to run
      "", // icon
      "", // tooltip
      [], // submenu
      DIK_C, // shortcut key
      GVAR(maplock), // enabled?
      true // visible if true
    ]
  ]
];