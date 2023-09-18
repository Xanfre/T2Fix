srcdir = .

CPU=i386
APPVER=4.0
NODEBUG=1
!include <win32.mak>

!IFDEF NODEBUG
cdebug = -O2 -DNDEBUG
!ELSE
cdebug = -Zi -Od -DDEBUG
!ENDIF

CFLAGS_ALL = $(CFLAGS) $(cdebug)
CPPFLAGS_ALL = $(CPPFLAGS) $(cflags) $(cvarsdll) -DUNICODE -D_UNICODE -DWIN32_LEAN_AND_MEAN -D_CRT_SECURE_NO_WARNINGS
LDFLAGS_ALL = $(LDFLAGS) $(ldebug)

LIBS = user32.lib

OBJS = $(srcdir)\oldfm.obj

{$(srcdir)}.c{$(srcdir)}.obj:
	$(cc) $(CFLAGS_ALL) $(CPPFLAGS_ALL) /Tp $<

all: oldfm.exe

clean:
	del /q oldfm.obj oldfm.exe oldfm.exe.manifest

$(srcdir)\oldfm.obj: oldfm.c

oldfm.exe: $(OBJS)
	$(link) $(LDFLAGS_ALL) -out:$@ $(OBJS) $(LIBS)

