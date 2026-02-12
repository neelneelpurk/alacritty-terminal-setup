#!/bin/bash

# Function to find kubectl
find_kubectl() {
  if [ -x "/usr/local/bin/kubectl" ]; then
    echo "/usr/local/bin/kubectl"
  elif [ -x "/opt/homebrew/bin/kubectl" ]; then
    echo "/opt/homebrew/bin/kubectl"
  elif [ -x "/usr/bin/kubectl" ]; then
    echo "/usr/bin/kubectl"
  else
    echo ""
  fi
}

KUBECTL=$(find_kubectl)

if [ -z "$KUBECTL" ]; then
  echo "NA"
  exit 0
fi

# Get Context
CTX=$($KUBECTL config current-context 2>/dev/null)

if [ -z "$CTX" ]; then
  echo "NA"
  exit 0
fi

# Get Version (Client) - REMOVED per user request
# ver=$(...)

echo "${CTX}"
