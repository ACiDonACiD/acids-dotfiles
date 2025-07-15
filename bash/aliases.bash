#!/usr/bin/env bash

alias @s='gum confirm "Confirm shutdown? " && shutdown now || echo "Shutdown cancelled"'
alias @r='gum confirm "Confirm reboot? " && reboot || echo "Reboot cancelled"'

alias v='nvim'
alias V='sudo nvim'

# Standard `ls` with enhanced formatting
alias ls='ls -l --almost-all --no-group --color=auto --file-type --group-directories-first --human-readable --tabsize=8'

#-------------------------------------------------------------------- #

function __bash_eza_alias:base() {
  declare -l timefmt='long-iso'

  declare -al __eza_options=()
 
  __eza_options=(
    '--almost-all'
    '--grid'
    '--long'
    '--no-filesize'
    '--no-permissions'
    '--group-directories-first'
    '--reverse'
    '--no-user'
    '--sort=name'
    '--icons=auto'
    '--color=auto'
    '--color-scale=all,age,size'
    '--color-scale-mode=gradient'
    '--time-style='"${timefmt}"
    '--width='"${COLUMNS}"
  )

  # debug eza base method
  function __bash_debug_eza:func() {
    echo eza "${__eza_options[@]}" "${1:-$PWD}"
  }

  # execute the base method for eza
  function __bash_exec_eza:func() {
    eza "${__eza_options[@]}" "${1:-$PWD}"
  }

  #  FIX : Current work around is an local environment variable
  #        treated as an on/off flag, The default value is a 1,
  #        when the value is set to 1(OFF/FALSE), The normal 
  #        procedure for executing eza(possibly other functions 
  #        until i implement it...), the normal procedure executes
  #        the command as normal. If the variable is set to a 
  #        value of 0(ON/TRUE), Then an alternative action is 
  #        carried out(may vary from function to function). In 
  #        the current case of eza, when a callback is made to
  #        the function '__bash_eza_alias:base' it may either
  #        carry out the generic procedures provided by eza.
  #        Alternatively a custom developer/debug has been 
  #        implemented, allowing for an improved debugging process

  local -xi DEFAULT_MODESET=0 # DEFAULT: (0)
  local -gxi CURRENT_MODESET

  # Test the current mode, apply defaults if needed
  if [[ -z "$CURRENT_MODESET" ]]; then
    CURRENT_MODESET=$DEFAULT_MODESET
  fi
  if [[ -n "$CURRENT_MODESET" ]]; then
    while [[ -n "$CURRENT_MODESET" ]]; do
      case "${CURRENT_MODESET}" in
        0) __bash_exec_eza:func "$@" ; break ;;
        1) __bash_debug_eza:func "$@" ; break ;;
        *) return 1 ;;
      esac
    done
  fi
}

# Execute the primary eza functionality
__bash_eza_alias:primary() {
  __bash_eza_alias:base "$@"
}
# Execute the secondary eza functionality
__bash_eza_alias:secondary() {
  tput clear && __bash_eza_alias:base "$@"
}
  # Aliases used to invoke eza
  alias e='__bash_eza_alias:primary'
  alias E='__bash_eza_alias:secondary'
  # Aliases used to invoke eza(tree)
  alias et='__bash_eza_alias:primary --tree'
  alias Et='__bash_eza_alias:secondary --tree'

# -------------------------------------------------------------------- #

__bash_zoxide_alias:base() {
  local _target=$1
  local _default=$HOME

  local target="${_target:-"$_default"}"

  __zoxide_z "$target"
}

__bash_zoxide_alias:primary() {
  __bash_zoxide_alias:base "$@"
}

__bash_zoxide_alias:secondary() {
  tput clear && __bash_zoxide_alias:base "$@"
}

alias z='__bash_zoxide_alias:primary'
alias Z='__bash_zoxide_alias:secondary'

# -------------------------------------------------------------------- #

# Zoxide(z) + Eza(e)
_alias:ze() {
  tput clear
  __bash_zoxide_alias:base "$1" && __bash_eza_alias:base "$PWD"
}

alias ze='_alias:ze'

# ------------------------------------------------------- #
  
__bash_source_alias:base() {
#__bash_source_alias:base -> logic
  [[ -z ${FUNCNAME[1]} ]] && echo FAIL || echo PASS
  echo "[0] -> ${FUNCNAME[0]}"
  echo "[1] -> ${FUNCNAME[1]}"
}

__bash_source_alias:primary() { 
  __bash_source_alias:base 
}

__bash_source_alias:secondary() {
  __bash_source_alias:base
}

# ------------------------------------------------------- #

alias s='__bash_source_alias:primary'
alias S='__bash_source_alias:secondary'

alias .1='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

function __pacsyu() {
  # [-z] True if string is unset/empty
  # [-n] True if string length is non-zero
  local -r param1="$*"
  local package="$param1"

  if [[ -n "$package" ]]; then
    sudo pacman -Syu "$package"
  fi
  
  sudo pacman -Syu

}

__pacache() {
  if gum confirm "Are you sure? All cache will be removed." --default="No" --timeout 10s; then
    if sudo pacman -Scc; then
      echo "Cache cleared successfully."
    else
      echo "Error clearing cache." >&2
      return 1
    fi
  else
    echo "Cache clearing cancelled."
  fi
}
alias pacache='__pacache'  # Pacman system update + install package
  alias pacsyu='__pacsyu'

  # pacman cleanup cache dir (All cache will be removed)
  alias pacache='__pacache'

alias sman='gum pager <<< $(man $(gum input))'
alias sinfo='gum pager <<< $(info $(gum input))'

_sk:alias() {
  sk --bind 'space:toggle-preview' --bind 'enter:execute([[ -f {} ]] && nvim {})' --preview '[[ -f {} ]] && bat {} ; [[ -d {} ]] && tree' --sync
}

alias sk='_sk:alias'
