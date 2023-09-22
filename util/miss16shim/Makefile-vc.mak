###############################################################################
##  Makefile-vc
##
##  This file is part of Public Scripts
##  Copyright (C) 2005-2011 Tom N Harris <telliamed@whoopdedo.org>
##
##  This program is free software; you can redistribute it and/or modify
##  it under the terms of the GNU General Public License as published by
##  the Free Software Foundation; either version 2 of the License, or
##  (at your option) any later version.
##
##  This program is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU General Public License for more details.
##
##  You should have received a copy of the GNU General Public License
##  along with this program. If not, see <http://www.gnu.org/licenses/>.
##
###############################################################################

CPU=i386
APPVER=4.0
!include <win32.mak>

srcdir = .
bindir = .\objs
bindirectories = $(bindir)

LGDIR = .\lg

DEFINES = -D_MT -DWINVER=0x0400 -D_WIN32_WINNT=0x0400 -DWIN32_LEAN_AND_MEAN -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE -D_DARKGAME=2 -D_NEWDARK

!ifdef DEBUG
DEFINES = $(DEFINES) -DDEBUG=1
CXXDEBUG = -MDd -Od
LDDEBUG = -DEBUG
LGLIB = $(LGDIR)\lg-d.lib
!else
DEFINES = $(DEFINES) -DNDEBUG
CXXDEBUG = -MD -O2
LDDEBUG = -RELEASE
LGLIB = $(LGDIR)\lg.lib
!endif

LDFLAGS = -nologo $(dlllflags) -base:0x10000000
LIBDIRS =
LIBS = $(LGLIB) uuid.lib
INCLUDES = -I. -I$(srcdir) -I$(LGDIR)
CXXFLAGS = $(cflags) -nologo -W3 -wd4800 -TP -EHsc

OSM_OBJS = $(bindir)\ScriptModule.obj $(bindir)\Script.obj $(bindir)\Allocator.obj
BASE_OBJS = $(bindir)\MsgHandlerArray.obj $(bindir)\BaseScript.obj
SCR_OBJS = $(bindir)\miss16shim.obj
MISC_OBJS = $(bindir)\ScriptDef.obj
RES_OBJS = $(bindir)\script.res

ALL_OBJS = $(SCR_OBJS) $(BASE_OBJS) $(OSM_OBJS) $(MISC_OBJS) $(RES_OBJS)

{$(srcdir)}.cpp{$(bindir)}.obj:
	$(cc) $(CXXFLAGS) $(CXXDEBUG) $(DEFINES) $(INCLUDES) -Fo$(bindir)\ -Fd$(bindir)\ -c $<

{$(srcdir)}.rc{$(bindir)}.res:
	$(rc) $(RCFLAGS) -I. $(DEFINES) -fo$@ -r $<

all: $(bindirectories) miss16.osm

clean:
	del /q $(bindir)\*.*
	del /q *.osm *.lib *.exp *.manifest

$(bindir):
	mkdir $@

$(bindir)\ScriptModule.obj: ScriptModule.cpp ScriptModule.h Allocator.h
$(bindir)\Script.obj: Script.cpp Script.h
$(bindir)\Allocator.obj: Allocator.cpp Allocator.h

$(bindir)\BaseScript.obj: BaseScript.cpp BaseScript.h Script.h ScriptModule.h MsgHandlerArray.h

$(bindir)\miss16shim.obj: miss16shim.cpp miss16shim.h BaseScript.h Script.h

$(bindir)\ScriptDef.obj: ScriptDef.cpp miss16shim.h BaseScript.h ScriptModule.h genscripts.h

$(bindir)\script.res: script.rc

miss16.osm: $(ALL_OBJS)
	$(link) $(LDFLAGS) -base:0x11200000 $(LIBDIRS) -out:$@ $(ALL_OBJS) $(LIBS)

