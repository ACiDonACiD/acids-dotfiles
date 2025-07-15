#!/hint/bash
	
printf "[+] Currently sourcing: ~/.bash_logout. \n"

trap_exit() {

  echo "Exitting..."
  sleep 2s
  exit 0
}

trap trap_exit EXIT
