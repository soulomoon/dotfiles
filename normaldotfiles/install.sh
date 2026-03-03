#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_DIR="$HOME/.dotfiles-backup/$TIMESTAMP"

DRY_RUN=0
NO_BACKUP=0

usage() {
  cat <<'EOF'
Usage: ./install.sh [--dry-run] [--no-backup] [--help]

Sync normaldotfiles into $HOME by creating symlinks.

Options:
  --dry-run    Show planned actions without changing files
  --no-backup  Replace existing files without moving them to backup
  --help       Show this help
EOF
}

log() {
  printf '%s\n' "$*"
}

run_cmd() {
  if [[ "$DRY_RUN" -eq 1 ]]; then
    log "[dry-run] $*"
  else
    "$@"
  fi
}

backup_existing() {
  local dest="$1"
  if [[ "$NO_BACKUP" -eq 1 ]]; then
    run_cmd rm -rf "$dest"
    return
  fi

  local rel
  rel="${dest#"$HOME"/}"
  if [[ "$rel" == "$dest" ]]; then
    rel="${dest#/}"
  fi

  local backup_target="$BACKUP_DIR/$rel"
  run_cmd mkdir -p "$(dirname "$backup_target")"
  run_cmd mv "$dest" "$backup_target"
  log "Backed up: $dest -> $backup_target"
}

link_file() {
  local src_rel="$1"
  local dest="$2"
  local src="$DOTFILES_DIR/$src_rel"

  if [[ ! -e "$src" ]]; then
    log "Missing source file: $src"
    exit 1
  fi

  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    log "Already linked: $dest"
    return
  fi

  if [[ -e "$dest" || -L "$dest" ]]; then
    backup_existing "$dest"
  fi

  run_cmd mkdir -p "$(dirname "$dest")"
  run_cmd ln -sfn "$src" "$dest"
  log "Linked: $dest -> $src"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    --no-backup)
      NO_BACKUP=1
      shift
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      log "Unknown option: $1"
      usage
      exit 1
      ;;
  esac
done

if [[ "$NO_BACKUP" -eq 0 ]]; then
  log "Backup directory: $BACKUP_DIR"
fi

FILES=(
  ".zshrc:$HOME/.zshrc"
  ".gitconfig:$HOME/.gitconfig"
  ".vimrc:$HOME/.vimrc"
  ".tmux.conf:$HOME/.tmux.conf"
  ".dircolors:$HOME/.dircolors"
  ".config/nvim/init.vim:$HOME/.config/nvim/init.vim"
  ".config/nvim/config.vim:$HOME/.config/nvim/config.vim"
  ".config/nvim/config.lua:$HOME/.config/nvim/config.lua"
  ".config/nvim/ui.lua:$HOME/.config/nvim/ui.lua"
  ".config/tmux/tmux.conf:$HOME/.config/tmux/tmux.conf"
  ".config/fish/config.fish:$HOME/.config/fish/config.fish"
  ".doom.d/init.el:$HOME/.doom.d/init.el"
  ".doom.d/config.el:$HOME/.doom.d/config.el"
  ".doom.d/custom.el:$HOME/.doom.d/custom.el"
  ".doom.d/packages.el:$HOME/.doom.d/packages.el"
)

for entry in "${FILES[@]}"; do
  src="${entry%%:*}"
  dest="${entry#*:}"
  link_file "$src" "$dest"
done

log "Dotfiles sync completed."
