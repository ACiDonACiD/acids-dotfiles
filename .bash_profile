#!/hint/bash

printf "[+] Currently sourcing: ~/.bash_profile. \n" > /home/kieran/.config/bash/log/shell.log

# Handle non-interactive
[[ "$-" != *i* ]] &&
  :

# Handle interactive sessions
[[ "$-" == *i* ]] &&
  . /home/kieran/.bashrc
