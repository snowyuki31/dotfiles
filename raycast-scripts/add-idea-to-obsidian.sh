#!/usr/bin/env bash

# Required parameteres:
# @raycast.schemaVersion 1
# @raycast.title Fast Ideas
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 💡
# @raycast.argument1 { "type": "text", "placeholder": "content", "optional": false }

USER_INPUT="$1"

# Define position (fixed value)
POSITION="思考"

# URL-encode the content and position using Python's urllib
ENCODED_CONTENT=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.stdin.read()))" <<< "- $USER_INPUT")
ENCODED_POSITION=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.stdin.read()))" <<< "$POSITION")

# Construct the Obsidian QuickAdd URI and open it in the background
URI="obsidian://quickadd?choice=Raycast-fleeting&value-raycast_position=$ENCODED_POSITION&value-raycast_format=$ENCODED_CONTENT"

open --background "$URI"
