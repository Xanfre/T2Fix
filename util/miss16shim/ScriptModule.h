/******************************************************************************
 *  ScriptModule.h
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

#include <lg/config.h>
#include <lg/objstd.h>
#include <lg/interfaceimp.h>
#include <lg/script.h>
#include <lg/scrmanagers.h>

extern IMalloc *g_pMalloc;
extern IScriptMan *g_pScriptManager;

typedef int (__cdecl *MPrintfProc)(const char*, ...);
#ifdef __GNUC__
// GCC 3.3 is foolishly trying to optimize away the dereference here.
extern volatile MPrintfProc g_pfnMPrintf;
#else
extern MPrintfProc g_pfnMPrintf;
#endif
extern "C" int __declspec(dllexport) __stdcall ScriptModuleInit(const char*,IScriptMan*,MPrintfProc,IMalloc*,IScriptModule**);

class cScriptModule : public cInterfaceImp<IScriptModule,IID_Def<IScriptModule>,kInterfaceImpStatic>
{
public:
	// IUnknown
	//STDMETHOD(QueryInterface)(REFIID,void**);
	//STDMETHOD_(ULONG,AddRef)(void);
	//STDMETHOD_(ULONG,Release)(void);
	// IScriptModule
	STDMETHOD_(const char*,GetName)(void);
	STDMETHOD_(const sScrClassDesc*,GetFirstClass)(tScrIter*);
	STDMETHOD_(const sScrClassDesc*,GetNextClass)(tScrIter*);
	STDMETHOD_(void,EndClassIter)(tScrIter*);

	virtual ~cScriptModule();
	cScriptModule();
	//cScriptModule(const char* pszName);

	void SetName(const char* pszName);

private:
	const sScrClassDesc* GetScript(unsigned int i);

	char* m_pszName;
	static const sScrClassDesc sm_ScriptsArray[];
	static const unsigned int sm_ScriptsArraySize;

protected:
	static const char* sm_ScriptModuleName;

	friend int __declspec(dllexport) __stdcall ScriptModuleInit(const char*,IScriptMan*,MPrintfProc,IMalloc*,IScriptModule**);
};
