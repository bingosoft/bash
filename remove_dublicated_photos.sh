#!/usr/bin/env bash

if [ $# -ne 1 ]; then
	echo "Please provide directory location. Exiting."
	exit 1
fi

LOCATION="$1"
ORIG_IFS="$IFS"
IFS=$'\n'

pushd "$LOCATION"

for file in `ls -1 *\(*\).*`; do # pattern example "IMG_123 (2).jpeg"
	basename="${file% *}"
	extension="${file##*.}"
	maxSize="9223372036854775807"
	bestFile=""

	echo "Duplicates for $basename:"

	for similarFile in `ls -1 $basename*`; do
		size=`stat -f%z "$similarFile"`

		echo "$similarFile, size - $size"

		if [[ $size -lt $maxSize ]]; then
			echo "Store new better size - $size for file $similarFile"
			maxSize=$size
			bestFile="$similarFile"
		fi
	done

	echo "The best file is $bestFile with size $maxSize"

	for similarFile in `ls -1 $basename*`; do
		if [ "$similarFile" != "$bestFile" ]; then
			echo "Removing bigger copy $similarFile"
			rm "$similarFile"
		fi
	done

	echo "Rename $bestFile to $basename.$extension"
	mv "$bestFile" "$basename.$extension"
done

popd

IFS="$ORIG_IFS"
