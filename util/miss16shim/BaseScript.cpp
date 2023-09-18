/******************************************************************************
 *  BaseScript.cpp
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
#include "BaseScript.h"
#include "ScriptModule.h"

#include <lg/interface.h>
#include <lg/scrmanagers.h>

#ifdef _MSC_VER
#define snprintf _snprintf
#endif

#ifdef __BORLANDC__
/* The free BCC doesn't include TASM. */
/* We could use this all the time, but it's easier to debug if we break directly. */
#define DO_BREAK	::DebugBreak()
#elif defined(__GNUC__)
#define DO_BREAK	asm("int 3")
#else
#define DO_BREAK	_asm{int 3}
#endif

cBaseScript::cBaseScript(const char* pszName, int iHostObjId)
	: cScript(pszName, iHostObjId),
	  m_bSim(false), m_iMessageTime(0)
{
	SInterface<ISimManager> pSim(g_pScriptManager);
	m_bSim = pSim->LastMsg() & (kSimStart | kSimResume);
}

cBaseScript::~cBaseScript()
{
	for (unsigned int n = 0; n < m_aDynamicHandlers.size(); ++n)
	{
		delete[] m_aDynamicHandlers[n]->pszName;
		delete m_aDynamicHandlers[n];
	}
}

STDMETHODIMP cBaseScript::ReceiveMessage(sScrMsg* pMsg, sMultiParm* pReply, eScrTraceAction eTrace)
{
	long iRet = 0;
	cScript::ReceiveMessage(pMsg, pReply, eTrace);

	switch (eTrace)
	{
	case kSpew:
	{
		char msg[64];
		snprintf(msg, 64, "\"%s\" at %d", pMsg->message, pMsg->time);
		DebugString("Got message ", msg);
		break;
	}
	case kBreak:
	{
		char msg[64];
		snprintf(msg, 64, "\"%s\" at %d", pMsg->message, pMsg->time);
		DebugString("Break on message ", msg);
		DO_BREAK;
		break;
	}
	default:
		break;
	}

	m_iMessageTime = pMsg->time;
	if (!::_stricmp(pMsg->message, "Sim"))
	{
		m_bSim = static_cast<sSimMsg*>(pMsg)->fStarting;
	}

	try
	{
		sMultiParm mpReply;
		// Easier than changing the interface or having umpteen checks for NULL
		if (pReply == NULL)
			pReply = &mpReply;
		iRet = DispatchMessage(pMsg, pReply);
	}
	catch (std::exception& err)
	{
		DebugString("An error occurred, ", err.what());
		iRet = S_FALSE;
	}
	catch (...)
	{
		DebugString("An unknown error occurred.");
		iRet = S_FALSE;
	}
	return iRet;
}

void cBaseScript::RegisterMessageHandlers(const sMessageHandler* pHandlers, uint iCount)
{
	if (iCount == 0)
		return;
	m_aMessageHandlers.resize(m_aMessageHandlers.size() + iCount);
	for (uint n=0; n<iCount; ++n)
	{
		insert_sorted(m_aMessageHandlers, sMessageHandlerNode(pHandlers+n));
	}
}

void cBaseScript::RegisterDynamicMessageHandler(const char* pszName, MessageHandlerProc pfnHandler)
{
	for (uint n = 0; n < m_aDynamicHandlers.size(); ++n)
	{
		if (!::_stricmp(m_aDynamicHandlers[n]->pszName, pszName))
		{
			sMessageHandler* pHandler = m_aDynamicHandlers[n];
			delete[] pHandler->pszName;
			pHandler->pszName = new char[::strlen(pszName)+1];
			::strcpy(const_cast<char*>(pHandler->pszName), pszName);
			pHandler->pfnHandler = pfnHandler;
			// The dynamic sMessageHandler should already be registered.
			return;
		}
	}

	uint n = find_first(m_aMessageHandlers, pszName);
	if (n >= m_aMessageHandlers.size() || m_aMessageHandlers[n] != pszName)
	{
		sMessageHandler* pHandler = new sMessageHandler;
		pHandler->pszName = new char[::strlen(pszName)+1];
		::strcpy(const_cast<char*>(pHandler->pszName), pszName);
		pHandler->pfnHandler = pfnHandler;
		m_aDynamicHandlers.append(pHandler);
		insert_sorted(m_aMessageHandlers, sMessageHandlerNode(pHandler));
	}
}

void cBaseScript::UnregisterMessageHandler(const char* pszName)
{
	for (uint n = 0; n < m_aDynamicHandlers.size(); ++n)
	{
		if (!::_stricmp(m_aDynamicHandlers[n]->pszName, pszName))
		{
			uint m = find_first(m_aMessageHandlers, pszName);
			if (n < m_aMessageHandlers.size()
			 && m_aMessageHandlers[m] == pszName
			 && m_aMessageHandlers[m].pData->pfnHandler == m_aDynamicHandlers[n]->pfnHandler)
			{
				m_aMessageHandlers.erase(m);
			}
			delete[] m_aDynamicHandlers[n]->pszName;
			delete m_aDynamicHandlers[n];
			m_aDynamicHandlers.erase(n);

			break;
		}
	}
}

long cBaseScript::DispatchMessage(sScrMsg* pMsg, sMultiParm* pReply)
{
	uint n = find_first(m_aMessageHandlers, pMsg->message);
	if (n < m_aMessageHandlers.size() && m_aMessageHandlers[n] == pMsg->message)
	{
		return m_aMessageHandlers[n].pData->pfnHandler(this, pMsg, pReply);
	}
	return OnMessage(pMsg, static_cast<cMultiParm&>(*pReply));
}

cMultiParm* cBaseScript::SendMessage(cMultiParm& mpReply, object iDest, const char* pszMessage, const cMultiParm& mpData1, const cMultiParm& mpData2, const cMultiParm& mpData3)
{
	return g_pScriptManager->SendMessage2(mpReply, ObjId(), iDest, pszMessage, mpData1, mpData2, mpData3);
}

void cBaseScript::PostMessage(object iDest, const char* pszMessage, const cMultiParm& mpData1, const cMultiParm& mpData2, const cMultiParm& mpData3)
{
#if (_DARKGAME == 1)
	g_pScriptManager->PostMessage2(ObjId(), iDest, pszMessage, mpData1, mpData2, mpData3);
#else
	g_pScriptManager->PostMessage2(ObjId(), iDest, pszMessage, mpData1, mpData2, mpData3, kScrMsgPostToOwner);
#endif
}

tScrTimer cBaseScript::SetTimedMessage(const char* pszName, ulong iTime, eScrTimedMsgKind eType, const cMultiParm& mpData)
{
	return g_pScriptManager->SetTimedMessage2(ObjId(), pszName, iTime, eType, mpData);
}

void cBaseScript::KillTimedMessage(tScrTimer hTimer)
{
	g_pScriptManager->KillTimedMessage(hTimer);
}

bool cBaseScript::IsScriptDataSet(const char* pszName)
{
	sScrDatumTag tag;
	tag.objId = ObjId();
	tag.pszClass = Name();
	tag.pszName = pszName;
	return g_pScriptManager->IsScriptDataSet(&tag);
}

cMultiParm cBaseScript::GetScriptData(const char* pszName)
{
	cMultiParm mpRet;
	sScrDatumTag tag;
	tag.objId = ObjId();
	tag.pszClass = Name();
	tag.pszName = pszName;
	g_pScriptManager->GetScriptData(&tag, &mpRet);
	return mpRet;
}

void cBaseScript::SetScriptData(const char* pszName, const cMultiParm& mpData)
{
	sScrDatumTag tag;
	tag.objId = ObjId();
	tag.pszClass = Name();
	tag.pszName = pszName;
	g_pScriptManager->SetScriptData(&tag, &mpData);
}

cMultiParm cBaseScript::ClearScriptData(const char* pszName)
{
	cMultiParm mpRet;
	sScrDatumTag tag;
	tag.objId = ObjId();
	tag.pszClass = Name();
	tag.pszName = pszName;
	g_pScriptManager->ClearScriptData(&tag, &mpRet);
	return mpRet;
}

void cBaseScript::DebugString(const char* pszMsg1, const char* pszMsg2)
{
	g_pfnMPrintf("%s [%d]: %s%s\n", Name(), ObjId(), pszMsg1, pszMsg2);
}

