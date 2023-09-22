#!/bin/sh
# Build the T2Fix installers.

cd $(dirname $0)

. ./common.sh

if test -f ./config.sh; then
	. ./config.sh
fi

iscc()
{
	# In config.sh, set ISPATH to the complete path of the installed Inno Setup
	# Compiler (ISCC.exe).
	# Also, set WINE to 'wine' or the location of your Wine binary if you need
	# to use it.
	ARGS=$1
	$WINE "$ISPATH" $ARGS
}

echo "Checking for prerequisites..."
test -n "$ISPATH" && echo "ISCC path defined." || abort "ISCC path (ISPATH) not defined!"

if ! test -d ./Resources; then
	abort "The resources directory could not be located. Please populate it or run fetchresources.sh first."
fi

echo "Building T2Fix installer..."
iscc "-Qp T2Fix.iss" && echo "T2Fix built successfully." || abort "T2Fix failed to build!"

echo "Building T2Fix (with mods) installer..."
iscc "-Qp -DMods T2Fix.iss" && echo "T2Fix (with mods) built successfully." || abort "T2Fix (with mods) failed to build!"

echo "Building T2Fix Lite installer..."
iscc "-Qp T2Fix_Lite.iss" && echo "T2Fix Lite built successfully." || abort "T2Fix Lite failed to build!"

echo

