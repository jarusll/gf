#!/bin/sh
set -eu

root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
cd "$root"

extra_flags="-DUI_FREETYPE_SUBPIXEL -DUI_UNICODE"
extension_linked=0

if [ -f extensions.cpp ]; then
	printf "Error: extensions.cpp already exists in the project root.\n" >&2
	exit 1
fi

ln -s "$root/extensions_v5/extensions.cpp" extensions.cpp
extension_linked=1

cleanup() {
	if [ "$extension_linked" = "1" ]; then
		rm -f extensions.cpp
	fi
}
trap cleanup EXIT

extra_flags="$extra_flags -Iextensions_v5"
extra_flags="$extra_flags" ./build.sh
