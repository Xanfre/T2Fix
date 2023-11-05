###############################################################################
##  Makefile-gcc
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


.SUFFIXES:
.SUFFIXES: .o .cpp .rc
.PRECIOUS: %.o

srcdir = .
bindir = ./objs
bindirectories = $(bindir)

LGDIR = ./lg

ifeq ($(TARGET),)
CC = gcc
CXX = g++
AR = ar
LD = g++
DLLTOOL = dlltool
RC = windres
else
CC = $(TARGET)-gcc
CXX = $(TARGET)-g++
AR = $(TARGET)-ar
LD = $(TARGET)-g++
DLLTOOL = $(TARGET)-dlltool
RC = $(TARGET)-windres
endif

DEFINES = -DWINVER=0x0400 -D_WIN32_WINNT=0x0400 -DWIN32_LEAN_AND_MEAN -D_DARKGAME=2 -D_NEWDARK

ifdef DEBUG
DEFINES := $(DEFINES) -DDEBUG
CXXDEBUG = -g -O0
LDDEBUG = -g
LGLIB = -llg-d
else
DEFINES := $(DEFINES) -DNDEBUG
CXXDEBUG = -O2
LDDEBUG =
LGLIB = -llg
endif

ARFLAGS = rc
LDFLAGS = -mwindows -mdll -Wl,--enable-auto-image-base
LIBDIRS = -L. -L$(LGDIR)
LIBS = $(LGLIB) -luuid
INCLUDES = -I. -I$(srcdir) -I$(LGDIR)
CXXFLAGS = -Wall -Wextra -masm=intel
DLLFLAGS = --add-underscore

OSM_OBJS = $(bindir)/ScriptModule.o $(bindir)/Script.o $(bindir)/Allocator.o $(bindir)/exports.o
BASE_OBJS = $(bindir)/MsgHandlerArray.o $(bindir)/BaseScript.o
SCR_OBJS = $(bindir)/miss16shim.o
MISC_OBJS = $(bindir)/ScriptDef.o
RES_OBJS = $(bindir)/script_res.o


$(bindir)/%.o: $(srcdir)/%.cpp
	$(CXX) $(CXXFLAGS) $(CXXDEBUG) $(DEFINES) $(INCLUDES) -o $@ -c $<

$(bindir)/%_res.o: $(srcdir)/%.rc
	$(RC) $(DEFINES) -o $@ -i $<

all: $(bindirectories) miss16.osm

clean:
	$(RM) $(bindir)/* *.osm

$(bindir):
	mkdir -p $@

#.INTERMEDIATE: $(bindir)/exports.o

$(bindir)/exports.o: $(bindir)/ScriptModule.o
	$(DLLTOOL) $(DLLFLAGS) --dllname miss16.osm --output-exp $@ $^

$(bindir)/ScriptModule.o: ScriptModule.cpp ScriptModule.h Allocator.h
$(bindir)/Script.o: Script.cpp Script.h
$(bindir)/Allocator.o: Allocator.cpp Allocator.h

$(bindir)/BaseScript.o: BaseScript.cpp BaseScript.h Script.h ScriptModule.h MsgHandlerArray.h

$(bindir)/miss16shim.o: miss16shim.cpp miss16shim.h BaseScript.h Script.h

$(bindir)/ScriptDef.o: ScriptDef.cpp miss16shim.h BaseScript.h ScriptModule.h genscripts.h

$(bindir)/script_res.o: script.rc

miss16.osm: $(SCR_OBJS) $(BASE_OBJS) $(BASE_OBJS) $(OSM_OBJS) $(MISC_OBJS) $(RES_OBJS)
	$(LD) $(LDFLAGS) -Wl,--image-base=0x11200000 $(LDDEBUG) $(LIBDIRS) -o $@ script.def $^ $(LIBS)

