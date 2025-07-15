#!/bin/bash
FILE=$(gum file "*.md")
gum format < "$FILE" | gum pager

