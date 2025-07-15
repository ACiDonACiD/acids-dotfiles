# mkdep.awk -- awk script used to construct makefile dependencies
# Autodoc 1.0  mkmkfile.sh
# Copyright (c) Kieran O'Neill, 2025.
# Autodoc may be freely redistributed.  See license for details.

#  WARN: 26/05/2025
#	 This remains a temporary solloution. Until a preferable
#        implementaion is designing

# this awk program will handle 2 main tasks.
# firstly a sequential scan will search for any 
# lines that start with the `#include "'; and add
# them to the record; This is true for header(.h)
# files. The second task will handle for all
# C (.c) write out a make rule to
# the corresponding .o file; 
# dependencies within nested headers are
# propagated to the .o target
#
# 	cd src ; awk -f depend.awk ../include/*.h list-of-.c files
#	$0 	= (awk)
# 	$1	= (depend.awk) 
# 	$2 	= (../include/*.h)
# 	$3	= (list-of-.c files)

BEGIN	
{ 
	FS="\""			# for `#include "X"', $2 is X
}

END	
{ 
	mkdep_out()		# finish previous file operations 
}

FNR==1 
{	
	mkdep_out()		# finish previous file
	file=FILENAME		# setup for current file
}

/^\#[ \t]*include[ \t]+\"/	# find #include
{ 
	next 
}

# Once 'file' has been fully scanned, Now it gets processed no
# operations are carried out on header(.h) files. for 
# .c files, output the 'make' rule for the corresponding .o file;
function mkdep_out() 
{ 
	next 
}

#  FIX:	26/05/2025
# 	MISSING FEATURE THAT MATCHES
# 	THEN RECORDS THE LINE '#import'
