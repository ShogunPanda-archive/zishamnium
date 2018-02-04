#!/bin/sh
#
# This file is part of zishamnium. Copyright (C) 2013 and above Shogun <shogun@cowtech.it>.
# Licensed under the MIT license, which can be found at https://choosealicense.com/licenses/mit.
#

# Load configuration files
for file in ~/.zishamnium/modules/*; do
	[ -x ${file} ] && source ${file}
done;