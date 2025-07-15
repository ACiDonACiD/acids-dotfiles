#!/hint/bash

printf "[+] Currently sourcing: ~/.bashrc. \n" > /home/kieran/.config/bash/log/shell.log

if source /home/kieran/.local/share/blesh/ble.sh --noattach --rcfile /home/kieran/.blerc; then

  eval "$(zoxide init bash)"

  # Bash related files
  . /home/kieran/.config/bash//aliases.bash
  . /home/kieran/.config/bash/keymaps.bash
  . /home/kieran/.config/bash/options.sh # merge with options.bash
  
  # X server related files
  . /home/kieran/.config/.dotfiles/xorg/.xmodmap
  
  # Custom scripts
  . /home/kieran/.config/bash/util/pviewer.bash

  ble-attach
fi
