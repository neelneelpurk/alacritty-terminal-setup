# --- 1. Completion & Module Initialization ---
# Must be at the very top to define 'compdef' for plugins and tools
autoload -Uz compinit && compinit -u
zmodload zsh/zpty

# --- 2. Plugin Management (Antidote) ---
if [[ -f /opt/homebrew/opt/antidote/share/antidote/antidote.zsh ]]; then
    source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
    antidote load
fi

# --- 3. History Autocomplete (Ghost Text) ---
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8' # Subtle grey ghost text

# Keybindings for accepting suggestions
bindkey '^f' vi-forward-word          # Ctrl+F to accept word
bindkey '^e' vi-forward-word          # Ctrl+E to accept whole line
bindkey '^[[C' end-of-line            # Right Arrow to accept word

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up Arrow
bindkey "^[[B" down-line-or-beginning-search # Down Arrow


# --- 4. Environment & Native Zsh Menu ---
export EDITOR="vi"
export LANG="en_US.UTF-8"
export PATH="/opt/homebrew/bin:/usr/local/bin:/Users/neelneelpurk/.antigravity/antigravity/bin:$PATH"

# Visual Tab Menu
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# --- 5. Tool-Specific Native Logic ---
if (( $+commands[kubectl] )); then
  source <(kubectl completion zsh)
  alias k='kubectl'
  [[ -n "$(typeset -f compdef)" ]] && compdef __start_kubectl k
fi
[[ -f /opt/homebrew/bin/aws_zsh_completer ]] && source /opt/homebrew/bin/aws_zsh_completer

# --- 6. Starship & CX Engine ---
# Initialize Starship (The "Pastel Pill" theme)
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# Load CX Engine logic for your context-switching
[[ -f ~/.zsh-local-plugins/cx-engine/cx.zsh ]] && source ~/.zsh-local-plugins/cx-engine/cx.zsh

# --- 7. Auto-start Logic (Unique Session Per Tab) ---
if [[ -z "$TMUX" && -n "$PS1" ]]; then
  if command -v tmux &> /dev/null; then
    # Start a brand new session with the default 'local-dev' context
    cx set local-dev
  fi
fi
