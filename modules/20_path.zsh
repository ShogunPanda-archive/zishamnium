#!/bin/zsh
#
# This file is part of zishamnium. Copyright (C) 2013 and above Shogun <shogun@cowtech.it>.
# Licensed under the MIT license, which can be found at https://choosealicense.com/licenses/mit.
#

for root in /usr/local /opt /var; do
	if [ -d ${root} ]; then
		for dir in ${root}/bin ${root}/sbin; do
			if [ -d ${dir} ]; then
				PATH=${dir}:$PATH
			fi
		done;
	fi;
done;

export PATH