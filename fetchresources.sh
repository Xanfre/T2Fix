#!/bin/sh
# Fetch resources not included in the source tree.

ogg_encode()
{
	# In config.sh, set WINE to 'wine' or the location of your Wine binary if
	# you need to use it.
	DIR=$1
	echo "Encoding files in ${DIR}..."
	for i in "$DIR"/*.[wW][aA][vV]; do $WINE ./oggenc2.exe "$i" > /dev/null 2>&1 || abort "Failed to encode all files in ${DIR}!"; done
	rm -f "$DIR"/*.[wW][aA][vV]
	echo "Successfully encoded all files in ${DIR}."
}

cd $(dirname $0)

. ./common.sh

if test -f ./config.sh; then
	. ./config.sh
fi

OGGENC_VER="2.88-1.3.7-generic"
OGGDEC_VER="1.10.1"
OPENAL_VER="1.23.1"
LAME_VER="3.100"
_7Z_VER="2301"
T2FIXED_VER="1.3b"
T2FMDML_VER="R4"

echo "Checking for prerequisites..."
check_command curl
check_command 7z
check_command patch
check_command bspatch

if ! test -f ./oggenc2.exe; then
	mkdir -p cache
	curl_fetch "oggenc${OGGENC_VER}.zip" "https://www.rarewares.org/files/ogg/oggenc${OGGENC_VER}.zip" c56dbcfca7bd50cf23595acaaffb02c59522e5c4d05e9b1ea833876443e7726e
	extract "oggenc${OGGENC_VER}.zip" .
	chmod +x oggenc2.exe
fi

if test -d ./Resources; then
	read -p "Resources directory already present. Clear and assemble it again? [y/N] " CHOICE
	case $CHOICE in
		[yY])
			rm -rf Resources
			;;
		*)
			echo "Keeping existing resources."
			exit 0
			;;
	esac
fi

echo "Fetching and verifying resources..."
mkdir -p cache
echo "https://download.mediafire.com/" > cache/mfmeta
# NewDark 1.27
curl_fetch t2_v127.zip https://archive.org/download/t2_v127/t2_v127.zip 33caca92a14acdb366211b464fbaa73113e028e9d024c9636e5a74890157ce26
# 1.18 Patch
test -f cache/Thief_2_118_Patch_Resources.7z || curl -o cache/mfmeta https://www.mediafire.com/file/d44ayz2xbqohkoh/Thief_2_118_Patch_Resources.7z/file
curl_fetch Thief_2_118_Patch_Resources.7z $(grep -o "https://download.*\.mediafire.com/.*" cache/mfmeta | cut -f1 -d\") 6e72889af72fab926197be07fb82307e3138522bcba1b248b94517dc1e27b1a6
# DromEd Basic Toolkit
test -f cache/DromEd_Basic_1.14_\(Beta4\).zip || curl -o cache/mfmeta https://www.mediafire.com/file/08px7zn9aanynjx/DromEd_Basic_1.14_\(Beta4\).zip/file
curl_fetch DromEd_Basic_1.14_\(Beta4\).zip $(grep -o "https://download.*\.mediafire.com/.*" cache/mfmeta | cut -f1 -d\") f06bce66e085829260d0117e10411d4aa04395a20cc06842dbb5f4794368374d
test -f cache/GoalMaster.7z || curl -o cache/mfmeta https://www.mediafire.com/file/7r8v321251um2kd/GoalMaster.7z
curl_fetch GoalMaster.7z $(grep -o "https://download.*\.mediafire.com/.*" cache/mfmeta | cut -f1 -d\") 8207065a21f6c48b6c9a8ac212a1cd78c97fa1e562969e4eec7a1c1a079ef28c
test -f cache/BinMaster1.0.2.zip || curl -o cache/mfmeta https://www.mediafire.com/file/mh9sg4mmg5x0llk/BinMaster1.0.2.zip/file
curl_fetch BinMaster1.0.2.zip $(grep -o "https://download.*\.mediafire.com/.*" cache/mfmeta | cut -f1 -d\") 7a7e706b85a0a595bf63273b9840d1ca4750e9be523502a6d1d497db9e27b664
test -f cache/ConvMaster2.0.1.zip || curl -o cache/mfmeta https://www.mediafire.com/file/ukszs7qj2v53h3z/ConvMaster2.0.1.zip
curl_fetch ConvMaster2.0.1.zip $(grep -o "https://download.*\.mediafire.com/.*" cache/mfmeta | cut -f1 -d\") d12e70aa90bdf66e49dc50045abd911885e1b62fb503ae697bf35315a42bc012
# OldDark
curl_fetch ddfix.zip https://github.com/Xanfre/ddfix/releases/download/1.5.13-20230904/ddfix.zip 89465226adb6ac813f7fa279c9dac72ea65fc749a634c115111074a23707aeb4
curl_fetch thief2-118.zip http://aluigi.altervista.org/patches/thief2-118.zip 1692d4c9aa0ea4cf99b2c668e0ff664e4846f6c2007c542eb494b07108757414
curl_fetch oldlgvid.zip "https://drive.google.com/uc?export=download&id=1V3_1ZLUoht_SO7MWcOyx_UR11F8N5xok" b94c257cd97219bb62405647a2c899dbcf01169e95cdb2ce3397f855991a1537
# NVScript
curl_fetch NVScript-T2.zip https://github.com/Xanfre/nvscript/releases/download/v1.3.1/NVScript-T2.zip 7cd394f45e08528c74ff3239e81be46444855291b6f1de9ee9f2369b117bb09f
# tnhScript
curl_fetch tnhscript21-final.zip https://whoopdedo.org/tnhscript21-final.zip a86ce9ade83956d72ae1aeac2251c69ceb3521e20df527cc4423d333dc48b219
# Public Scripts
curl_fetch pubscripts21-final.zip https://whoopdedo.org/pubscripts21-final.zip 7b8f26029ad090024f91745be7197bd6e97778bdba49485a9a61e881c61d9be3
curl_fetch pubscripts22.zip https://github.com/Xanfre/publicscripts/releases/download/2.2-20230917/pubscripts22.zip 056f79dd41934c8a9d160fbfc1b3afff624a52663324cac044ddcb4e26005b1a
# LgScript
curl_fetch lgscript1.zip https://github.com/Xanfre/lgscript/releases/download/1.0-20230917/lgscript1.zip 86cb2f04b2e4f50b366ce882926e17190454191a6a7af6eba74ddf40087114bb
# DMM
curl_fetch dmm.exe https://github.com/pshjt/dmm/releases/download/v1.1.1/dmm.exe 6533e8149b6b2a7845ee1b05c06dd514d2b5442150b187295436ccaa60f9803e
# AM16's Thief2 Fixed
test -f "cache/AM16's_Thief2_Fixed_${T2FIXED_VER}.zip" || curl -o cache/mfmeta "https://www.mediafire.com/file/pm5v0ie9j8yukmr/AM16's_Thief2_Fixed_${T2FIXED_VER}.zip/file"
curl_fetch "AM16's_Thief2_Fixed_${T2FIXED_VER}.zip" $(grep -o "https://download.*\.mediafire.com/.*" cache/mfmeta | cut -f1 -d\") 39545018017256ebc7195fe0b6f1ff7a4fdb7f18fdfde8dc636b90d237525130
# Carry Body Mod
curl_fetch CarryBodyThief2.zip http://catmanofiowa.com/RSoul/CarryBodyThief2.zip f211fb7d21f79bd0bad368c212b61c0f9e8d46030ad6d71254a8aee8125aafa0
# Interactive Candles Mod
curl_fetch T2_candlesTP.7z "https://drive.google.com/uc?export=download&id=1Sb8MXpJK4bzp3g7jhgNEoLIp1YSzIlQR" b89254972689e6587af6b2ce19f4319ab916f7c17ce47687b3a04e70362ae7d1
# t2skies
curl_fetch t2skies.zip https://darkfate.org/view/details/files/misc_stuff/jermi/t2skies.zip e02109c75e57f133e76ffc30fa5e58c38fef163c561a298dd2074d6942223b6c
curl_fetch t2skies.jpg https://darkfate.org/view/details/files/misc_stuff/jermi/screenshots/t2skies.jpg 560d2c2393a0df3dd700da0b481da152faf9f3d79ea47f612471e305386bed90
curl_fetch t2skies_interference.jpg https://darkfate.org/view/details/files/misc_stuff/jermi/screenshots/t2skies_interference.jpg ad2bb28081b19a6db2c46143416fcf1b3c9de10ca9a3cc9cf178187ca2a09f14
curl_fetch t2skies_masks.jpg https://darkfate.org/view/details/files/misc_stuff/jermi/screenshots/t2skies_masks.jpg 80d99445e9ec3e0118eaf51f2564c9908fdef73499d486e37775eb7d1adea1a6
curl_fetch distcit_desktop.jpg https://darkfate.org/view/details/files/misc_stuff/jermi/screenshots/distcit_desktop.jpg 4cda9f6daf0b39dd88b643c72eb67ecac63118e4c0fc4de96da243c5555a17ba
# t2water
curl_fetch t2water.zip https://darkfate.org/view/details/files/misc_stuff/jermi/t2water.zip 6830ca562424b177357727e49ed649effc04679e425f92c534828171a4d2a5c7
curl_fetch t2water_ambush.jpg https://darkfate.org/view/details/files/misc_stuff/jermi/screenshots/t2water_ambush.jpg 282c007a5cc7fc09b37a951e9ffba8816fdbcf3336fc9ba13559b205b61061a9
# EP
curl_fetch ThiefEP1.zip https://web.archive.org/web/20101216230543/http://keepofmetalandgold.com/files/ThiefEP1.zip f600a2683e4335e7e3e91b173b422cd8d4cf0fa70c0e44430116d007c7fa4f27
# Thief 2 Sound Effects Enhancement Pack
curl_fetch Thief2SoundFXEnhancement.exe http://www.jaybmusic.net/Eidos/Thief2SoundFXEnhancement.exe 2bc8391b7d7b5cafa93aba9a87e3860da4af9c20da3249fcd329dc52b00b21e9
# Thief 2 English Subtitles
curl_fetch Thief\ 2\ English\ Subtitles\ \(Only\ voiced\ ingame\ and\ video\ lines\).rar "https://drive.google.com/uc?export=download&id=160DvutT7vbyOSgscSM76DKybAfczqUX_" 327d3cb2428099b85b2be9c62e090cc6fb41617f5826f90f556ad13304eac721
# T2FMDML
curl_fetch "T2FMDML_${T2FMDML_VER}.zip" "https://github.com/Xanfre/T2FMDML/releases/download/${T2FMDML_VER}/T2FMDML_${T2FMDML_VER}.zip" 065610582a76ddec60f15b922c80f1f0a11589a59cc7e6ae019eb13c3cd9570a
# OpenAL Soft
curl_fetch "openal-soft-${OPENAL_VER}-bin.zip" "https://openal-soft.org/openal-binaries/openal-soft-${OPENAL_VER}-bin.zip" ea8bc36fd7fa05f64e13400d20886de753a227202a4ea3781913489a26b36fc6
# libmp3lame
curl_fetch "libmp3lame-${LAME_VER}x86.zip" "http://rarewares.org/files/mp3/libmp3lame-${LAME_VER}x86.zip" 75690f5c187eb5e79d24cd3d884890f5fd991e29a5375f336ea099124b7cbc09
# Helpers
curl_fetch "7z${_7Z_VER}-extra.7z" "https://7-zip.org/a/7z${_7Z_VER}-extra.7z" db3a1cbe57a26fac81b65c6a2d23feaecdeede3e4c1fe8fb93a7b91d72d1094c
curl_fetch "oggdecV${OGGDEC_VER}.zip" "https://www.rarewares.org/files/ogg/oggdecV${OGGDEC_VER}.zip" 8180bafd818da3ddd8a56e0d0612561ff0d8964810c9d3876423f9c1b8190bfe
# Utilities (oldfm and miss16shim)
if ! test -f ./util/oldfm/oldfm.exe || ! test -f ./util/miss16shim/miss16.osm; then
	read -p "Utilities (oldfm or miss16shim) were not found. Build them now? [y/N] " CHOICE
	case $CHOICE in
		[yY])
			./util/build.sh
			;;
		*)
			abort "Utilities not built. Please build them before continuing."
			;;
	esac
	if ! test -f ./util/oldfm/oldfm.exe || ! test -f ./util/miss16shim/miss16.osm; then
		abort "Utilities failed to build!"
	fi
fi
echo "All resources fetched and verified."

echo "Populating Resources directory..."
mkdir -p Resources
# NewDark
mkdir -p cache/t2_v127
extract t2_v127.zip cache/t2_v127 new_dark.zip\ contrib.zip\ editor.zip\ mp.zip\ EnableLAA.exe\ release_notes.txt\ troubleshooting.txt
for i in newdark config advanced multiplayer; do mkdir -p Resources/$i; done
extract t2_v127/new_dark.zip Resources/newdark
for i in cam_ext.cfg cam_mod.ini; do mv Resources/newdark/$i Resources/config/; done
printf '\r\n;use high-quality object textures\r\nObjTextures16\r\nMeshTextures16\r\n' >> Resources/config/cam_ext.cfg
for i in txt exe; do cp -p cache/t2_v127/*.$i Resources/newdark/; done
extract t2_v127/contrib.zip Resources/newdark/
extract t2_v127/mp.zip Resources/multiplayer/
for i in DEFAULT.BND MENUS.CFG cam.cfg; do cp -p config/$i Resources/config/; done
cp -p patches/advanced/*.dml Resources/advanced/
for i in gen.osm miss12.osm miss15.osm; do apply_binpatch Resources/multiplayer/$i Resources/multiplayer/$i patches/multiplayer/$i.patch; done
mv Resources/multiplayer/miss16.osm Resources/multiplayer/miss16_aux.osm
cp -p util/miss16shim/miss16.osm Resources/multiplayer/
# DromEd
mkdir -p Resources/dromed
extract t2_v127/editor.zip Resources/dromed
rm -rf cache/t2_v127
# Official 1.18 Patch
mkdir -p Resources/patch118
extract Thief_2_118_Patch_Resources.7z Resources/patch118
for i in english german; do rm -f Resources/patch118/$i/patch.wri; done
for i in fam mesh obj; do mkdir -p Resources/patch118/$i; extract ../Resources/patch118/$i.crf Resources/patch118/$i; rm -f Resources/patch118/$i.crf; done
for i in books intrface snd strings; do mkdir -p Resources/patch118/english/$i; extract ../Resources/patch118/english/$i.crf Resources/patch118/english/$i; rm -f Resources/patch118/$i.crf; done
for i in books intrface strings; do mkdir -p Resources/patch118/german/$i; extract ../Resources/patch118/german/$i.crf Resources/patch118/german/$i; rm -f Resources/patch118/$i.crf; done
cd Resources/patch118
rm -rf *.crf english/*.crf german/*.crf
archive res.7z fam\ mesh\ obj\ english\ german
rm -rf fam mesh obj english german
cd ../..
# Dromed Basic Toolkit
mkdir -p Resources/dromedtk
extract DromEd_Basic_1.14_\(Beta4\).zip Resources/dromedtk
mv Resources/dromedtk/RES/editor.crf Resources/dromedtk/editor.crf
cp -rp Resources/dromedtk/Tools/Thief2\ Newdark\ Dromed/Schema Resources/dromedtk/Schema
mv Resources/dromedtk/Schema/Original\ Thief2 Resources/dromedtk/Schema/original
for i in RES Tools/OldDark\ Installs User.cfg Docs/Thumbs.db Docs/Tutorials/Optimization\ Tutorial/Thumbs.db; do rm -rf "Resources/dromedtk/${i}"; done
mv Resources/dromedtk/Tools/3ds\ to\ bin Resources/dromedtk/Tools/3ds_to_bin
for i in ConvMaster\ 2.0.1 BinMaster\ 1.0.2 GoalMaster\ 1.01; do mkdir -p "Resources/dromedtk/Tools/${i}"; done
extract ConvMaster2.0.1.zip Resources/dromedtk/Tools/ConvMaster\ 2.0.1
extract BinMaster1.0.2.zip Resources/dromedtk/Tools/BinMaster\ 1.0.2
extract GoalMaster.7z Resources/dromedtk/Tools/GoalMaster\ 1.01
mv Resources/dromedtk/Tools/ConvMaster\ \ 1.1.1/TTLG\ -\ ConvMaster.URL Resources/dromedtk/Tools/ConvMaster\ 2.0.1/
mv Resources/dromedtk/Tools/DEOCI\ v1.4.1/TTLG\ -\ Dark\ Engine\ Object\ Converter\ Interface.URL Resources/dromedtk/Tools/BinMaster\ 1.0.2/TTLG\ -\ BinMaster.URL
mv Resources/dromedtk/Tools/GoalMaster\ 1.0/TTLG\ -\ GoalMaster.URL Resources/dromedtk/Tools/GoalMaster\ 1.01/
sed -i "s|141601|149975|" Resources/dromedtk/Tools/BinMaster\ 1.0.2/TTLG\ -\ BinMaster.URL
for i in ConvMaster\ \ 1.1.1 DEOCI\ v1.4.1 GoalMaster\ 1.0; do rm -rf "Resources/dromedtk/Tools/${i}"; done
# OldDark
mkdir -p Resources/olddark/OLDSV
extract thief2-118.zip cache thief2.exe
apply_binpatch cache/thief2.exe Resources/olddark/thief2_no_ddfix.exe patches/olddark/thief2.patch
apply_binpatch cache/thief2.exe Resources/olddark/thief2_ddfix.exe patches/olddark/thief2_ddfix.patch
rm -f cache/thief2.exe
extract ddfix.zip Resources/olddark
extract oldlgvid.zip Resources/olddark
cp -p patches/olddark/OldDark_readme.txt Resources/olddark/
cp -p config/[cC][fF][gG]* Resources/olddark/OLDSV/
cp -p Resources/config/cam.cfg Resources/olddark/old.cfg
sed -i "s|darkinst|oldinst|" Resources/olddark/old.cfg
cp -p util/oldfm/oldfm.exe Resources/olddark/
cp -p config/oldfm.cfg Resources/olddark/
# Squirrel
mkdir -p Resources/osm/OSM
cp -p Resources/newdark/squirrel.osm Resources/osm/OSM/
# NVScript
extract NVScript-T2.zip Resources/osm/OSM
# tnhScript
extract tnhscript21-final.zip Resources/osm/OSM tnhScript.osm\ Readme.txt
mv Resources/osm/OSM/Readme.txt Resources/osm/OSM/tnhScript_readme.txt
sed -i "s|http://whoopdedo.org/doku|https://dromed.whoopdedo.org|" Resources/osm/OSM/tnhScript_readme.txt
# Public Scripts
extract pubscripts21-final.zip Resources/osm/OSM dh2.osl
extract pubscripts22.zip Resources/osm/OSM script-t2.osm\ version.osm\ readme.txt
cp -p Resources/osm/OSM/script-t2.osm Resources/osm/OSM/script.osm
mv Resources/osm/OSM/dh2.osl Resources/osm/
mv Resources/osm/OSM/readme.txt Resources/osm/OSM/pubscripts_readme.txt
# LgScript
extract lgscript1.zip Resources/osm/OSM lgs.osm\ readme.txt
mv Resources/osm/OSM/readme.txt Resources/osm/OSM/lgscript_readme.txt
# DMM
mkdir -p Resources/dmm
cp -p cache/dmm.exe config/dmm.cfg Resources/dmm/
# AM16's Thief2 Fixed
mkdir -p mods/Thief2\ Fixed
extract "AM16's_Thief2_Fixed_${T2FIXED_VER}.zip" Resources/mods/Thief2\ Fixed
mv Resources/mods/Thief2\ Fixed/FM.rtf Resources/mods/Thief2\ Fixed/Readme.rtf
for i in *.dml Mesh/LM*.bin; do rm -f Resources/mods/Thief2\ Fixed/$i; done
for i in gloc*.bin mecgas*.bin mector*.bin newt*.bin pagtor*.bin readme.txt; do rm -f Resources/mods/Thief2\ Fixed/Obj/$i; done
for i in txt Disabled; do mkdir -p Resources/mods/Thief2\ Fixed/Obj/$i; done
mv Resources/mods/Thief2\ Fixed/Obj/blacjack.bin Resources/mods/Thief2\ Fixed/Obj/Disabled/
for i in BLACJAC4.png hiltsx.tga; do mv Resources/mods/Thief2\ Fixed/Obj/Txt16/$i Resources/mods/Thief2\ Fixed/Obj/Txt16/Disabled/; done
mkdir -p Resources/mods/Thief2\ Fixed/Mesh/Disabled
mv Resources/mods/Thief2\ Fixed/Mesh/bjachand.bin Resources/mods/Thief2\ Fixed/Mesh/Disabled/
for i in Hiltsx.tga bjhand.tga swhand.tga; do mv Resources/mods/Thief2\ Fixed/Mesh/txt16/$i Resources/mods/Thief2\ Fixed/Mesh/txt16/disabled/; done
for i in *.dml sq_scripts; do cp -rp patches/Thief2Fixed/$i Resources/mods/Thief2\ Fixed/; done
cp -p patches/Thief2Fixed/obj/*.bin Resources/mods/Thief2\ Fixed/Obj/
cp -p patches/Thief2Fixed/obj/*.pcx Resources/mods/Thief2\ Fixed/Obj/
cp -p patches/Thief2Fixed/obj/txt/* Resources/mods/Thief2\ Fixed/Obj/txt/
cp -p patches/Thief2Fixed/obj/txt16/* Resources/mods/Thief2\ Fixed/Obj/Txt16/
cp -p patches/Thief2Fixed/mesh/*.bin Resources/mods/Thief2\ Fixed/Mesh/
cp -p patches/Thief2Fixed/mesh/txt16/* Resources/mods/Thief2\ Fixed/Mesh/txt16/
for i in miss11 miss15; do apply_binpatch Resources/mods/Thief2\ Fixed/$i.mis Resources/mods/Thief2\ Fixed/$i.mis patches/Thief2Fixed/$i.patch; done
# Carry Body Mod
mkdir -p Resources/mods/CarryBody
extract CarryBodyThief2.zip Resources/mods/CarryBody
mv Resources/mods/CarryBody/CarryBodyThief2/CarryBody/* Resources/mods/CarryBody/
mv Resources/mods/CarryBody/CarryBodyThief2/cb_T2_readme.txt Resources/mods/CarryBody/readme.txt
rm -rf Resources/mods/CarryBody/CarryBodyThief2
apply_patch Resources/mods/CarryBody ../../../patches/carrybody.patch
# Interactive Candles Mod
mkdir -p Resources/mods/Candles
extract T2_candlesTP.7z Resources/mods/Candles
rm -rf Resources/mods/Candles/obj
apply_patch Resources/mods/Candles ../../../patches/candles.patch
# t2skies
mkdir -p Resources/mods/t2skies/images
extract t2skies.zip Resources/mods/t2skies
for i in t2skies FAM/skyhw/*.pcx; do rm -rf Resources/mods/t2skies/$i; done
mv Resources/mods/t2skies/RES/ddfix/t2skies/*.dds Resources/mods/t2skies/FAM/skyhw/
rm -rf Resources/mods/t2skies/RES
for i in t2skies t2skies_interference t2skies_masks distcit_desktop; do cp -p cache/$i.jpg Resources/mods/t2skies/images/; done
cp -p patches/t2skies/*.dml Resources/mods/t2skies/
apply_patch Resources/mods/t2skies ../../../patches/t2skies.patch
# t2water
mkdir -p Resources/mods/t2water/images
extract t2water.zip Resources/mods/t2water
rm -f Resources/mods/t2water/FAM/WATERHW/*.pcx
mv Resources/mods/t2water/RES/ddfix/t2water/*.dds Resources/mods/t2water/FAM/WATERHW/
find Resources/mods/t2water/FAM/WATERHW -type f -name '*in*' | while read FILE; do
	NEWFILE=$(echo "$FILE" | sed -e 's/in/out/')
	cp -p "$FILE" "$NEWFILE"
done
rm -rf Resources/mods/t2water/RES
cp -p cache/t2water_ambush.jpg Resources/mods/t2water/images
cp -p patches/t2water/*.mtl Resources/mods/t2water/FAM/WATERHW/
apply_patch Resources/mods/t2water ../../../patches/t2water.patch
# EP
mkdir -p cache/EP
extract ThiefEP1.zip cache/EP
mkdir -p Resources/mods/EP
for i in txt htm; do cp -p cache/EP/Readme.$i Resources/mods/EP/; done
extract EP/EP.crf Resources/mods/EP
rm -rf cache/EP Resources/mods/EP/Thief1
for i in ArmSw2.bin ArmSw2.cal conswd.bin conswd.cal; do rm -f Resources/mods/EP/Mesh/$i; done
for i in BladeSP NVConSwH NVSwHandle SwHilt sw2_blade; do rm -f Resources/mods/EP/Mesh/Txt16/$i.gif; done
for i in Sword SwordCon Swords; do rm -f Resources/mods/EP/Obj/$i.bin; done
for i in BladeSP SwordBl sw2_blade; do rm -f Resources/mods/EP/Obj/Txt16/$i.gif; done
cp -p patches/ep/obj/*.bin Resources/mods/EP/Obj/
cp -p patches/ep/obj/txt16/*.[gG][iI][fF] Resources/mods/EP/Obj/Txt16/
rm -rf cache/EP
# Thief 2 Sound Effects Enhancement Mod
extract Thief2SoundFXEnhancement.exe cache SoundUpdate/NewT2SFX.7z
mkdir -p Resources/mods/NewT2SFX/snd
extract SoundUpdate/NewT2SFX.7z Resources/mods/NewT2SFX/snd
rm -rf cache/SoundUpdate
ogg_encode Resources/mods/NewT2SFX/snd/Doors
ogg_encode Resources/mods/NewT2SFX/snd/Feet
ogg_encode Resources/mods/NewT2SFX/snd/SFX
# Subtitles
mkdir -p Resources/mods/Subtitles
extract Thief\ 2\ English\ Subtitles\ \(Only\ voiced\ ingame\ and\ video\ lines\).rar Resources/mods/Subtitles
apply_patch Resources/mods/Subtitles ../../../patches/subtitles.patch
# T2FMDML
mkdir -p Resources/mods/T2FMDML
extract "T2FMDML_${T2FMDML_VER}.zip" Resources/mods/T2FMDML
# OpenAL Soft
mkdir -p Resources/libs
extract "openal-soft-${OPENAL_VER}-bin.zip" Resources/libs "openal-soft-${OPENAL_VER}-bin/bin/Win32/soft_oal.dll"
mv "Resources/libs/openal-soft-${OPENAL_VER}-bin/bin/Win32/soft_oal.dll" Resources/libs/OpenAL32.dll
rm -rf "Resources/libs/openal-soft-${OPENAL_VER}-bin"
# libmp3lame
extract "libmp3lame-${LAME_VER}x86.zip" Resources/libs libmp3lame.dll
# Helpers
mkdir -p Resources/helper
extract "7z${_7Z_VER}-extra.7z" Resources/helper 7za.exe
extract "oggdecV${OGGDEC_VER}.zip" Resources/helper
echo "Resources directory populated."

echo

