#!/bin/bash
# Generates dynamic tab name: <dirname> | <cx_context>
# Usage: get-tab-name.sh <pane_current_path>

PANE_PATH="${1:-$HOME}"
CURRENT_CTX_FILE="$HOME/.config/cx/.current_context"

# Get the basename of the current directory
DIR_NAME=$(basename "$PANE_PATH")

# Read current cx context
CTX_NAME="NA"
if [[ -f "$CURRENT_CTX_FILE" ]]; then
  CTX_NAME=$(cat "$CURRENT_CTX_FILE" 2>/dev/null | tr -d '[:space:]')
  [[ -z "$CTX_NAME" ]] && CTX_NAME="NA"
fi

echo "$DIR_NAME | $CTX_NAME"
