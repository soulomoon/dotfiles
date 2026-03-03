# normaldotfiles

This folder is a normal Linux-style dotfiles export converted from the Nix/Home Manager repo in `nixdotfiles/`.

## Included configs
- `.zshrc`
- `.gitconfig`
- `.vimrc`
- `.tmux.conf` and `.config/tmux/tmux.conf`
- `.config/nvim/{init.vim,config.vim,config.lua,ui.lua}`
- `.config/fish/config.fish`
- `.doom.d/{init.el,config.el,custom.el,packages.el}`
- `.dircolors`
- `scripts/hlsGenerateScheme.bash`

## Apply on Linux
Quick sync script:

```bash
cd ~/path/to/normaldotfiles
./install.sh
```

Dry run:

```bash
./install.sh --dry-run
```

Manual symlink commands (equivalent):

From this folder, symlink files into `$HOME`:

```bash
cd ~/path/to/normaldotfiles
ln -sf "$PWD/.zshrc" ~/.zshrc
ln -sf "$PWD/.gitconfig" ~/.gitconfig
ln -sf "$PWD/.vimrc" ~/.vimrc
mkdir -p ~/.config/nvim ~/.config/tmux ~/.config/fish ~/.doom.d
ln -sf "$PWD/.config/nvim/init.vim" ~/.config/nvim/init.vim
ln -sf "$PWD/.config/nvim/config.vim" ~/.config/nvim/config.vim
ln -sf "$PWD/.config/nvim/config.lua" ~/.config/nvim/config.lua
ln -sf "$PWD/.config/nvim/ui.lua" ~/.config/nvim/ui.lua
ln -sf "$PWD/.config/tmux/tmux.conf" ~/.config/tmux/tmux.conf
ln -sf "$PWD/.config/fish/config.fish" ~/.config/fish/config.fish
ln -sf "$PWD/.doom.d/init.el" ~/.doom.d/init.el
ln -sf "$PWD/.doom.d/config.el" ~/.doom.d/config.el
ln -sf "$PWD/.doom.d/custom.el" ~/.doom.d/custom.el
ln -sf "$PWD/.doom.d/packages.el" ~/.doom.d/packages.el
```

Notes:
- Nix-specific update aliases were removed/commented in shell config.
- Tmux plugins are expressed via TPM rather than Nix store paths.
