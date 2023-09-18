/******************************************************************************
 *  ScriptDef.cpp
 *
 *  This file is part of Public Scripts
 *  Copyright (C) 2005-2011 Tom N Harris <telliamed@whoopdedo.org>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program. If not, see <http://www.gnu.org/licenses/>.
 *
 *****************************************************************************/
#include "genscripts.h"

#if !SCR_GENSCRIPTS
#define OSM_NAME	"script"

#include "ScriptModule.h"
#endif // SCR_GENSCRIPTS

/**************************
 * This interesting little mess of nested includes is used to auto-magically
 * create the script factory functions and script array for cScriptModule.
 *
 * It will parse your script class headers three times:
 *     - Once to get all the class declarations. No special macros.
 *     - Second with the macro SCR_GENSCRIPTFACTORY defined to create the
 *       factory functions.
 *     - Third with the macro SCR_GENSCRIPTARRAY defined to fill the array.
 *
 * The macro SCR_GENSCRIPTS will be set to the pass number, starting at 0.
 * Use this to bracket your class declarations. When SCR_GENSCRIPTS is
 * defined and non-zero, you _ONLY_ want to use the macro GEN_FACTORY.
 * It takes three arguments, the name of a script, the base class for
 * the script, and the C++ class of the script. There's also a GEN_ALIAS
 * macro for giving a script an additional name. It has the same arguments
 * as GEN_FACTORY, plus an extra tag to distinguish the alias from the
 * original. (Because of a quirk in how the scripts are instantiated,
 * aliases each have to use a different factory function.)
 *
 * Customize this file by modifying the OSM_NAME macro above, and insert any
 * extra includes in the area that is guarded with SCR_GENSCRIPTS.
 * Then include the necessary script headers just below here. And by the magic
 * of recursion, everything will be automatically generated.
 *
 * Note that the factories this generates are static non-member functions.
 * This is because GCC doesn't like to ## a class name to a member definition.
 * A little annoying. But there's no compelling reason that the factory has
 * to be a member. Plus, it frees you from having to write the factory into your
 * class definition.
 */
#include "BaseScript.h"
#if (_DARKGAME == 2)
#include "miss16shim.h"
#endif

#undef BASESCRIPT_H
#undef T2MPSCRIPTS_H

#if defined(SCR_GENSCRIPTFACTORY)

#undef SCR_GENSCRIPTFACTORY
#define SCR_GENSCRIPTARRAY

const char* cScriptModule::sm_ScriptModuleName = OSM_NAME;
const sScrClassDesc cScriptModule::sm_ScriptsArray[] = {
#include __FILE__
#elif defined(SCR_GENSCRIPTARRAY)
};
const unsigned int cScriptModule::sm_ScriptsArraySize = sizeof(sm_ScriptsArray)/sizeof(sm_ScriptsArray[0]);

#else // First-time through
#define SCR_GENSCRIPTFACTORY

#include __FILE__

#endif
