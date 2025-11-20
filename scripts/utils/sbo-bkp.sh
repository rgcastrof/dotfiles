#!/bin/bash

bkp_dir="/var/cache/packages/backup/tgz"
installed=$(find /var/log/packages/ -type f -name "*_SBo" -printf "%f ")

for pkg in $installed; do
	tgz=$(find /tmp/ -maxdepth 1 -name "$pkg*")
	if [ -n "$tgz" ]; then
		cp "$tgz" "$bkp_dir"
	fi
done
