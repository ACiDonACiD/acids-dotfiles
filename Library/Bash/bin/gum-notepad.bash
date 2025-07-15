#!/bin/bash

# Config
NOTES_DIR="${HOME}/.notes"

mkdir -p "$NOTES_DIR"

# Style helper
title() {
  gum style --foreground 212 --bold --align center "$1"
}

menu() {
  gum style --border double --padding "1 4" --foreground 39 "$1"
}

# Main loop
while true; do
  clear
  title "📝 CLI NOTE TAKER"
  ACTION=$(gum choose --height 5 "➕ Add Note" "📂 View Notes" "🗑 Delete Note" "⚙️  Change Save Location" "🚪 Exit")

  case "$ACTION" in
    "➕ Add Note")
      CATEGORY=$(gum input --placeholder "Enter category (e.g., work, ideas, personal)")
      [[ -z "$CATEGORY" ]] && continue
      mkdir -p "$NOTES_DIR/$CATEGORY"

      TITLE=$(gum input --placeholder "Enter note title")
      [[ -z "$TITLE" ]] && continue

      CONTENT=$(gum write --placeholder "Write your note here...")
      echo "$CONTENT" > "$NOTES_DIR/$CATEGORY/$TITLE.md"

      gum confirm "✅ Saved '$TITLE' in '$CATEGORY'. Add another?" && continue
      ;;

    "📂 View Notes")
      CATEGORY=$(ls "$NOTES_DIR" | gum choose --header "Select category to view")
      [[ -z "$CATEGORY" ]] && continue

      FILE=$(ls "$NOTES_DIR/$CATEGORY" | gum filter --placeholder "Search notes..." --header "Select note to view")
      [[ -z "$FILE" ]] && continue

      gum pager < "$NOTES_DIR/$CATEGORY/$FILE"
      ;;

    "🗑 Delete Note")
      CATEGORY=$(ls "$NOTES_DIR" | gum choose --header "Select category to delete from")
      [[ -z "$CATEGORY" ]] && continue

      FILE=$(ls "$NOTES_DIR/$CATEGORY" | gum choose --header "Select note to delete")
      [[ -z "$FILE" ]] && continue

      gum confirm "⚠️ Delete '$FILE' from '$CATEGORY'?" && rm "$NOTES_DIR/$CATEGORY/$FILE"
      ;;

    "⚙️  Change Save Location")
      NEW_PATH=$(gum input --placeholder "Enter new path for notes directory")
      [[ -z "$NEW_PATH" ]] && continue
      NOTES_DIR="$NEW_PATH"
      mkdir -p "$NOTES_DIR"
      gum style --foreground 120 "✅ Notes directory changed to $NOTES_DIR"
      sleep 1.5
      ;;

    "🚪 Exit")
      clear
      title "👋 Goodbye!"
      exit 0
      ;;
  esac
done
