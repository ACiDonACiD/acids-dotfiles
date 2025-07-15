#!/usr/bin/env bash

echo "SOURCE : ${BASH_SOURCE[0]}"

clean() {
	unset SCRIPT_DIR SCRIPT_PATH
}

clean
SCRIPT_DIR=$(dirname "$0")
printf "\n === Relative Path ===
\t -> %s \n" $SCRIPT_DIR

clean
SCRIPT_PATH=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")
printf "\n === Absolute Path ===
\t -> %s \n" $SCRIPT_DIR

clean
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
printf "\n === Absolute script directory ===
\t -> %s \n" $SCRIPT_DIR

clean
echo "USING 'BASH_SOURCE VARIABLE"
echo "${BASH_SOURCE}"

clean
echo "SOURCE PARENT DIRECTORY"
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";
echo $SCRIPT_DIR

echo "==="

# Function to resolve the script path
get_script_dir() {
    local SOURCE=$0
    while [ -h "$SOURCE" ]; do # Resolve $SOURCE until the file is no longer a symlink
        DIR=$(cd -P "$(dirname "$SOURCE")" && pwd)
        SOURCE=$(readlink "$SOURCE")
        [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # If $SOURCE was a relative symlink, resolve it relative to the symlink base directory
    done
    DIR=$(cd -P "$(dirname "$SOURCE")" && pwd)
    echo "$DIR"
}

# Get the directory
SCRIPT_DIR=$(get_script_dir)

echo "The script is located in: $SCRIPT_DIR"
