/******************************************************************************
 *  Allocator.h
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
#ifndef ALLOCATOR_H
#define ALLOCATOR_H

#include <lg/config.h>
#include <lg/objstd.h>
#include <lg/malloc.h>

#ifdef DEBUG
#define cMemoryAllocatorBase IDebugMalloc
#else
#define cMemoryAllocatorBase IMalloc
#endif
class cMemoryAllocator : public cMemoryAllocatorBase
{
	struct AllocRecord;

public:

	virtual ~cMemoryAllocator();
	cMemoryAllocator();
	IMalloc* AttachMalloc(IMalloc* allocator, const char* module);
	ulong CountAlloc(void);
	ulong CountAverage(void);
	ulong CountBlocks(void);
	ulong CountSize(void);

	STDMETHOD(QueryInterface)(REFIID, void** ppv)
	{
		*ppv = this;
		return S_OK;
	}
	STDMETHOD_(ulong,AddRef)(void)
	{
		return 1;
	}
	STDMETHOD_(ulong,Release)(void)
	{
		return 1;
	}
	STDMETHOD_(void*,Alloc)(ulong size);
	STDMETHOD_(void*,Realloc)(void* ptr, ulong size);
	STDMETHOD_(void,Free)(void* ptr);
	STDMETHOD_(ulong,GetSize)(void* ptr);
	STDMETHOD_(int,DidAlloc)(void* ptr);
	STDMETHOD_(void,HeapMinimize)(void);

#ifdef DEBUG
	STDMETHOD_(void*,AllocEx)(ulong,const char*,int);
	STDMETHOD_(void*,ReallocEx)(void*,ulong,const char*,int);
	STDMETHOD_(void,FreeEx)(void*,const char*,int);
	STDMETHOD(VerifyAlloc)(void*);
	STDMETHOD(VerifyHeap)(void);
	STDMETHOD_(void,DumpHeapInfo)(void);
	STDMETHOD_(void,DumpStats)(void);
	STDMETHOD_(void,DumpBlocks)(void);
	STDMETHOD_(void,DumpModules)(void);
	STDMETHOD_(void,PushCredit)(const char*,int);
	STDMETHOD_(void,PopCredit)(void);
#endif

private:

	IMalloc* m_alloc;
	AllocRecord* m_recordhead;
#ifdef DEBUG
	IDebugMalloc* m_dballoc;
	ulong m_numallocs;
	ulong m_grosstotal;
	char* m_module;
#endif

	struct AllocRecord
	{
		AllocRecord* next;
		ulong size;

		AllocRecord()
		{
			next = this;
			size = 0;
		}

		void insert(AllocRecord** head)
		{
			next = *head;
			*head = this;
		}

		bool remove(AllocRecord** head)
		{
			AllocRecord *rec;
			for (rec = *head;
				 rec->next != rec;
				 head = &rec->next, rec = rec->next)
			{
				if (rec == this)
				{
					(*head) = rec->next;
					return true;
				}
			}
			return false;
		}

		AllocRecord* find(AllocRecord* rec)
		{
			for (; rec->next != rec; rec = rec->next)
			{
				if (rec == this)
					return this;
			}
			return NULL;
		}

	};

	static AllocRecord nullrecord;

};

#endif // ALLOCATOR_H
