# eza aliases and configuration

# Color scheme configuration
export EZA_COLORS="di=1;34:ln=1;36:so=1;35:pi=33:ex=1;32:bd=34;46:cd=34;43:su=37;41:sg=30;43:tw=30;42:ow=30;43"

# Enable icons automatically
export EZA_ICONS_AUTO=1

# Standard aliases
alias l='eza --icons --group-directories-first'
alias ls='eza --icons --group-directories-first'
alias ll='eza -l --icons --group-directories-first --header'
alias la='eza -la --icons --group-directories-first --header'
alias ld='eza -lD --icons'
alias lt='eza --tree --icons --group-directories-first'
alias lg='eza -l --git --icons --group-directories-first --header'
alias lga='eza -la --git --icons --group-directories-first --header'

# Additional useful aliases
alias lm='eza -lbGF --header --git --sort=modified --icons --group-directories-first'
alias lx='eza -lbhHigUmuSa --time-style=long-iso --git --color-scale --icons --group-directories-first'
alias lz='eza -l --sort=size --reverse --icons --group-directories-first'
alias tree='eza --tree --icons --group-directories-first'

# Quick directory aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Specialized views
alias ldot='eza -ld .* --icons'  # List only dotfiles
alias ldir='eza -D --icons'      # List only directories
alias lfile='eza -f --icons'     # List only files

# Function to show eza help with common options
function eza-help() {
  echo "Common eza aliases:"
  echo "  l      - Basic list with icons"
  echo "  ls     - Same as l"
  echo "  ll     - Long format with headers"
  echo "  la     - Long format with hidden files"
  echo "  ld     - List directories only"
  echo "  lt     - Tree view"
  echo "  lg     - Long format with git status"
  echo "  lga    - Long format with git and hidden files"
  echo "  lm     - Sort by modification time"
  echo "  lx     - Extended view with all metadata"
  echo "  lz     - Sort by size (largest first)"
  echo ""
  echo "Functions:"
  echo "  eza-help  - Show this help"
}

