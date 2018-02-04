#!/bin/zsh
#
# This file is part of zishamnium. Copyright (C) 2013 and above Shogun <shogun@cowtech.it>.
# Licensed under the MIT license, which can be found at https://choosealicense.com/licenses/mit.
#

# PROMPT
local prompt_date="%D{%Y-%m-%d %H:%M}" # format as in strftime
local prompt_username="%n"
local prompt_hostname="%m"
local prompt_dir="%50<...<%~%<<%"
local prompt_number="%h"
local prompt_type="%#"

# SET USERNAME PROMPT COLOR
local prompt_username_color="$fg_bold[green]"
[ "$UID" = "0" ] && prompt_username_color="$fg_bold[red]"

# SET RVM PROMPT
prompt_rvm(){
  local rvm="$(rvm_current)"
  [ ! -z "${rvm}" ] && rvm=" ${rvm}"
  echo "${rvm}"
}

# SET GIT PROMPT
prompt_git(){
  local git="$(git_branch)"

  if [ ! -z "${git}" ]; then    
    local git_commit=$(git_commit)
    local git_status=$(parse_git_dirty)
    local git_status_color="$fg_bold[green]"

    [ "${git_status}" = "${ZSH_THEME_GIT_PROMPT_DIRTY}" ] && git_status_color="$fg[red]"
    [ ! -z "${git_commit}" ] && git_commit="%{$fg_no_bold[magenta]%} ${git_commit}"
    git=" %{$fg_bold[magenta]%}(${git}%{$fg[magenta]%}${git_commit}%{$fg_bold[magenta]%})%{$reset_color%} %{$git_status_color%}${git_status}%{$reset_color%}"
  fi

  echo "$git"
}

# # SET THE PROMPT
PROMPT='$fg[yellow]%}[%{$fg_bold[white]%}${prompt_date}%{$fg[yellow]%}] %{$fg_bold[blue]%}$prompt_dir $(prompt_git)%{$reset_color%}
%{$fg[yellow]%}[%{$prompt_username_color%}${prompt_username}@${prompt_hostname}%{$fg_no_bold[red]%}$(prompt_rvm)%{$fg[yellow]%}] ${prompt_type}>%{$reset_color%} '

RPS1="${return_code}"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[magenta]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=" %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="✔"
ZSH_THEME_GIT_PROMPT_DIRTY="✗"