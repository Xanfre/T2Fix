/******************************************************************************
 *  ScriptModule.cpp
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

#include "ScriptModule.h"
#include "Allocator.h"

#include <cstring>
#ifdef _MSC_VER
#include <new>
#endif

#include <lg/scrmanagers.h>
#include <lg/malloc.h>
#include <windows.h>

#define SHIM_LOAD_OSM "miss16_aux.osm"

#ifdef _MSC_VER
namespace std { const nothrow_t nothrow = nothrow_t(); }
#endif

static int __cdecl NullPrintf(const char*, ...);

IMalloc *g_pMalloc = NULL;
IScriptMan *g_pScriptManager = NULL;
#ifdef __GNUC__
volatile MPrintfProc g_pfnMPrintf = NullPrintf;
#else
MPrintfProc g_pfnMPrintf = NullPrintf;
#endif

cMemoryAllocator g_Allocator;
cScriptModule  g_ScriptModule;

static int __cdecl NullPrintf(const char*, ...)
{
	return 0;
}

cScriptModule::~cScriptModule()
{
	if (m_pszName != sm_ScriptModuleName)
		delete[] m_pszName;
	// This is unnecessary, but cleanly couples the main and auxiliary module.
	if (g_pScriptManager)
		g_pScriptManager->RemoveModule(SHIM_LOAD_OSM);
#ifdef DEBUG
	g_pfnMPrintf("cMemoryAllocator: Current %ld blocks for %ld bytes\n", g_Allocator.CountBlocks(), g_Allocator.CountSize());
	g_pfnMPrintf("cMemoryAllocator: Total %ld allocations avg %ld bytes\n", g_Allocator.CountAlloc(), g_Allocator.CountAverage());
#endif
}

cScriptModule::cScriptModule()
{
	m_pszName = const_cast<char*>(sm_ScriptModuleName);
}

void cScriptModule::SetName(const char* pszName)
{
	if (m_pszName != sm_ScriptModuleName)
		delete[] m_pszName;
	if (pszName)
	{
		m_pszName = new char[::strlen(pszName)+1];
		::strcpy(m_pszName, pszName);
	}
	else
		m_pszName = const_cast<char*>(sm_ScriptModuleName);
}

STDMETHODIMP_(const char*) cScriptModule::GetName(void)
{
	return m_pszName;
}

const sScrClassDesc* cScriptModule::GetScript(unsigned int i)
{
	if (i < sm_ScriptsArraySize)
		return &sm_ScriptsArray[i];
	else
		return NULL;
}

STDMETHODIMP_(const sScrClassDesc*) cScriptModule::GetFirstClass(tScrIter* pIterParam)
{
	*reinterpret_cast<unsigned int*>(pIterParam) = 0;
	return GetScript(0);
}

STDMETHODIMP_(const sScrClassDesc*) cScriptModule::GetNextClass(tScrIter* pIterParam)
{
	const sScrClassDesc *pRet;
	REGISTER unsigned int index = *reinterpret_cast<unsigned int*>(pIterParam);
	pRet = GetScript(++index);
	*reinterpret_cast<unsigned int*>(pIterParam) = index;
	return pRet;
}

STDMETHODIMP_(void) cScriptModule::EndClassIter(tScrIter*)
{
	// Nothing to do here
}


extern "C"
int __declspec(dllexport) __stdcall
ScriptModuleInit (const char* pszName,
                  IScriptMan* pScriptMan,
                  MPrintfProc pfnMPrintf,
                  IMalloc* pMalloc,
                  IScriptModule** pOutInterface)
{
	*pOutInterface = NULL;

	g_pScriptManager = pScriptMan;
	g_pMalloc = g_Allocator.AttachMalloc(pMalloc, cScriptModule::sm_ScriptModuleName);

	if (pfnMPrintf)
		g_pfnMPrintf = pfnMPrintf;

	if (!g_pScriptManager || !g_pMalloc)
		return 0;

	g_ScriptModule.SetName(pszName);
	g_ScriptModule.QueryInterface(IID_IScriptModule, reinterpret_cast<void**>(pOutInterface));

	g_pScriptManager->AddModule(SHIM_LOAD_OSM);

	return 1;
}

extern "C"
BOOL WINAPI
DllMain (HINSTANCE hDLL, DWORD dwReason, PVOID lpResv)
{
	if (dwReason == DLL_PROCESS_ATTACH)
	{
		::DisableThreadLibraryCalls(hDLL);
		return TRUE;
	}
	return TRUE;
#ifdef __GNUC__
	lpResv = lpResv;
#endif
#ifdef __BORLANDC__
#pragma argsused(hDLL,dwReason)
#endif
}
