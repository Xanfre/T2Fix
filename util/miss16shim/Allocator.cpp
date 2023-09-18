/******************************************************************************
 *  Allocator.cpp
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
#include "Allocator.h"
#include <new>
#include <cassert>
#include <cstring>

extern cMemoryAllocator g_Allocator;

void* operator new(std::size_t size) SPEC_THROW(std::bad_alloc)
{
	void* ptr = g_Allocator.Alloc(size);
	if (!ptr)
		throw std::bad_alloc();
	return ptr;
}

void* operator new[](std::size_t size) SPEC_THROW(std::bad_alloc)
{
	void* ptr = g_Allocator.Alloc(size);
	if (!ptr)
		throw std::bad_alloc();
	return ptr;
}

void* operator new(std::size_t size, const std::nothrow_t&) NO_THROW
{
	return g_Allocator.Alloc(size);
}

void* operator new[](std::size_t size, const std::nothrow_t&) NO_THROW
{
	return g_Allocator.Alloc(size);
}

void operator delete(void* ptr) NO_THROW
{
	if (ptr)
		g_Allocator.Free(ptr);
}

void operator delete[](void* ptr) NO_THROW
{
	if (ptr)
		g_Allocator.Free(ptr);
}

void operator delete(void* ptr, const std::nothrow_t&) NO_THROW
{
	if (ptr)
		g_Allocator.Free(ptr);
}

void operator delete[](void* ptr, const std::nothrow_t&) NO_THROW
{
	if (ptr)
		g_Allocator.Free(ptr);
}

#if __cplusplus >= 201402L
void operator delete(void* ptr, std::size_t) NO_THROW
{
	if (ptr)
		g_Allocator.Free(ptr);
}

void operator delete[](void* ptr, std::size_t) NO_THROW
{
	if (ptr)
		g_Allocator.Free(ptr);
}
#endif

cMemoryAllocator::AllocRecord cMemoryAllocator::nullrecord;

cMemoryAllocator::cMemoryAllocator()
{
	m_alloc = NULL;
#ifdef DEBUG
	m_dballoc = NULL;
#endif
	m_recordhead = &nullrecord;
}

cMemoryAllocator::~cMemoryAllocator()
{
	if (m_alloc)
		m_alloc->Release();
#ifdef DEBUG
	if (m_dballoc)
		m_dballoc->Release();
#endif
}

#ifdef DEBUG
IMalloc* cMemoryAllocator::AttachMalloc(IMalloc* allocator, const char* module)
{
	assert(allocator != NULL);
	allocator->QueryInterface(IID_IMalloc, reinterpret_cast<void**>(&m_alloc));
	allocator->QueryInterface(IID_IDebugMalloc, reinterpret_cast<void**>(&m_dballoc));
	// Because the module may be unloaded, a static buffer will cause problems.
	// This memory will never be freed, a small price to pay.
	ulong namelen = strlen(module) + sizeof("cMemoryAllocator []");
	m_module = static_cast<char*>(allocator->Alloc(namelen));
	strcpy(m_module, "cMemoryAllocator [");
	strcat(m_module, module);
	strcat(m_module, "]");
	assert(m_alloc != NULL);
	return this;
}
#else
IMalloc* cMemoryAllocator::AttachMalloc(IMalloc* allocator, const char*)
{
	assert(allocator != NULL);
	allocator->QueryInterface(IID_IMalloc, reinterpret_cast<void**>(&m_alloc));
	assert(m_alloc != NULL);
	return this;
}
#endif

ulong cMemoryAllocator::CountAlloc(void)
{
#ifdef DEBUG
	return m_numallocs;
#else
	return (ulong)-1;
#endif
}

ulong cMemoryAllocator::CountAverage(void)
{
#ifdef DEBUG
	return m_grosstotal / m_numallocs;
#else
	return (ulong)-1;
#endif
}

ulong cMemoryAllocator::CountBlocks(void)
{
#ifdef DEBUG
	ulong num = 0;
	AllocRecord *rec;
	for (rec = m_recordhead;
		 rec->next != rec;
		 rec = rec->next)
	{
		num++;
	}
	return num;
#else
	return (ulong)-1;
#endif
}

ulong cMemoryAllocator::CountSize(void)
{
#ifdef DEBUG
	ulong size = 0;
	AllocRecord *rec;
	for (rec = m_recordhead;
		 rec->next != rec;
		 rec = rec->next)
	{
		size += rec->size;
	}
	return size;
#else
	return (ulong)-1;
#endif
}

STDMETHODIMP_(void*) cMemoryAllocator::Alloc(ulong size)
{
	assert(m_alloc != NULL);
	AllocRecord* rec;
#ifdef DEBUG
	if (m_dballoc)
		rec = static_cast<AllocRecord*>(m_dballoc->AllocEx(size+sizeof(AllocRecord), m_module, 0));
	else
#endif
		rec = static_cast<AllocRecord*>(m_alloc->Alloc(size+sizeof(AllocRecord)));
	rec->insert(&m_recordhead);
	rec->size = size;
#ifdef DEBUG
	m_numallocs++;
	m_grosstotal += size;
#endif
	return rec+1;
}

STDMETHODIMP_(void*) cMemoryAllocator::Realloc(void* ptr, ulong size)
{
	assert(m_alloc != NULL);
	if (!ptr)
		return Alloc(size);
	if (!size)
	{
		Free(ptr);
		return NULL;
	}
	AllocRecord* rec = static_cast<AllocRecord*>(ptr)-1;
	if (rec->remove(&m_recordhead))
	{
		AllocRecord* newrec;
#ifdef DEBUG
		if (m_dballoc)
			newrec = static_cast<AllocRecord*>(m_dballoc->ReallocEx(rec, size+sizeof(AllocRecord), m_module, 0));
		else
#endif
			newrec = static_cast<AllocRecord*>(m_alloc->Realloc(rec, size+sizeof(AllocRecord)));
		if (!newrec)
		{
			rec->insert(&m_recordhead);
			return NULL;
		}
#ifdef DEBUG
		if (size > rec->size)
			m_grosstotal += size - rec->size;
#endif
		newrec->insert(&m_recordhead);
		newrec->size = size;
		return newrec+1;
	}
#ifdef DEBUG
	if (m_dballoc)
		return m_dballoc->ReallocEx(rec, size+sizeof(AllocRecord), m_module, 0);
#endif
	return m_alloc->Realloc(ptr, size);
}

STDMETHODIMP_(void) cMemoryAllocator::Free(void* ptr)
{
	assert(m_alloc != NULL);
	AllocRecord* rec = static_cast<AllocRecord*>(ptr)-1;
	if (rec->remove(&m_recordhead))
	{
#ifdef DEBUG
		if (m_dballoc)
			m_dballoc->FreeEx(rec, m_module, 0);
		else
#endif
			m_alloc->Free(rec);
	}
	else
	{
#ifdef DEBUG
		if (m_dballoc)
			m_dballoc->FreeEx(ptr, m_module, 0);
		else
#endif
			m_alloc->Free(ptr);
	}
}

STDMETHODIMP_(ulong) cMemoryAllocator::GetSize(void* ptr)
{
	assert(m_alloc != NULL);
	if (!ptr)
		return (ulong)-1;
	AllocRecord* rec = static_cast<AllocRecord*>(ptr)-1;
	rec = rec->find(m_recordhead);
	if (rec)
		return rec->size;
	return m_alloc->GetSize(ptr);
}

STDMETHODIMP_(int) cMemoryAllocator::DidAlloc(void* ptr)
{
	assert(m_alloc != NULL);
	if (!ptr)
		return 0;
	AllocRecord* rec = static_cast<AllocRecord*>(ptr)-1;
	rec = rec->find(m_recordhead);
	if (rec)
		return 1;
	return 0;
}

STDMETHODIMP_(void) cMemoryAllocator::HeapMinimize(void)
{
	assert(m_alloc != NULL);
	m_alloc->HeapMinimize();
}

#ifdef DEBUG
STDMETHODIMP_(void*) cMemoryAllocator::AllocEx(ulong size, const char* file, int line)
{
	assert(m_alloc != NULL);
	AllocRecord* rec;
	if (m_dballoc)
		rec = static_cast<AllocRecord*>(m_dballoc->AllocEx(size+sizeof(AllocRecord), file, line));
	else
		rec = static_cast<AllocRecord*>(m_alloc->Alloc(size+sizeof(AllocRecord)));
	rec->insert(&m_recordhead);
	rec->size = size;
	m_numallocs++;
	m_grosstotal += size;
	return rec+1;
}

STDMETHODIMP_(void*) cMemoryAllocator::ReallocEx(void* ptr, ulong size, const char* file, int line)
{
	assert(m_alloc != NULL);
	if (!ptr)
		return Alloc(size);
	if (!size)
	{
		Free(ptr);
		return NULL;
	}
	AllocRecord* rec = static_cast<AllocRecord*>(ptr)-1;
	if (rec->remove(&m_recordhead))
	{
		AllocRecord* newrec;
		if (m_dballoc)
			newrec = static_cast<AllocRecord*>(m_dballoc->ReallocEx(rec, size+sizeof(AllocRecord), file, line));
		else
			newrec = static_cast<AllocRecord*>(m_alloc->Realloc(rec, size+sizeof(AllocRecord)));
		if (!newrec)
		{
			rec->insert(&m_recordhead);
			return NULL;
		}
		if (size > rec->size)
			m_grosstotal += size - rec->size;
		newrec->insert(&m_recordhead);
		newrec->size = size;
		return newrec+1;
	}
	if (m_dballoc)
		return m_dballoc->ReallocEx(rec, size+sizeof(AllocRecord), file, line);
	return m_alloc->Realloc(ptr, size);
}

STDMETHODIMP_(void) cMemoryAllocator::FreeEx(void* ptr, const char* file, int line)
{
	assert(m_alloc != NULL);
	AllocRecord* rec = static_cast<AllocRecord*>(ptr)-1;
	if (rec->remove(&m_recordhead))
	{
		if (m_dballoc)
			m_dballoc->FreeEx(rec, file, line);
		else
			m_alloc->Free(rec);
	}
	else
	{
		if (m_dballoc)
			m_dballoc->FreeEx(ptr, file, line);
		else
			m_alloc->Free(ptr);
	}
}

STDMETHODIMP cMemoryAllocator::VerifyAlloc(void* ptr)
{
	if (m_dballoc)
		return m_dballoc->VerifyAlloc(ptr);
	return S_OK;
}

STDMETHODIMP cMemoryAllocator::VerifyHeap(void)
{
	if (m_dballoc)
		return m_dballoc->VerifyHeap();
	return S_OK;
}

STDMETHODIMP_(void) cMemoryAllocator::DumpHeapInfo(void)
{
	if (m_dballoc)
		m_dballoc->DumpHeapInfo();
}

STDMETHODIMP_(void) cMemoryAllocator::DumpStats(void)
{
	if (m_dballoc)
		m_dballoc->DumpStats();
}

STDMETHODIMP_(void) cMemoryAllocator::DumpBlocks(void)
{
	if (m_dballoc)
		m_dballoc->DumpBlocks();
}

STDMETHODIMP_(void) cMemoryAllocator::DumpModules(void)
{
	if (m_dballoc)
		m_dballoc->DumpModules();
}

STDMETHODIMP_(void) cMemoryAllocator::PushCredit(const char* file, int name)
{
	if (m_dballoc)
		m_dballoc->PushCredit(file, name);
}

STDMETHODIMP_(void) cMemoryAllocator::PopCredit(void)
{
	if (m_dballoc)
		m_dballoc->PopCredit();
}
#endif
