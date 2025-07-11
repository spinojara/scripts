#!/bin/bash

output="selfplay.bit"

> "$output"

examine_dir() {
	dir=$1

	for file in "$dir"/*; do
		if [[ "$file" == *".bit" ]]; then
			checkbit $file
			if [ $? -eq 0 ]; then
				cat "$file" >> "$output"
			else
				echo "$file contains errors. Skipping..."
			fi
		else
			echo "$file is probably not a game file. Skipping..."
		fi
	done
}

for arg in "$@"; do
	if [[ "$arg" == *".tar"* ]]; then
		base=$(tar -tf "$arg" | head -n 1)
		tar -xf "$arg"
		echo "Entering $arg."
		examine_dir $base
		rm -r "$base"
		echo "$arg done."
	else
		echo "$arg is not an archive. Skipping..."
	fi
done
