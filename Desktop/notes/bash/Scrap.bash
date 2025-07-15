#!/usr/bin/env bash

#  NOTE:	ARGV		->	store args
#		ARGC		->	length of args
#		ARGP		->	Null pointer
#		ARG		->	Signle arg
#		KEY		->	Key(int)
#		ARGP_KEY_ARG	->	non-option
#			--- ARGP_KEY_ARG A Command line argument; 
#			--- whose value is pointed to by ARG

declare	-xi PID=$$	# Process ID
declare -xi RET=$?	# Return

(
	# Process ID + Previous Return
		
		[[ -v $PID ]] && unset PID ; PID=$$
		[[ -v $RET ]] && unset RET ; RET=$?	
	
)

ARGV=(
	# Argument parser key variables
	
		ARGP_KEY_SUCCESS	0
		ARGP_KEY_ERROR		1
		ARGP_KEY_UNKNOWN	2
		ARGP_KEY_ARG		3	# Processed arguments
)
	for key in "${ARGV[@]}"; do
		echo "Testing Signal( ${ARGV[$key]} )"
	done

# argp_failure () { return 0 }

# Connstruct assoc array(KV)
KV_SIGNAL[$KEY]="${VALUE[@]}"


	
SETVAR() {
	
#	NAME	- 	
#	SYNOPSIS	: setvar [options] [--] 
#	DESCRIPTION	: 
#	OPTIONS		: setvar [options]

#	-n nameref[='name_ref'] -- [='setval']	
#		setvar [-r][name_ref] [--] [0]
#		setvar [--nameref][name_ref] [--] [0]

#	-N namevar[='name_var'] -- [='setval']
#		setvar -v 'name_var' -- 0
#		setvar --namevar 'name_var' -- 0

	local -a arr=("$@")		# arguments
	for idx in "$@"; do
		local -a _parameter=()
		local _argument="${_parameter[@]}"
	done
		
	_k=""
	_v=('VAL1' 'VAL2' 'VAL3')
	echo _parameter
	echo _argument

}
#  TEST:
# echo "KEY($_k)"
# echo "VAL($_v)"
# echo ${KV_SIGNAL["${_k[@]}"]}
#
add_kv () { # KV_SIGNAL[GROUP_1]
	local param1="$1" 	# parameter(1) | 
	local param2="$2" 	# parameter(2)
	
	local _key="$param1"		# 
	local -n _value="$param2"

	local -n SIGVAL=(	
			'SIGINT'
			'EXIT'
	); 	KV_SIGNAL[$SIGKEY]="${SIGVAL[@]}"

	# KV_SIGNAL[GROUP_2]
	# SIGKEY="GROUP_KEY_2"
	# SIGVAL=(	
	# 		'EXIT'
	# ); 	KV_SIGNAL[$SIGKEY]="${SIGVAL[@]}"
}

#del_kv () { }
#set_kv () { }

# Grouped functions
group_1 () { 
	echo "signal detected, running group_1"
}

group_2 () { 
	printf "Awaiting Exit...\n"
	sleep 2s

}

# Trapped signals
trap 'group_1' ${KV_SIGNAL[GROUP_KEY_1]}
trap 'group_2' ${KV_SIGNAL[GROUP_KEY_2]}

# Assert Signals
assert_signal () {
	local PARAM="$1"
	local -n SIGBUF="${PARAM}"
	
	echo $PARAM

	for key in "${SIGBUF[@]}"; do
		printf "ARRAY[%d] : %s", ${key}, ${SIGBUF[$key]}
		echo "Testing Signal( ${SIGBUF[$key]} )"
		kill -s SIGINT $PID
	done
}

type NetworkManage &>/dev/null
case "${RET}" in
	0) printf "NetworkManager Found\n"		;;
	1) printf "NetworkManager Not Found\n" 		;;
	*) printf "Unexpected Error : %s"; 		ARGP_KEY_UNKNOWN ;;
esac

# wlp1s0 - interWainet connection status; Requires NetworkManager
wlp1s0 () {
	printf "Running...\n"
	printf "Waiting...\n"
	
	command=nmcli
	regexp=^wlp1s0:
	parse=$( $command | grep $regexp )
	return 0
}

wlp1s0 | caller

exit $?
