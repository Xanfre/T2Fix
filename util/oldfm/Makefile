TARGET ?=
ifeq ($(TARGET),)
CC ?= gcc
else
CC = $(TARGET)-gcc
endif

TARGET_OS ?= $(OS)

CFLAGS_ALL = -O2 $(CFLAGS)
CPPFLAGS_ALL = -std=c99 -Wall -Wextra $(CPPFLAGS)
LDFLAGS_ALL = $(LDFLAGS)

ifeq ($(TARGET_OS),Windows_NT)
	LDFLAGS_ALL += -municode
else
	CFLAGS_ALL += -fPIC
endif

LIBS =

ifeq ($(TARGET_OS),Windows_NT)
	BINEXT = .exe
else
	LIBS += -lfmsel
endif

OBJS = ./oldfm.o

all: oldfm$(BINEXT)

clean:
	rm -f *.o oldfm$(BINEXT)

./%.o: ./%.c
	$(CC) $(CFLAGS_ALL) $(CPPFLAGS_ALL) -c -o $@ $<

oldfm$(BINEXT): $(OBJS)
	$(CC) $(CFLAGS_ALL) -s $(LDFLAGS_ALL) $^ -o $@ $(LIBS)

