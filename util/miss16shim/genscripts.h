/******************************************************************************
 *  genscripts.h
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

#undef SCR_GENSCRIPTS
#undef GEN_FACTORY
#undef GEN_ALIAS

#if defined(SCR_GENSCRIPTARRAY)
#define SCR_GENSCRIPTS 2
#define GEN_FACTORY(__NAME,__BASE,__CLASS)	\
	{ sm_ScriptModuleName , __NAME , __BASE , __CLASS##_ScriptFactory },
#define GEN_ALIAS(__NAME,__BASE,__CLASS,__TAG)	\
	{ sm_ScriptModuleName , __NAME , __BASE , __CLASS##__TAG##_ScriptFactory },

#elif defined(SCR_GENSCRIPTFACTORY)
#define SCR_GENSCRIPTS 1
#define GEN_FACTORY(__NAME,__BASE,__CLASS)	\
	static IScript* __cdecl __CLASS##_ScriptFactory(const char* pszName, int iHostObjId) \
	{ \
		if (::stricmp(pszName, __NAME) != 0) return NULL; \
		__CLASS * pscrRet = new(std::nothrow) __CLASS(__NAME, iHostObjId); \
		return static_cast<IScript*>(pscrRet); \
	};
#define GEN_ALIAS(__NAME,__BASE,__CLASS,__TAG)	\
	static IScript* __cdecl __CLASS##__TAG##_ScriptFactory(const char* pszName, int iHostObjId) \
	{ \
		if (::stricmp(pszName, __NAME) != 0) return NULL; \
		__CLASS * pscrRet = new(std::nothrow) __CLASS(__NAME, iHostObjId); \
		return static_cast<IScript*>(pscrRet); \
	};

#else

#define SCR_GENSCRIPTS 0
#define GEN_FACTORY(__NAME,__BASE,__CLASS)
#define GEN_ALIAS(__NAME,__BASE,__CLASS,__TAG)

#endif
