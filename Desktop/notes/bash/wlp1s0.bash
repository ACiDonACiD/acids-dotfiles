#!/usr/bin/env bash

declare -x PS0='\[\e]133;C\a\]'
declare -x PS1='\[\e]133;L\a\]\[\e]133;D;$?\]\[\e]133;A\a\]'$PS1'\[\e]133;B\a\]'
declare -x PS2='\[\e]133;A\a\]'$PS2'\[\e]133;B\a\]'

export PS0 PS1 PS2
