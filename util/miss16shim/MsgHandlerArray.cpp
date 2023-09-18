/******************************************************************************
 *  MsgHandlerArray.cpp
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
#include "MsgHandlerArray.h"

#include <cstring>

ulong hash_name(const char* pszName)
{
	ulong _h = 0;
	const char* _p = pszName;
	for (; *_p; ++_p)
		_h = (_h * 131) + (*_p|0x20);
	return _h;
}

uint find_first(cDynArray<sMessageHandlerNode>& array, const char* name, ulong key)
{
	if (array.size() == 0)
		return 0;
	uint r = 0;
	uint b = array.size() - 1;
	uint n = array.size() >> 1;
	while (1)
	{
		if (array[n].ulKey == key)
		{
			while (array[n].ulKey == key)
			{
				if (0 <= ::_stricmp(array[n].pData->pszName, name))
					break;
				++n;
			}
			return n;
		}
		if (array[n].ulKey < key)
		{
			if (n == b)
				return n + 1;
			r = n + 1;
			n = r + ((b - n) >> 1);
		}
		else
		{
			if (n == r)
				return n;
			b = n - 1;
			n = b - ((n - r) >> 1);
		}
	}
	return array.size();
}

uint insert_sorted(cDynArray<sMessageHandlerNode>& array, const sMessageHandlerNode& node)
{
	uint n = find_first(array, node);
	if (n < array.size() && array[n] == node)
	{
		array[n] = node;
	}
	else
	{
		array.insert(node, n);
	}
	return n;
}

sMessageHandlerNode::sMessageHandlerNode(const sMessageHandler* _data)
{
	ulKey = hash_name(_data->pszName);
	pData = _data;
}

bool sMessageHandlerNode::operator==(const char* _s)
{
	return (ulKey == hash_name(_s))
	    && (0 == ::_stricmp(pData->pszName, _s));
}

bool sMessageHandlerNode::operator!=(const char* _s)
{
	return (ulKey != hash_name(_s))
	    || (0 != ::_stricmp(pData->pszName, _s));
}

bool sMessageHandlerNode::operator==(const sMessageHandlerNode& _r)
{
	return (ulKey == _r.ulKey)
	    && ((pData == _r.pData)
		 || (0 == ::_stricmp(pData->pszName, _r.pData->pszName)));
}

bool sMessageHandlerNode::operator!=(const sMessageHandlerNode& _r)
{
	return (ulKey != _r.ulKey)
	    || ((pData != _r.pData)
		 && (0 != ::_stricmp(pData->pszName, _r.pData->pszName)));
}

bool sMessageHandlerNode::operator<(const sMessageHandlerNode& _r)
{
	if (ulKey == _r.ulKey && pData != _r.pData)
		return 0 > ::_stricmp(pData->pszName, _r.pData->pszName);
	return (ulKey < _r.ulKey);
}

