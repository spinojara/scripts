#!/bin/bash
set -e

for arg in "$@"; do
	if [ ! -d "$arg" ]; then
		echo "$arg is not a directory. Skipping..."
		continue
	fi
	if [ -e "${arg}.tar.xz" ]; then
		echo "${arg}.tar.xz already exists. Skipping..."
		continue
	fi
	tar -cJf "${arg}.tar.xz" "$arg"
	sudo chattr +i "${arg}.tar.xz"
	rm -r "$arg"
done
