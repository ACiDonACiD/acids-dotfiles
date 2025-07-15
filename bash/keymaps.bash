#!/usr/bin/env bash

# ╭──────────────────────────────────────────────────────────────╮
# │                      BASH KEYMAPS (READLINE)                  │
# ╰──────────────────────────────────────────────────────────────╯

# EXAMPLE SETUP

# Enable Ctrl+Left/Right word-jumping in Bash (Readline)
# bind '"\e[1;5C": forward-word'     # Ctrl + Right
# bind '"\e[1;5D": backward-word'    # Ctrl + Left

# Common alternative escape sequences (varies by terminal)
# bind '"\e[5C": forward-word'
# bind '"\e[5D": backward-word'
# bind '"\e[1;3C": forward-word'
# bind '"\e[1;3D": backward-word'

# Ctrl+Backspace to delete previous word (terminal-dependent)
# bind '"\e[3;5~": kill-word'
# bind '"\C-w": unix-word-rubout'  # Default: delete previous word

# Custom key binding: Ctrl+G to clear the screen
# bind '"\C-g": "clear\n"'

# Emacs or Vi mode (choose one — Emacs is default)
# set -o emacs
# set -o vi
