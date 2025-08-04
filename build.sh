#!/bin/sh
# Build the T2Fix installers.

cd $(dirname $0)

. ./common.sh

if test -f ./config.sh; then
	. ./config.sh
fi

INST_VER="1.28 (2025-08-04)"
INST_VI_VER="1.28"

iscc()
{
	# In config.sh, set ISPATH to the complete path of the installed Inno Setup
	# Compiler (ISCC.exe).
	# Also, set WINE to 'wine' or the location of your Wine binary if you need
	# to use it.
	ARGS=$1
	NAME=$2
	echo "Building ${NAME} installer..."
	$WINE "$ISPATH" -Qp -DFVer="$INST_VER" -DFVIVer="$INST_VI_VER" $ARGS && echo "${NAME} built successfully." || abort "${NAME} failed to build!"
}

iscc5()
{
	# In config.sh, set IS5PATH to the complete path of the installed Inno Setup 5
	# Compiler (ISCC.exe).
	ARGS=$1
	NAME=$2
	echo "Building legacy ${NAME} installer..."
	$WINE "$IS5PATH" -Qp -DFVer="$INST_VER" -DFVIVer="$INST_VI_VER" $ARGS && echo "Legacy ${NAME} built successfully." || abort "Legacy ${NAME} failed to build!"
}

echo "Checking for prerequisites..."
test -n "$ISPATH" && echo "ISCC path defined." || abort "ISCC path (ISPATH) not defined!"
if test "$T2FIX_BUILD_LEGACY" = "1"; then
	test -n "$IS5PATH" && echo "ISCC 5 path defined." || abort "ISCC 5 PATH (IS5PATH) not defined!"
fi

if ! test -d ./Resources; then
	abort "The resources directory could not be located. Please populate it or run fetchresources.sh first."
fi

if test "$T2FIX_BUILD_LEGACY" = "1"; then
	iscc5 "T2Fix.iss" "T2Fix"
	iscc5 "-DMods T2Fix.iss" "T2Fix (with mods)"
	iscc5 "T2Fix_Lite.iss" "T2Fix Lite"
fi

iscc "T2Fix.iss" "T2Fix"
iscc "-DMods T2Fix.iss" "T2Fix (with mods)"
iscc "T2Fix_Lite.iss" "T2Fix Lite"

echo

