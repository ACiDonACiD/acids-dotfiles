#!/usr/bin/env sh
# Autodoc 1.0  Linux
# Copyright (c) Kieran O'Neill, 2025.
# Autodoc may be freely redistributed.  See license for details.
#
# The `setup.sh` script automates the generation of Makefiles for different parts of a Unix-based project.
# It adapts to being run from either the project root or the `sys/unix` directory.
# Optional support for a platform-specific hints file allows environment-specific customization.
# It verifies the presence of this file to prevent misconfiguration.
# The script then delegates Makefile creation to `mkmkfile.sh` for source code, docs, and utilities.
# Overall, it provsimplifies and standardizes project setup across systems.
# 
# Argument is the hints file to use (or no argument for traditional setup).
# e.g.:
#  sh setup.sh
#
#  sh setup.sh hints/XXX (from sys/unix)
#
#  sh setup.sh sys/unix/hints/XXX (from top)

# Checks if the script is run from the project root. If true, it changes to sys/unix  
# and updates the prefix to maintain correct relative paths for subsequent operations.  
# This ensures the script works regardless of the initial directory.
prefix=.
if [ -f sys/unix/Makefile.top ]; then cd sys/unix; prefix=../..; fi

case "x$1" in
x) 	hints=/dev/null
	hfile=/dev/null
	;;
*)	hints=$prefix/$1
	hfile=$1
	# Sanity checks
	if [ ! -f "$hints" ]; then
	    echo "Cannot find hints file $hfile"
	    exit 1
	fi
	;;
esac

/bin/sh ./mkmkfile.sh Makefile.top TOP ../../Makefile $hints $hfile
/bin/sh ./mkmkfile.sh Makefile.doc DOC ../../doc/Makefile $hints $hfile
/bin/sh ./mkmkfile.sh Makefile.src SRC ../../src/Makefile $hints $hfile
/bin/sh ./mkmkfile.sh Makefile.utl UTL ../../util/Makefile $hints $hfile
