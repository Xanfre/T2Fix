/******************************************************************************
 *  MsgHandlerArray.h
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
#ifndef MSGHANDLERARRAY_H
#define MSGHANDLERARRAY_H

#if _MSC_VER > 1000
#pragma once
#endif

#include <lg/dynarray.h>

class cScript;
struct sScrMsg;
struct sMultiParm;

typedef long (*MessageHandlerProc)(cScript*,sScrMsg*,sMultiParm*);
struct sMessageHandler
{
	const char* pszName;
	MessageHandlerProc pfnHandler;
};

struct sMessageHandlerNode
{
	ulong ulKey;
	const sMessageHandler* pData;

	sMessageHandlerNode(const sMessageHandler* _data);

	bool operator==(const char* _s);
	bool operator!=(const char* _s);
	bool operator==(const sMessageHandlerNode& _r);
	bool operator!=(const sMessageHandlerNode& _r);
	bool operator<(const sMessageHandlerNode& _r);
};

/***
 * Return a 32-bit quick'n'dirty hash of a string.
 * Case-insensitive.
 */
ulong hash_name(const char* pszName);

/***
 * Return the first index not less than the given name,
 * with a pre-computed hash.
 * Returns array.size() if no node is found.
 */
uint find_first(cDynArray<sMessageHandlerNode>& array, const char* name, ulong key);

/***
 * Inline overload of find_first that dynamically computes the hash.
 */
inline uint find_first(cDynArray<sMessageHandlerNode>& array, const char* name)
{
	return find_first(array, name, hash_name(name));
}

/***
 * Inline overload of find_first using an existing reference node.
 */
inline uint find_first(cDynArray<sMessageHandlerNode>& array, const sMessageHandlerNode& node)
{
	return find_first(array, node.pData->pszName, node.ulKey);
}

/***
 * Inserts a node at the position returned from find_first.
 */
uint insert_sorted(cDynArray<sMessageHandlerNode>& array, const sMessageHandlerNode& node);

#endif // MSGHANDLERARRAY_H
