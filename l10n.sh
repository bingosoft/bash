#!/bin/bash

# Adds new localizable lines from storyboards to existing .strings file

IPad='Main_iPad';
IPhone='Main';

function generate {
	IFS=$'\n';
	s='';

	echo "Extracting strings for $1...";
	ibtool Base.lproj/$1.storyboard --generate-strings-file tmp.strings
	lines=`iconv -f UTF-16 -t UTF-8 tmp.strings`;
	rm tmp.strings

	for line in $lines; do
		objectId=`echo $line | grep -o '^"\(.*\)\.'`;

		if [ $? -eq 0 ]; then
			objectId=`echo $objectId | cut -d "=" -f2`
			grep -q $objectId ru.lproj/$1.strings

			if [ $? -ne 0 ]; then
				echo "Found new localization: $s";
				echo -e "\n$s\n$line" >> ru.lproj/$1.strings
			fi

			s='';
		else
			s="${s}${line}"
		fi
	done
}

generate $IPad
generate $IPhone

exit 0;
