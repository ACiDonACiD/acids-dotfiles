#!/bin/bash

# ──🎨 Color Palette──────────────────────────────────────────────────────
HEADER_COLOR=212      # Pink title
HIGHLIGHT_COLOR=45    # Cyan highlights
RUN_COLOR=34          # Green "running"
ERROR_COLOR=167       # Red error
SHADOW="1"            # Adds bold shadow effect

# ──📁 Script Finder───────────────────────────────────────────────────────
gum style --border double --margin "1" --padding "1 3" \
  --foreground "$HEADER_COLOR" --bold \
  "✨ GUM Launcher 9000"

# Scan all .bash files (excluding this one)
SCRIPTS=$(find "$PWD" -type f -name "*.bash" ! -name "$(basename "$0")" -executable)

# No scripts found?
if [ -z "$SCRIPTS" ]; then
  gum style --foreground "$ERROR_COLOR" --italic "No executable scripts found!"
  exit 1
fi

# ──🔍 Selection Menu─────────────────────────────────────────────────────
SCRIPT=$(echo "$SCRIPTS" | gum filter --indicator "" --placeholder "Pick a script to launch...")

if [ -z "$SCRIPT" ]; then
  gum style --foreground "$ERROR_COLOR" --italic "❌ Cancelled. Nothing selected."
  exit 1
fi

# ──💬 Argument Input─────────────────────────────────────────────────────
ARGS=$(gum input --cursor.foreground "$HIGHLIGHT_COLOR" \
  --placeholder "Enter any args (leave blank if none)")

# ──🧾 Summary and Confirmation───────────────────────────────────────────
gum style --margin "1 0" --padding "0 3" \
  --border normal --border-foreground "$RUN_COLOR" \
  --foreground "$HIGHLIGHT_COLOR" \
  "🎯 Running: $SCRIPT $ARGS"

head -n 5 "$SCRIPT" | grep "# Description:" | cut -d':' -f2

sleep 0.5
echo
bash "$SCRIPT" $ARGS
