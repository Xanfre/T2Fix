#!/bin/sh
# Build utilities.
#
# NOTE: This script is indended to be used with Microsoft Visual C++ 9, which is
# included with Visual Studio 2008. If you plan to use other tools (i.e. MinGW),
# build them manually using the provided makefiles prior to fetching resources
# and building the installers.

cd $(dirname $0)

. ../common.sh

if test -f ../config.sh; then
	. ../config.sh
fi

nmake()
{
	# In config.sh, set VSPATH and SDKPATH to the locations of your base Visual
	# Studio 2008 or Visual C++ 9 installation and your Windows SDK installation,
	# respectively.
	# Also, set WINE to 'wine' or the location of your Wine binary if you need
	# to use it.
	ARGS=$1
	if test -z "$WINE"; then
		# This path will only persist for the runtime of this function.
		# Do not try to use this path in the global environment.
		export PATH="${VSPATH}\\Common7\\IDE:${VSPATH}\\VC\\bin:${SDKPATH}\\bin"
	else
		export WINEPATH="${VSPATH}\\Common7\\IDE;${VSPATH}\\VC\\bin;${SDKPATH}\\bin"
	fi
	export INCLUDE="${VSPATH}\\VC\\include;${SDKPATH}\\include"
	export LIB="${VSPATH}\\VC\\lib;${SDKPATH}\\lib"
	export LIBPATH="${VSPATH}\\VC\\lib"
	if test -z "$WINE"; then
		nmake.exe $ARGS
	else
		$WINE cmd /c nmake.exe $ARGS
	fi
}

echo "Checking for prerequisites..."
check_command curl
check_command 7z
test -n "$VSPATH" && echo "Visual Studio path defined." || abort "Visual Studio path (VSPATH) not defined!"
test -n "$SDKPATH" && echo "Windows SDK path defined." || abort "Windows SDK path (SDKPATH) not defined!"

if ! test -f oldfm/fmsel.h; then
	echo "Retrieving FMSel headers..."
	cd ..
	mkdir -p cache/t2_v127/contrib_src/fmsel_src
	curl_fetch t2_v127.zip https://archive.org/download/t2_v127/t2_v127.zip 33caca92a14acdb366211b464fbaa73113e028e9d024c9636e5a74890157ce26
	extract t2_v127.zip cache/t2_v127 contrib_src.zip
	extract t2_v127/contrib_src.zip cache/t2_v127/contrib_src fmsel_src.zip
	extract t2_v127/contrib_src/fmsel_src.zip cache/t2_v127/contrib_src/fmsel_src fmsel/fmsel.h
	cp -p cache/t2_v127/contrib_src/fmsel_src/fmsel/fmsel.h util/oldfm/
	rm -rf cache/t2_v127
	cd util
	echo "Retrieved FMSel headers."
fi

echo "Building oldfm..."
cd oldfm
if test -f ./oldfm.exe; then
	nmake "-f Makefile-vc.mak clean" || abort "Failed to clean before building oldfm!"
fi
nmake "-f Makefile-vc.mak" && echo "oldfm built successfully." || abort "oldfm failed to build!"

echo

