#!/usr/bin/env bash
# 02/06/2025 ~ 15:02
# Bash: A simple getopts example usage program
#
# OPTARG -> If an option requires an argument getopts
#	     places that argument into the shell variable
#	     'OPTARG'
# --------------------------------------------------------
# OPTIND -> index of next argument to be processed
#	      resets back to 1 each time the shell/
#	      shell script is invoked
# --------------------------------------------------------
# OPTERR -> This variable has an initial default value
#		of 1 which enables the printing of 
#		all error messages. set its value to 0
#		to suppress the getopts STDERR(fd 2)
# --------------------------------------------------------
# $name -> Stores an upcomming option from OPTSTRING
#	    + The next argument to be processed into
#	     the shell variable 'OPTINT'
# - example -
#  If the current instance of getopts is 
#  currently processing option 'a', the option
#  stored at name would be 'b'
#
#	- Curr -> 'a'
#	- Next -> 'b'	
# --------------------------------------------------------
# OPTSTRING -> Group of recognizable options
#		option preceeding a colon expect
#		an argument, seperated by white-
#		space
# --------------------------------------------------------
#
# Enable verbosity + xtraceback for debug info
# set -xv 

# Initialize getops in 'TEMP' then eval (eval nukes all user input)
TEMP=$(getopt -o 'abc:d:e' --long 'a-long,b-long,c-long:' -n '__getopt_example' -- "$@")

# Exit if the exit status is not equal to 0
if [ $? -ne 0 ]; then
	echo 'Terminating...' >&2
  	exit 1
fi

# If the argument check is was succesfull, proceed with evaluation of
# the  TEMP variable
#
###  WARN: Notice the intentional quotation applied whilst evaluating the
###  WARN: TEMP variable; DO NOT EVAL WITHOUT QUOTATION
#
eval set -- "$TEMP" #  WARN: QUOTE TEMP WHEN EVALUATING
#  NOTE:
#  Afer eval the TEMP variable is no longer of use, and may be 
#  discarded. unset TEMP variable ASAP
unset TEMP

# Call the getopts function
__getopt_example() {
	#export OPTSTRING='abc:d:e'
   	#export OPTIND='' 
	#export OPTARG=''
   	#export OPTERR=''
   	#export NAME=''

# Now that all the intial setup has been completed, We begin
# processing the various options recieved however we see fit
# this is the main logic supplying the logic required 
# during the processing stages ahead
###  NOTE : Define options here, handling/interactions 

# This loop is maintained until either (1)all user input has been
# succesfully processed and is no longer of value - ensuring no 
# arguments are lost. (2)an error has occurred resulting in the 
# abrupt termination of argument processing, such as incorrect 
# user input - fault developer side logic/code and so on. }
###  NOTE : Other influencing factors and edge cases not mentioned 
#	   within the contents of this EXTREMELY small usage/use-cases 
#	   example may occur, be sure to debug and examine your own
#	   various implementations thoughout the development cycle!

while true; do

# The following case statments are responsible for
# handling the behaviour of options, this includes 
# the manner in which they act and specifications 
# made to dictate how they interact with one another
    	
	case "$1" in
	
	'-a'|'--a-long')
		# After an option has been handled it is important 
		# to perform a left bit shift using whats knowns as a
		# binary/bitwise shift operator/operations this 
		# allows the next option to be shifted into the previously
		# shifted options place 
		# <-OPT [SHIFT] <-OPT [SHIFT] <-OPT....
			
		echo "Option a" 
		shift
		continue
	;;
	'-b'|'--b-long')	echo "Option b"
		shift 1 
		continue
	;;
	'-c')	echo "Option c"
		shift 1 
		continue
	;;
	'-d')	echo "Option d"
		shift 1
		continue 
	;;
	'-e')	echo "Option e"
		shift 1
		continue
	;;
	*)	echo "DONE"
		break
	esac
	
	echo "$NAME"
	echo "${ARGV["$@"]}"
	echo "$OPTIND"
	echo "$OPTARG"
	echo "$OPTERR"
	
	return 0

   done
}
