// COMPONENT should be defined in the script_component.hpp and included BEFORE this hpp

#define MAINPREFIX x
#define PREFIX tao_rewrite

#include "script_version.hpp"

#define VERSION     MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_STR MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR  MAJOR,MINOR,PATCHLVL,BUILD

#define TAO_REWRITE_TAG TAO_REWRITE

// MINIMAL required version for the Mod. Components can specify others..
#define REQUIRED_VERSION 1.96
#define REQUIRED_CBA_VERSION {3,12,2}

#ifdef COMPONENT_BEAUTIFIED
    #define COMPONENT_NAME QUOTE(tao_rewrite - COMPONENT_BEAUTIFIED)
#else
    #define COMPONENT_NAME QUOTE(tao_rewrite - COMPONENT)
#endif