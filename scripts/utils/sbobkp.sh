#!/bin/bash

bkp_dir="/var/cache/packages/backup/SBo"
mkdir -p "$bkp_dir"
installed=$(find /var/log/packages/ -type f -name "*_SBo" -printf "%f ")

for pkg in $installed; do
	tgz=$(find /tmp/ -maxdepth 1 -name "$pkg*")
	if [ -n "$tgz" ]; then
		echo "backing up SBo: $tgz to $bkp_dir..."
		if cp "$tgz" "$bkp_dir"; then
			echo "Done."
		else
			echo "ERROR."
		fi
	fi
done

echo "Cloning backup dir to pendrive..."
if cp -r "/var/cache/packages/backup/SBo" "/home/rogi/backup"; then
	echo "Packages backup done."
fi

echo "Backing up kernels to pendrive..."
if cp -r "/var/cache/packages/backup/kernels" "/home/rogi/backup"; then
	echo "Kernels backup done."
fi
