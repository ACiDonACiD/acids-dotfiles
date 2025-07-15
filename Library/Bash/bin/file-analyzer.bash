#!/bin/bash
# file_analyzer.sh in Documents/Bash
# Analyzes file types in a specified directory and generates a Markdown report

BOLD='\033[1m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# Function to resolve the script path
get_script_dir() {
    local SOURCE=$0
    while [ -h "$SOURCE" ]; do
        DIR=$(cd -P "$(dirname "$SOURCE")" && pwd)
        SOURCE=$(readlink "$SOURCE")
        [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE
    done
    DIR=$(cd -P "$(dirname "$SOURCE")" && pwd)
    echo "$DIR"
}

# Default directory to analyze (can be overridden with --dir)
DEFAULT_DIR="$HOME/Documents"
TARGET_DIR="${1:-$DEFAULT_DIR}"

# Ensure target directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Directory '$TARGET_DIR' does not exist."
    exit 1
fi

# Set up report file
REPORT_DIR="$HOME/Documents/Logs"
REPORT_FILE="$REPORT_DIR/file_types_$(date +%Y%m%d).md"
mkdir -p "$REPORT_DIR" || { echo "Error: Cannot create $REPORT_DIR"; exit 1; }

# Generate Markdown report
{
    echo -e "${BOLD}# 📈 File Type Analysis - $(date +%Y-%m-%d)${NC}"
    echo -e "${YELLOW}## Directory: $TARGET_DIR${NC}"
    echo
    echo -e "${CYAN}| Extension | Count |${NC}"
    echo -e "${CYAN}|-----------|-------|${NC}"
        find "$TARGET_DIR" -type f -name "*.*" | grep -E '\.[a-zA-Z0-9]+$' | awk -F. '{print $NF}' | sort | uniq -c | sort -nr | while read -r count ext; do
    echo -e "| .$ext | $count |"
    done

} > "$REPORT_FILE"

# Check if report is empty
if ! grep -q "| ." "$REPORT_FILE"; then
    echo "| None | 0 |" >> "$REPORT_FILE"
    echo "No files with extensions found in $TARGET_DIR."
else
    if command -v glow &> /dev/null; then
        # If the glow program is available
        # open in glow preferably
        glow "$REPORT_FILE"
    else
        # The cat program will serve as a fallback
        # for whenever glow is missing
            echo "Report generated: $REPORT_FILE"
            echo "Tip: Install 'glow' for a better viewing experience."
        cat "$REPORT_FILE"
    fi
fi

if [[ "$2" == "--chart" ]]; then
    find "$TARGET_DIR" -type f -name "*.*" | grep -E '\.[a-zA-Z0-9]+$' | awk -F. '{print $NF}' | sort | uniq -c | awk '{print $2 " " $1}' | spark
fi
