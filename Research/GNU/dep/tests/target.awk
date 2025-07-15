#!/usr/bin/env awk

# user-defined function; Expects 1 argument of type array, 
# from here the array is parsed(processed) and a retval -
# indicating the largest value found in vbuffer 
function add(argv, idx, ret) 
{
	# Only pass the argv argument(type array).
	# there are no restrictions preventing the 
	# user from passing an indicie/ret value 
	# However it is not recommended.
	#  WARNING: 
	# 	modifications applied DURING
	# 	runtime may result in a critical error
	# 	Use with caution!  	
	for (idx in argv) {
		# A generic sanity validation test suite
		# (avoid buffer overflows / segmentation faults)
		if (ret == "" || argv[i] > ret)
			ret = argv[i]
	}
	# Returns the updated version of argv;  
	return ret 
}

# Load and record each field value into the argument buffer
# (vbuffer); Pass the indicies at vbuffer into 'add()' function
{
	for(idx = 1; idx <= NF; idx++)
		argv[NR, idx] = $idx
}

# Finally pass the array to added function
END \
{

		#  TEST: This is a temp I/O test for debugging awk
		# (It is recommended to enable -d for verbose debugging)
		# (Execution from the bourne again shell; may use 'set +H')
		print add(argv)

}
