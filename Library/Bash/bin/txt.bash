#!/bin/bash

set +xv

export KEY="KEY"
export VALUE="VALUE"
export CMD="ARGS[1]"
ARGS=("$@")

/usr/bin/env bash -c ""
  echo "$KEY"
  echo "$VALUE"
  echo "$CMD"
  echo "${ARGS[@]}"
' -- "${ARGS[@]}"
