/******************************************************************************
 *  miss16shim.h
 *
 *  Fix various scripts broken in the multiplayer distribution of miss16.osm.
 *
 *****************************************************************************/
#ifndef T2MPSCRIPTS_H
#define T2MPSCRIPTS_H

#ifndef SCR_GENSCRIPTS
#include "BaseScript.h"
#endif // SCR_GENSCRIPTS

/**
 * Script: TransmogrifyMachine
 */
#if !SCR_GENSCRIPTS
class cScr_TransmogrifyMachine : public cBaseScript
{
public:
	cScr_TransmogrifyMachine(const char* pszName, int iHostObjId);

protected:
	void Produce(int iSlot, object oObj);
	virtual void Transmogrify(void) { }
	virtual void Add(int, object) { }
	virtual void Remove(int, object) { }

protected:
	virtual long OnTurnOn(sScrMsg*, cMultiParm&);
	virtual long OnEnter(sScrMsg*, cMultiParm&);
	virtual long OnExit(sScrMsg*, cMultiParm&);

private:
	static long HandleTurnOn(cScript* pScript, sScrMsg* pMsg, sMultiParm* pReply);
	static long HandleEnter(cScript* pScript, sScrMsg* pMsg, sMultiParm* pReply);
	static long HandleExit(cScript* pScript, sScrMsg* pMsg, sMultiParm* pReply);
};
#endif // SCR_GENSCRIPTS

/**
 * Script: RollingMachine
 */
#if !SCR_GENSCRIPTS
class cScr_RollingMachine : public cScr_TransmogrifyMachine
{
public:
	cScr_RollingMachine(const char* pszName, int iHostObjId)
		: cScr_TransmogrifyMachine(pszName, iHostObjId)
	{ }

protected:
	void Transmogrify(void);
	void Add(int iSlot, object oObj);
	void Remove(int iSlot, object oObj);
};
#else // SCR_GENSCRIPTS
GEN_FACTORY("RollingMachine","TransmogrifyMachine",cScr_RollingMachine)
#endif // SCR_GENSCRIPTS

/**
 * Script: SealingMachine
 */
#if !SCR_GENSCRIPTS
class cScr_SealingMachine : public cScr_TransmogrifyMachine
{
public:
	cScr_SealingMachine(const char* pszName, int iHostObjId)
		: cScr_TransmogrifyMachine(pszName, iHostObjId)
	{ }

protected:
	void Transmogrify(void);
	void Add(int iSlot, object oObj);
	void Remove(int iSlot, object oObj);
};
#else // SCR_GENSCRIPTS
GEN_FACTORY("SealingMachine","TransmogrifyMachine",cScr_SealingMachine)
#endif // SCR_GENSCRIPTS

/**
 * Script: FusingMachine
 */
#if !SCR_GENSCRIPTS
class cScr_FusingMachine : public cScr_TransmogrifyMachine
{
public:
	cScr_FusingMachine(const char* pszName, int iHostObjId)
		: cScr_TransmogrifyMachine(pszName, iHostObjId)
	{ }

protected:
	void Transmogrify(void);
	void Add(int iSlot, object oObj);
};
#else // SCR_GENSCRIPTS
GEN_FACTORY("FusingMachine","TransmogrifyMachine",cScr_FusingMachine)
#endif // SCR_GENSCRIPTS

#endif // T2MPSCRIPTS_H
#ifdef SCR_GENSCRIPTS
#undef T2MPSCRIPTS_H
#endif
