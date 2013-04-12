#!/bin/zsh
#
# This file is part of zishamnium. Copyright (C) 2013 and above Shogun <shogun_panda@me.com>.
# Licensed under the MIT license, which can be found at http://www.opensource.org/licenses/mit-license.php.
#

[ -f ${rvm_path}/scripts/rvm ] && source ${rvm_path}/scripts/rvm;

rvm_prompt(){
  [ "$(which rvm-prompt)" != "" -a "$(rvm-prompt i)" != "" ] && rvm-prompt i v g
}