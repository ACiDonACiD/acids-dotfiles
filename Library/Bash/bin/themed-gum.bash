#!/bin/bash
THEME=$(gum choose "Nord" "Solarized" "Dracula")

case $THEME in
  "Nord") export GUM_FOREGROUND=81 ;;
  "Solarized") export GUM_FOREGROUND=136 ;;
  "Dracula") export GUM_FOREGROUND=213 ;;
esac

gum style --foreground "$GUM_FOREGROUND" "🔥 Styled in $THEME"
FG=$(gum choose "White" "Blue" "Green" "Pink")
STYLE=$(gum choose "Normal" "Bold" "Italic")
gum input --placeholder "Enter your message" | xargs -I {} gum style --foreground "$FG" --"$STYLE" "{}"

