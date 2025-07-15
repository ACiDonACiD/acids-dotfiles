#!/usr/bin/env sh

#
# keyboard layout & font
#

echo "HELLO"
# ([])(_)(<) (>)(.)([])
#
# NOTE: 
#  STDIN/OUT may be referred to via
#  the use of arbitrary keys,
#  indicating the type of operation 
#  the arrow represents a direction(I/O)
#  and the '...' represents a command
#      
#  TYPES (?) : [ STDIN | STDOUT | STDERR ]
# 	STDERR(!)
# 	STDOUT(<)
# 	STDIN(>)
#   
# ACTIONS (#) : [ FROM | INTO ]
#  FROM 
#	STDOUT(<#)
#		STDIN(>#)
#	INTO STDOUT(#<) | INTO STDIN(#>)
# FROM OUT(<#) 
# 
#		echo "Hello"<.>[awk '{ print $0 }']
#  ACTION{} | FORWARD (TYPE) INTO (OPERATION)
#  ACTION{?-*} = FROM (?) INTO (*) 
#  []		CMD (OPERATION)
#	atleast 1 operation([]) is required
#	_[1] > .[2]
#		_[1]	: FROM COMMAND[1]
#		>	: STDOUT
#		[2]	: INTO COMMAND[2]
#
#
#
#			  
# OPERATION ACTION TYPE OPERATION
# 
#

# localectl list-keymaps 
#	( >>> )
# ( <<< ) | awk END '{ print NR }')
#  STDOUT(2) > STDIN(2)
# STDIN(2) | read VAR
#
#	
# STDOUT | $( > 'ST'
#
# into ( awk ) STDIN; redirect the (awk) STDOUT
# into the STDIN for ( read )
read X <<< $(localectl list-keymaps | awk 'END { print NR }')

select OPT in $(localectl list-keymaps); do
	# $REPLY == [:digit:] -> REPLY can only contain digits
	if ${REPLY} = "/[:digit:]; then
		echo "PASS DIGIT CHECK"
	fi
done

	# if test $REPLY =~ ^[1-"$X"]+$ ]]; then
	# 	echo VALID
	# 	break
	# fi
	# echo INVALID

