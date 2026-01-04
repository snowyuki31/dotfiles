#!/usr/bin/env bash

# Required parameteres:
# @raycast.schemaVersion 1
# @raycast.title Fast Tasks
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🚀
# @raycast.argument1 { "type": "text", "placeholder": "content", "optional": false }
# @raycast.argument2 { "type": "dropdown", "placeholder": "context", "data": [ {"title": "self", "value": "#context/self"}, {"title": "j-cat", "value": "#context/j-cat"} ] }

# Build the user input from up to three positional arguments, preserving newlines
USER_INPUT="$1 $2"

# Define position (fixed value)
POSITION="tasks"

# URL-encode the content and position using Python's urllib
ENCODED_CONTENT=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.stdin.read()))" <<< "- [ ] $USER_INPUT")
ENCODED_POSITION=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.stdin.read()))" <<< "$POSITION")

# Construct the Obsidian QuickAdd URI and open it in the background
URI="obsidian://quickadd?choice=Raycast-fleeting&value-raycast_position=$ENCODED_POSITION&value-raycast_format=$ENCODED_CONTENT"

open --background "$URI"
