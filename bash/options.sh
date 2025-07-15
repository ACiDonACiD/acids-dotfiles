#!/usr/bin/env bash

    # Custom path for bash history
        HISTFILE="$HOME/.config/bash/log/.bash_history"

    # Format history output: YYYY-MM-DD HH:MM:SS
        HISTTIMEFORMAT="%F %T "

    # A colon-separated list of values, of which each value
    # determines how a command is saved to the history list.
    # if the 'HISTCONTROL' is unset or provides no valid
    # entries, then control is subject to the values of
    # 'HISTIGNORE'
        HISTCONTROL=ignoreboth

    # A colon-separated(:) list of patterns. Each pattern
    # undergoes an evaluation, used to determine which entries 
    # are stored within the history file (see HISTFILE).
    #  NOTE: The 'HISTIGNORE' subsumes the function of 'HISTCONTROL'
        HISTIGNORE=help

    # Set history buffer sizes
        HISTSIZE=4096
        HISTFILESIZE=4096

    # append to the history file, don't overwrite it
        shopt -s histappend

    # check the window size after each command and, if necessary,
    # update the values of LINES and COLUMNS.
        shopt -s checkwinsize

    # Directories to be appended to $PATH
    declare -a DIR_BUFFER=(
        "$HOME/Documents"
    )

    # Loop through each entry and append if not already in $PATH
    for __DIR__ in "${DIR_BUFFER[@]}"; do
        if [[ -n "$__DIR__" && ":$PATH:" != *":$__DIR__:"* ]]; then
            export PATH="${PATH}:${__DIR__}"
        fi
    done

