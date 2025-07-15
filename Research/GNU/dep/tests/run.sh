#!/bin/sh 

# Enable tracing for debugging (disable in production)
set -x

# CONSTANTS
MIN_ARGV=2
MAX_ARGV=6

# declare an array to store argument vectors
# The buffer will copy its contents over to 
# a local buffer inside the 'main()' entry
ARGV_BUFFER=()

function cleanup() {

#	 TODO: cleanup function implementation + logic
#	 NOTE: helper function, removes unwanted files/dirs

	echo "Cleaning up... "
	
}

# The 'main()' function will serve as a
# dedicated entry point. Construct and 
# parse the required information.
function main() {

	# declare a local argument buffer
	local -a VCBUF=()

	# Loop through the entire buffer
	# once finsihed pass it to the 
	# function and await the return
	for V in "$@"; do
	
#	 TEST: ===================================================
#_		A return value 'XXX' is to
#_		be expected; The value for 'XXX'
#_		will reference the largest integer
#_	===========================================================
		
		VCBUF+=("$V")

	

	done
}

# ARGVCOUNT | greater (>) | MIN_ARGV
# ARGVCOUNT | less (<) | MAX_ARGV
if (( ! $# > $MIN_ARGV || $# < $MAX_ARGV )); then 
	
	# Enter logic body if the check return,
	# indicates true, Then parse on to main()
	# function for further handling.
	echo "ARGV=($#)"

	(( ! set -x )) && echo "DEV_FALSE" || echo "DEV_TRUE"

fi || exit 1 # Exit Code(1) - Handle failures

