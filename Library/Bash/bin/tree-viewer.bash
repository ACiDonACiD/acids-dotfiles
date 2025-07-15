#!/bin/bash

list=$(find "$PWD" -maxdepth 1 -mindepth 1 | sort | while read -r file; do
  name=$(basename "$file")
  icon="" # default
  case "$name" in
    *.bash) icon="" ;;
    *.sh)   icon="" ;;
    *.html) icon="" ;;
    *.md)   icon="" ;;
    *.txt)  icon="" ;;
    */)     icon="" ;;
  esac
  printf "%-30s" "$icon  $name"
done | sed 's/\(.*\)\n*/\1\n/g' | fold -s -w 90)

gum style \
  --border rounded \
  --padding "1 2" \
  --margin "1" \
  --foreground 117 \
  "📁 $(basename "$PWD") 

$list"


