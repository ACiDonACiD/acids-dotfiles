#!/usr/bin/env bash

FILE="/tmp/system-startup.tmp"

# Invoke the '__generate_init_file'. This prevents 
# the message from running every time the shell is 
# launched, instead only on the initial executing of
# the shell.
__generate_init_file() {
  date > "$FILE"
}

# Generate the initial message
__shell_welcome_msg() {
    echo -e "\e[33;1m"

      printf 'Welcome back %s\n' "${USER}"
      printf '\n'
      hostnamectl

    echo -e "\e[0m"
}

if [[ ! -f "${FILE}" ]]; then
  __generate_init_file 
  __shell_welcome_msg
fi
