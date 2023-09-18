/******************************************************************************
 *  miss16shim.cpp
 *
 *  Fix various scripts broken in the multiplayer distribution of miss16.osm.
 *
 *  The RollingMachine, SealingMachine, and FusingMachine scripts provided
 *  with the NewDark multiplayer executables are all non-functional. This is
 *  the case when playing with both the standard executable and the
 *  multiplayer executable. This problem is due to the overridden Transmogrify
 *  method in each of these derivative scripts failing to retrieve the input
 *  objects (In terms of the implementations provided here, the lines using
 *  GetScriptData on "InputObj", "InputObj1", and "InputObj2" are missing
 *  entirely, whereas they are present in the original versions of the
 *  module. Looking at disassemblies of both will reveal this.). Because the
 *  input of these machines is never established, they will never produce any
 *  output. In the context of the mission for which these scripts were
 *  intended, this is significant because it completely prevents its completion.
 *
 *  This shim OSM provides implementations of the defective scripts that are
 *  compatible with those in the the original version of the module and is
 *  functional when using both the singleplayer and multiplayer executables.
 *  It operates by first loading the module to be shimmed during its own
 *  initialization and then proceeding to initialize
 *  itself and override any already loaded scripts with its own. As such, only
 *  the scripts implemented and exposed here will be overridden and all others
 *  will be sourced from the module provided with the multiplayer executables.
 *  This shim module will do no harm if used with the original miss16 module,
 *  but only serves a purpose when paired the currently broken multiplayer
 *  module.
 *
 *  This module can also be used as a template and example for easily patching
 *  faulty scripts in OSMs without needing to directly modify them. To choose
 *  which module is to be shimmed, see the calls to AddModule and RemoveModule
 *  and the SHIM_LOAD_OSM definition in ScriptModule.cpp.
 *
 *****************************************************************************/
#include "miss16shim.h"
#include "ScriptModule.h"

#include <lg/types.h>
#include <lg/interface.h>
#include <lg/scrservices.h>
#include <lg/links.h>

using namespace std;

/***
 * TransmogrifyMachine
 */
cScr_TransmogrifyMachine::cScr_TransmogrifyMachine(const char* pszName, int iHostObjId)
	: cBaseScript(pszName, iHostObjId)
{
	static const sMessageHandler handlers[] =
		{{"TurnOn",HandleTurnOn}, {"Enter",HandleEnter}, {"Exit",HandleExit}};
	RegisterMessageHandlers(handlers, 3);
}

long cScr_TransmogrifyMachine::HandleTurnOn(cScript* pScript, sScrMsg* pMsg, sMultiParm* pReply)
{
	return static_cast<cScr_TransmogrifyMachine*>(pScript)->OnTurnOn(pMsg, static_cast<cMultiParm&>(*pReply));
}

long cScr_TransmogrifyMachine::HandleEnter(cScript* pScript, sScrMsg* pMsg, sMultiParm* pReply)
{
	return static_cast<cScr_TransmogrifyMachine*>(pScript)->OnEnter(pMsg, static_cast<cMultiParm&>(*pReply));
}

long cScr_TransmogrifyMachine::HandleExit(cScript* pScript, sScrMsg* pMsg, sMultiParm* pReply)
{
	return static_cast<cScr_TransmogrifyMachine*>(pScript)->OnExit(pMsg, static_cast<cMultiParm&>(*pReply));
}

void cScr_TransmogrifyMachine::Produce(int iSlot, object oObj)
{
	if (!oObj)
		return;

	SService<IObjectSrv> pOS(g_pScriptManager);

	// if obj is a flashbomb, remove its physics
	true_bool bInherits;
	object oMat;
	if (*pOS->InheritsFrom(bInherits, oObj, *pOS->Named(oMat, "Flashbomb")))
	{
		SService<IPropertySrv> pPS(g_pScriptManager);

		if (pPS->Possessed(oObj, "PhysType"))
			pPS->Remove(oObj, "PhysType");
	}

	SService<ILinkSrv> pLS(g_pScriptManager);
	SService<ILinkToolsSrv> pLTS(g_pScriptManager);

	object oOutput = 0;
	linkset lsOutput;
	pLS->GetAll(lsOutput, pLTS->LinkKindNamed("ScriptParams"), ObjId(), 0);
	for (; lsOutput.AnyLinksLeft(); lsOutput.NextLink())
	{
		cMultiParm mpSlot;
		pLTS->LinkGetData(mpSlot, lsOutput.Link(), NULL);
		if (mpSlot == iSlot)
		{
			sLink sl;
			pLTS->LinkGet(lsOutput.Link(), sl);
			oOutput = sl.dest;
			break;
		}
	}
	if (!oOutput)
		return;

	SService<IPhysSrv> pPhysS(g_pScriptManager);

	pOS->Teleport(oObj, cScrVec::Zero, cScrVec::Zero, oOutput);
	cScrVec vVelocity;
	vVelocity.x = vVelocity.y = 0;
	vVelocity.z = 0.1f;
	pPhysS->SetVelocity(oObj, vVelocity);
}

long cScr_TransmogrifyMachine::OnTurnOn(sScrMsg*, cMultiParm&)
{
	Transmogrify();
	return 0;
}

long cScr_TransmogrifyMachine::OnEnter(sScrMsg* pMsg, cMultiParm&)
{
	Add(pMsg->data2, pMsg->data);
	return 0;
}

long cScr_TransmogrifyMachine::OnExit(sScrMsg* pMsg, cMultiParm&)
{
	Remove(pMsg->data2, pMsg->data);
	return 0;
}

/***
 * RollingMachine
 */
void cScr_RollingMachine::Transmogrify(void)
{
	SService<IObjectSrv> pOS(g_pScriptManager);

	object oObj1 = GetScriptData("InputObj1");
	object oObj2 = GetScriptData("InputObj2");
	object oNewObj = 0;
	true_bool bInherits;
	object oMat;
	if (*pOS->InheritsFrom(bInherits, oObj1, *pOS->Named(oMat, "HIPStage1"))
		&& *pOS->InheritsFrom(bInherits, oObj2, *pOS->Named(oMat, "PlateO'Metal")))
		pOS->Create(oNewObj, *pOS->Named(oMat, "HIPStage2"));
	else if (*pOS->InheritsFrom(bInherits, oObj1, *pOS->Named(oMat, "FlareMixture"))
		&& *pOS->InheritsFrom(bInherits, oObj2, *pOS->Named(oMat, "PlateO'Metal")))
		pOS->Create(oNewObj, *pOS->Named(oMat, "Flare"));
	else if (*pOS->InheritsFrom(bInherits, oObj1, *pOS->Named(oMat, "CombatBotBoiler"))
		&& *pOS->InheritsFrom(bInherits, oObj2, *pOS->Named(oMat, "PlateO'Metal")))
	{
		int iExtra3Count = GetScriptData("Extra3Count");
		SetScriptData("Extra3Count", ++iExtra3Count);

		int N = 5;
		if (iExtra3Count >= N) 
		{
			pOS->Create(oNewObj, *pOS->Named(oMat, "QuoteList"));
			SetScriptData("Extra3Count", iExtra3Count - N);
		}
	}
	else
		oNewObj = oObj1;
	if (oNewObj != oObj1)
	{
		pOS->Destroy(oObj1);
		pOS->Destroy(oObj2);
	}
	Produce(1, oNewObj);
}

void cScr_RollingMachine::Add(int iSlot, object oObj)
{
	switch (iSlot)
	{
		case 1:
			if (!GetScriptData("InputObj1"))
				SetScriptData("InputObj1", oObj);
			break;
		case 2:
			if (!GetScriptData("InputObj2"))
				SetScriptData("InputObj2", oObj);
			break;
	}
}

void cScr_RollingMachine::Remove(int iSlot, object oObj)
{
	switch (iSlot)
	{
		case 1:
			if (GetScriptData("InputObj1") == int(oObj))
				SetScriptData("InputObj1", 0);
			break;
		case 2:
			if (GetScriptData("InputObj2") == int(oObj))
				SetScriptData("InputObj2", 0);
			break;
	}
}

/***
 * SealingMachine
 */
void cScr_SealingMachine::Transmogrify(void)
{
	SService<IObjectSrv> pOS(g_pScriptManager);

	object oObj1 = GetScriptData("InputObj1");
	object oObj2 = GetScriptData("InputObj2");
	object oNewObj1 = 0;
	object oNewObj2 = 0;
	true_bool bInherits;
	object oMat;
	if ((*pOS->InheritsFrom(bInherits, oObj1, *pOS->Named(oMat, "HIPStage2"))
		&& *pOS->InheritsFrom(bInherits, oObj2, *pOS->Named(oMat, "RegRound")))
		||
		(*pOS->InheritsFrom(bInherits, oObj2, *pOS->Named(oMat, "HIPStage2"))
		&& *pOS->InheritsFrom(bInherits, oObj1, *pOS->Named(oMat, "RegRound"))))
		pOS->Create(oNewObj1, *pOS->Named(oMat, "HIPStage3"));
	else if ((*pOS->InheritsFrom(bInherits, oObj1, *pOS->Named(oMat, "MineBulb"))
		&& *pOS->InheritsFrom(bInherits, oObj2, *pOS->Named(oMat, "PlateO'Metal")))
		||
		(*pOS->InheritsFrom(bInherits, oObj2, *pOS->Named(oMat, "MineBulb"))
		&& *pOS->InheritsFrom(bInherits, oObj1, *pOS->Named(oMat, "PlateO'Metal"))))
		pOS->Create(oNewObj1, *pOS->Named(oMat, "Mine"));
	else if (*pOS->InheritsFrom(bInherits, oObj1, *pOS->Named(oMat, "MineBulb"))
		&& *pOS->InheritsFrom(bInherits, oObj2, *pOS->Named(oMat, "BantamNode")))
	{
		pOS->Create(oNewObj1, *pOS->Named(oMat, "ExplosiveCharge"));
		object oSecret;
		pOS->Named(oSecret, "ManufactureSecret3");
		if (oSecret)
			PostMessage(oSecret, "TurnOn");
	}
	else
	{
		oNewObj1 = oObj1;
		oNewObj2 = oObj2;
	}
	if (oNewObj1 != oObj1)
	{
		pOS->Destroy(oObj1);
		pOS->Destroy(oObj2);
	}
	Produce(1, oNewObj1);
	Produce(1, oNewObj2);
}

void cScr_SealingMachine::Add(int iSlot, object oObj)
{
	switch (iSlot)
	{
		case 1:
			if (!GetScriptData("InputObj1"))
				SetScriptData("InputObj1", oObj);
			break;
		case 2:
			if (!GetScriptData("InputObj2"))
				SetScriptData("InputObj2", oObj);
			break;
	}
}

void cScr_SealingMachine::Remove(int iSlot, object oObj)
{
	switch (iSlot)
	{
		case 1:
			if (GetScriptData("InputObj1") == int(oObj))
				SetScriptData("InputObj1", 0);
			break;
		case 2:
			if (GetScriptData("InputObj2") == int(oObj))
				SetScriptData("InputObj2", 0);
			break;
	}
}

/***
 * FusingMachine
 */
void cScr_FusingMachine::Transmogrify(void)
{
	SService<IObjectSrv> pOS(g_pScriptManager);

	object oObj = GetScriptData("InputObj");
	object oNewObj = 0;
	true_bool bInherits;
	object oMat;
	if (*pOS->InheritsFrom(bInherits, oObj, *pOS->Named(oMat, "HIPStage3")))
	{
		SService<IQuestSrv> pQS(g_pScriptManager);

		pOS->Destroy(oObj);
		pQS->Set("goal_state_1", 1, kQuestDataMission);
		pOS->Create(oNewObj, *pOS->Named(oMat, "HomingIntact"));
	}

	if (!oNewObj && int(GetScriptData("Extra1Count")) > 0
		&& int(GetScriptData("Extra2Count")) > 0)
	{
		pOS->Create(oNewObj, *pOS->Named(oMat, "FluxSpheroid"));
		SetScriptData("Extra1Count", int(GetScriptData("Extra1Count")) - 1);
		SetScriptData("Extra2Count", int(GetScriptData("Extra2Count")) - 1);
	}
	else if (!oNewObj && int(GetScriptData("Extra3Count")) > 0
		&& int(GetScriptData("Extra4Count")) > 0)
	{
		pOS->Create(oNewObj, *pOS->Named(oMat, "Flashbomb"));
		object oSecret;
		pOS->Named(oSecret, "ManufactureSecret2");
		if (oSecret)
			PostMessage(oSecret, "TurnOn");
		SetScriptData("Extra3Count", int(GetScriptData("Extra3Count")) - 1);
		SetScriptData("Extra4Count", int(GetScriptData("Extra4Count")) - 1);
	}
	Produce(1, oNewObj);
}

void cScr_FusingMachine::Add(int, object oObj)
{
	SService<IObjectSrv> pOS(g_pScriptManager);

	true_bool bInherits;
	object oMat;
	if (*pOS->InheritsFrom(bInherits, oObj, *pOS->Named(oMat, "HIPStage3")))
	{
		if (!GetScriptData("InputObj"))
			SetScriptData("InputObj", oObj);
	}
	else if (*pOS->InheritsFrom(bInherits, oObj, *pOS->Named(oMat, "AcidMixture")))
	{
		SetScriptData("Extra1Count", int(GetScriptData("Extra1Count")) + 1);
		pOS->Destroy(oObj);
	}
	else if (*pOS->InheritsFrom(bInherits, oObj, *pOS->Named(oMat, "WireSpool")))
	{
		SetScriptData("Extra2Count", int(GetScriptData("Extra2Count")) + 1);
		pOS->Destroy(oObj);
	}
	else if (*pOS->InheritsFrom(bInherits, oObj, *pOS->Named(oMat, "PlateO'Metal")))
	{
		SetScriptData("Extra3Count", int(GetScriptData("Extra3Count")) + 1);
		pOS->Destroy(oObj);
	}
	else if (*pOS->InheritsFrom(bInherits, oObj, *pOS->Named(oMat, "FluxSpheroid")))
	{
		SetScriptData("Extra4Count", int(GetScriptData("Extra4Count")) + 1);
		pOS->Destroy(oObj);
	}
	else
		Produce(2, oObj);
}

