/******************************************************************************
 *  Script.cpp
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
#include "Script.h"

#include <cstring>


cScript::~cScript()
{
}

cScript::cScript(const char* pszName, int iHostObjId)
	    : m_szName(pszName), m_iObjId(iHostObjId)
{
	if (m_szName == NULL)
		m_szName = "cScript";
}

STDMETHODIMP_(const char*) cScript::GetClassName(void)
{
	// Name MUST match the one in the list.
	// Still, we don't want to toss a NULL pointer around, do we?
	return Name();
}

STDMETHODIMP cScript::ReceiveMessage(sScrMsg*, sMultiParm*, eScrTraceAction)
{
	long iRet = 0;
	/*
	if (!::_stricmp(pMsg->message, "ScriptPtrQuery"))
	{
		iRet = ScriptPtrQuery(static_cast<sPtrQueryMsg*>(pMsg));
	}
	*/
	return iRet;
}

/*
long cScript::ScriptPtrQuery(sPtrQueryMsg* pMsg)
{
	// Check class name
	if (!::_stricmp(pMsg->pszDestClass, GetClassName()))
	{
		*(pMsg->pScriptReceptacle) = reinterpret_cast<void*>(this);
		return 0;
	}
	return 1;
}
*/

