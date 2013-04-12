#!/bin/zsh
#
# This file is part of shamnium. Copyright (C) 2013 and above Shogun <shogun_panda@me.com>.
# Licensed under the MIT license, which can be found at http://www.opensource.org/licenses/mit-license.php.
#

# PROMPT
local prompt_date="%D{%Y-%m-%d %H:%M}" # format as in strftime
local prompt_username="%n"
local prompt_hostname="%m"
local prompt_dir="%50<...<%~%<<%"
local prompt_number="%h"
local prompt_type="%#"

# SET USERNAME PROMPT COLOR
local prompt_username_color="$fg[green]"
[ "$UID" = "0" ] && prompt_username_color="$fg[red]"

# SET RVM PROMPT
prompt_rvm(){
  local rvm="$(rvm_prompt)"
  [ ! -z "${rvm}" ] && rvm=" ${rvm}"
  echo "${rvm}"
}

# SET GIT PROMPT
prompt_git(){
  local git="$(git_prompt)"

  if [ ! -z "${git}" ]; then    
    local git_status=$(parse_git_dirty)
    local git_status_color="$fg[green]"
    [ "${git_status}" = "${ZSH_THEME_GIT_PROMPT_DIRTY}" ] && git_status_color="$fg[red]"

    git=" %{$fg[magenta]%}($git%{$fg[magenta]%})%{$reset_color%} %{$git_status_color%}${git_status}%{$reset_color%}"
  fi

  echo "$git"
}

# # SET THE PROMPT
PROMPT='%{$terminfo[bold]$fg[yellow]%}[%{$fg[white]%}${prompt_date}%{$fg[yellow]%}] %{$fg[blue]%}$prompt_dir %{$fg[magenta]%}$(prompt_git)%{$reset_color%}
%{$terminfo[bold]$fg[yellow]%}[%{$prompt_username_color%}${prompt_username}@${prompt_hostname}%{$fg[red]%}$(prompt_rvm)%{$terminfo[bold]$fg[yellow]%}] ${prompt_type}>%{$reset_color%} '

RPS1="${return_code}"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[magenta]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="✔"
ZSH_THEME_GIT_PROMPT_DIRTY="✗"