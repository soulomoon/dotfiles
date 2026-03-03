# Converted from nixdotfiles/home/shell/default.nix
export PATH="$HOME/.ghcup/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

export DOTFILES_DIR="$HOME/.config/normaldotfiles"
CASE_SENSITIVE="true"

# prompt (optional)
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# aliases preserved from Nix config where they are platform-neutral
alias mc='code "$DOTFILES_DIR"'
alias ll='ls -l'
alias t='tmux attach -t default || tmux new -s default'

# optional extras (uncomment if needed)
# alias bubu='brew update && brew outdated && brew upgrade && brew cleanup'
# alias ls='eza'
# alias la='eza -a'
# alias lla='eza -la'
# alias lt='eza --tree'
