#!/bin/bash
# Reads the current cx context and returns its color as a hex value.
# Used by tmux status bar for dynamic tab coloring.

CX_CONFIG="$HOME/.config/cx/contexts.csv"
CURRENT_CTX_FILE="$HOME/.config/cx/.current_context"

# Default fallback color (Catppuccin Mocha Lavender)
DEFAULT_COLOR="#b4befe"

# Read current context name
if [[ ! -f "$CURRENT_CTX_FILE" ]]; then
  echo "$DEFAULT_COLOR"
  exit 0
fi

CTX_NAME=$(cat "$CURRENT_CTX_FILE" 2>/dev/null | tr -d '[:space:]')

if [[ -z "$CTX_NAME" ]] || [[ ! -f "$CX_CONFIG" ]]; then
  echo "$DEFAULT_COLOR"
  exit 0
fi

# Look up the color column (field 3) for this context
COLOR_NAME=$(awk -F',' -v t="$CTX_NAME" 'NR > 1 && $1 == t {print $3}' "$CX_CONFIG" | tr -d '[:space:]')

if [[ -z "$COLOR_NAME" ]]; then
  echo "$DEFAULT_COLOR"
  exit 0
fi

# Map color names to Catppuccin Mocha hex values
case "$COLOR_NAME" in
  blue)      echo "#89b4fa" ;;
  red)       echo "#f38ba8" ;;
  green)     echo "#a6e3a1" ;;
  yellow)    echo "#f9e2af" ;;
  orange)    echo "#fab387" ;;
  pink)      echo "#f5c2e7" ;;
  purple)    echo "#cba6f7" ;;
  teal)      echo "#94e2d5" ;;
  sky)       echo "#89dcfe" ;;
  lavender)  echo "#b4befe" ;;
  peach)     echo "#fab387" ;;
  mauve)     echo "#cba6f7" ;;
  maroon)    echo "#eba0ac" ;;
  flamingo)  echo "#f2cdcd" ;;
  rosewater) echo "#f5e0dc" ;;
  # If it's already a hex color, pass through
  \#*)       echo "$COLOR_NAME" ;;
  *)         echo "$DEFAULT_COLOR" ;;
esac
