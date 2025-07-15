#!/usr/bin/env bash

main() {
  # Exit constant
  local -i EXIT_SUCCESS=0
  local -i EXIT_FAILURE=1
  
  # Key : Value pair array
  local -A KV_ARRAY=()

  # Add KEY_1 : VALUE to KV_ARRAY
  local KV_ARRAY[KEY_1]="VALUE_1"
  local KV_ARRAY[KEY_2]="VALUE_2"

  # Loop to print Key : Value pairs
  for KEY in "${!KV_ARRAY[@]}"; do
    printf "[%s] : %s\n" "${KEY}" "${KV_ARRAY[$KEY]}"
  done

  return $EXIT_SUCCESS
}

main
