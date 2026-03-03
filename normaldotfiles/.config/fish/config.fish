# Converted from nixdotfiles/home/shell/default.nix
fish_vi_key_bindings
fish_add_path $HOME/.ghcup/bin
fish_add_path $HOME/bin
fish_add_path $HOME/.cargo/bin
fish_add_path /usr/local/bin

set -gx DOTFILES_DIR "$HOME/.config/normaldotfiles"

if type -q starship
    starship init fish | source
end

alias mc 'code "$DOTFILES_DIR"'
alias ll 'ls -l'
alias t 'tmux attach -t default || tmux new -s default'
