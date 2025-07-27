#!/bin/sh
# Common functions.

abort()
{
	echo "$1"
	echo "Aborting!"
	echo
	exit 1
}

check_command()
{
	CMD=$1
	command -v "$CMD" > /dev/null 2>&1 && echo "Found ${CMD} executable." || abort "Could not find ${CMD}!"
}

apply_patch()
{
	DIR=$1
	PATCH=$2
	patch -Nsp1 -d "$DIR" -i "$PATCH" && echo "Successfully applied ${PATCH} from ${DIR}." || abort "Failed to apply ${PATCH} from ${DIR}!"
}

apply_binpatch()
{
	DEST=$2
	PATCH=$3
	bspatch "$1" "$DEST" "$PATCH" && echo "Successfully applied ${PATCH} to ${DEST}." || abort "Failed to apply ${PATCH} to ${DEST}!"
}

curl_fetch()
{
	FILE=$1
	SHA256=$3
	while :; do
		if ! test -f "cache/${FILE}"; then
			echo "Downloading ${FILE}..."
			curl -LRk -o "cache/${FILE}" "$2" && echo "Downloaded ${FILE}." || abort "${FILE} could not be fetched!"
		fi
		echo "${SHA256}" "cache/${FILE}" | sha256sum -c --status && echo "${FILE} SHA256 matches ${SHA256}" && break
		read -p "${FILE} SHA256 is not recognized. Remove the file and download again? [y/N] " CHOICE
		case $CHOICE in
			[yY])
				rm -f "cache/${FILE}"
				;;
			*)
				abort "${FILE} SHA256 does not match ${SHA256}!"
				;;
		esac
	done
}

extract()
{
	FILE=$1
	echo "Extracting ${FILE}..."
	7z x -aoa -y -o"$2" "cache/${FILE}" $3 > /dev/null 2>&1 && echo "Successfully extracted ${FILE}." || abort "Could not extract ${FILE}!"
}

archive()
{
	FILE=$1
	echo "Creating ${FILE}..."
	7z a -y "$FILE" $2 > /dev/null 2>&1 && echo "Successfully created ${FILE}." || abort "Could not make ${FILE}!"
}

