#!/bin/bash

SOURCES="../Sources"

# Filters:

remove_brackets_if() {
	cat | sed 's/if (\(.*\)) {/if \1 {/g'
}

remove_brackets_while() {
	cat | sed 's/while (\(.*\)) {/while \1 {/g'
}

remove_brackets_guard() {
	cat | sed 's/guard (\(.*\)) {/guard \1 {/g'
}

remove_brackets_switch() {
	cat | sed 's/switch (\(.*\)) {/switch \1 {/g'
}

replace_spaces_to_tabs() {
	cat | sed 's/    /	/g'
}


for file in `find $SOURCES -name '*.swift'`; do
	echo $file
	cat "$file" |
	remove_brackets_if |
	remove_brackets_while |
	remove_brackets_guard |
	remove_brackets_switch |
	replace_spaces_to_tabs > $file.tmp

	if [ $? -eq 0 ]; then
		mv $file.tmp $file
	else
		rm $file.tmp
	fi
done

