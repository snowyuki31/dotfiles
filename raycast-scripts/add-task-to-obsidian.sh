#!/usr/bin/env bash

# Required parameteres:
# @raycast.schemaVersion 1
# @raycast.title Fast Tasks
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🚀
# @raycast.argument1 { "type": "text", "placeholder": "content", "optional": false }
# @raycast.argument2 { "type": "dropdown", "placeholder": "context", "data": [ {"title": "self", "value": "#context/self"}, {"title": "j-cat", "value": "#context/j-cat"} ] }
# @raycast.argument3 { "type": "dropdown", "placeholder": "priority", "optional": true, "data": [ {"title": "🔺", "value": "🔺"}, {"title": "⏫", "value": "⏫"}, {"title": "🔼", "value": "🔼"}, {"title": "🔽", "value": "🔽"}, {"title": "⏬", "value": "⏬"} ] }

CURRENT_DATE=$(date +"%Y-%m-%d")

USED_DATE="$CURRENT_DATE"

# Define position (fixed value)
POSITION="tasks"

# Build the CONTENT string including the validated date and priority
CONTENT="- [ ] $1 $2 📅 $USED_DATE $3"

# URL-encode the content, position, and priority using Python's urllib
ENCODED_CONTENT=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.stdin.read()))" <<< "$CONTENT")
ENCODED_POSITION=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.stdin.read()))" <<< "$POSITION")

# Construct the Obsidian QuickAdd URI and open it in the background
URI="obsidian://quickadd?choice=Raycast-fleeting&value-raycast_position=$ENCODED_POSITION&value-raycast_format=$ENCODED_CONTENT"

open --background "$URI"
