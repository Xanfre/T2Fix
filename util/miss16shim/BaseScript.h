/******************************************************************************
 *  BaseScript.h
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
#ifndef BASESCRIPT_H
#define BASESCRIPT_H

#if !SCR_GENSCRIPTS
#include <lg/dynarray.h>
#include "Script.h"
#include "MsgHandlerArray.h"
#endif // SCR_GENSCRIPTS


/**
 * AbstractScript: BaseScript
 */
#if !SCR_GENSCRIPTS
class cBaseScript : public cScript
{
public:
	cBaseScript(const char* pszName, int iHostObjId);
	virtual ~cBaseScript();

	STDMETHOD(ReceiveMessage)(sScrMsg* pMsg, sMultiParm* pReply, eScrTraceAction eTrace);

protected:
	virtual long OnMessage(sScrMsg* pMsg, cMultiParm& mpReply)
		{ return cScript::ReceiveMessage(pMsg, &mpReply, kNoAction); }

private:
	static const sMessageHandler sm_BaseMessageHandlers[];
	cDynArray<sMessageHandlerNode> m_aMessageHandlers;
	cDynArray<sMessageHandler*> m_aDynamicHandlers;

	long DispatchMessage(sScrMsg* pMsg, sMultiParm* pReply);

protected:
	void RegisterMessageHandlers(const sMessageHandler* pHandlers, uint iCount);
	void RegisterDynamicMessageHandler(const char* pszName, MessageHandlerProc pfnHandler);
	void UnregisterMessageHandler(const char* pszName);

	bool IsSim(void)
		{ return m_bSim; }
	int GetSimTime(void)
		{ return m_iMessageTime; }

	cMultiParm* SendMessage(cMultiParm& mpReply, object iDest, const char* pszMessage, const cMultiParm& mpData1 = cMultiParm::Undef, const cMultiParm& mpData2 = cMultiParm::Undef, const cMultiParm& mpData3 = cMultiParm::Undef);
	void PostMessage(object iDest, const char* pszMessage, const cMultiParm& mpData1 = cMultiParm::Undef, const cMultiParm& mpData2 = cMultiParm::Undef, const cMultiParm& mpData3 = cMultiParm::Undef);
	tScrTimer SetTimedMessage(const char* pszName, ulong iTime, eScrTimedMsgKind eType, const cMultiParm& mpData = cMultiParm::Undef);
	void KillTimedMessage(tScrTimer hTimer);

	bool IsScriptDataSet(const char* pszName);
	cMultiParm GetScriptData(const char* pszName);
	void SetScriptData(const char* pszName, const cMultiParm& mpData);
	cMultiParm ClearScriptData(const char* pszName);

	void DebugString(const char* pszMsg1, const char* pszmsg2 = "");

private:
	bool m_bSim;
	int m_iMessageTime;

};
#endif // SCR_GENSCRIPTS

#endif // BASESCRIPT_H
