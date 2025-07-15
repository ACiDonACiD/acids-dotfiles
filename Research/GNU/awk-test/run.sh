#!/bin/sh

set +H

# USAGE: sh run.sh [INPUT_FILE (default '.data')]

COMMAND="gawk"
OPTIONS="-f"
SOURCE_FILE="main.awk"
INPUT_1=${1:-".data"}

# 1. CMD(gawk) 
# 2. OPTS(-f)
# 3. FILENAME(main)
# 4. INPUT_FILE($1)

STRING="${COMMAND} ${OPTIONS} ${SOURCE_FILE} ${INPUT_1}"

$STRING
