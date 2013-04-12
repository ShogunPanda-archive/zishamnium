#!/bin/zsh
#
# This file is part of zishamnium. Copyright (C) 2013 and above Shogun <shogun_panda@me.com>.
# Licensed under the MIT license, which can be found at http://www.opensource.org/licenses/mit-license.php.
#

if [ "$(which git)" != "" ]; then
  git config --global alias.fbn '! git symbolic-ref HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null'
  git config --global alias.bn '! git fbn | sed "s#refs/heads/##"'
  git config --global alias.task '! git bn | sed -E "s/(.+)-([0-9]+)$/\2/g"'
fi

git_prompt(){
  local branch=$(git bn 2>/dev/null)

  if [ ! -z "$branch" ]; then
    local revision=$(git rev-parse --short HEAD 2>/dev/null)

    if [ ! -z "$revision" ]; then
      echo "${branch}@${revision}"
    else
      echo "${branch}"
    fi
  fi
}