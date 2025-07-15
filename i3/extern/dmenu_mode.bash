#!/usr/bin/env bash

# dmenu script for selecting the mode.

# An array of key-value pairs.
# The value is the name of a function.
declare -A modes=(
	["resize"]="__resize"
)

# resize mode
__resize() { i3-msg mode "resize"; }

main() 
{
	# Select a mode using dmenu
	selection=$(printf "%s\n" "${!modes[@]}" | sort | dmenu -i -p "Choose i3 mode:")

	# If user made a selection and it's valid
	if [[ -n "$selection" && -n "${modes[$selection]}" ]]; then
		"${modes[$selection]}"
		
		return 0
	fi

	return 1
}

main "$@"
