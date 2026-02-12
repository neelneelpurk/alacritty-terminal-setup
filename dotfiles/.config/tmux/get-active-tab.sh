#!/bin/bash
# Generates the full tmux-formatted active tab string with dynamic color and name.
# Usage: get-active-tab.sh <pane_current_path>
# Output: tmux format string with embedded styles

PANE_PATH="${1:-$HOME}"
CX_CONFIG="$HOME/.config/cx/contexts.csv"
CURRENT_CTX_FILE="$HOME/.config/cx/.current_context"
DEFAULT_COLOR="#b4befe"

# --- Get tab name: dirname | context ---
DIR_NAME=$(basename "$PANE_PATH")

CTX_NAME="NA"
if [[ -f "$CURRENT_CTX_FILE" ]]; then
  CTX_NAME=$(cat "$CURRENT_CTX_FILE" 2>/dev/null | tr -d '[:space:]')
  [[ -z "$CTX_NAME" ]] && CTX_NAME="NA"
fi

TAB_NAME="$DIR_NAME | $CTX_NAME"

# --- Get color hex ---
COLOR_HEX="$DEFAULT_COLOR"
if [[ -f "$CX_CONFIG" ]] && [[ "$CTX_NAME" != "NA" ]]; then
  COLOR_NAME=$(awk -F',' -v t="$CTX_NAME" 'NR > 1 && $1 == t {print $3}' "$CX_CONFIG" | tr -d '[:space:]')
  case "$COLOR_NAME" in
    blue)      COLOR_HEX="#89b4fa" ;;
    red)       COLOR_HEX="#f38ba8" ;;
    green)     COLOR_HEX="#a6e3a1" ;;
    yellow)    COLOR_HEX="#f9e2af" ;;
    orange)    COLOR_HEX="#fab387" ;;
    pink)      COLOR_HEX="#f5c2e7" ;;
    purple)    COLOR_HEX="#cba6f7" ;;
    teal)      COLOR_HEX="#94e2d5" ;;
    sky)       COLOR_HEX="#89dcfe" ;;
    lavender)  COLOR_HEX="#b4befe" ;;
    mauve)     COLOR_HEX="#cba6f7" ;;
    maroon)    COLOR_HEX="#eba0ac" ;;
    flamingo)  COLOR_HEX="#f2cdcd" ;;
    rosewater) COLOR_HEX="#f5e0dc" ;;
    \#*)       COLOR_HEX="$COLOR_NAME" ;;
  esac
fi

# Output the styled tmux format
echo "#[fg=#1e1e2e,bg=${COLOR_HEX},bold] ${TAB_NAME} #[fg=${COLOR_HEX},bg=#1e1e2e]"
