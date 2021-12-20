{ config, pkgs, lib, ... }: {
  programs.vim = {
    # customize vim to use vim-plug
    packageConfigurable = pkgs.vim_configurable // {
      customize = (args: pkgs.vim_configurable.customize (pkgs.lib.recursiveUpdate args {
      vimrcConfig.plug.plugins = args.vimrcConfig.packages.home-manager.start;
      vimrcConfig.packages.home-manage.start = [ ];
      }));
    };
    extraConfig = 
      builtins.readFile ./init-setting.vim +
      builtins.readFile ./key-map.vim +
      builtins.readFile ./plug-config.vim
    ;
    plugins = with pkgs.vimPlugins; [
      nord-vim

      tmuxline-vim
      vim-tmux-navigator
      vim-tmux
      onedark-vim
      vim-commentary
      vim-which-key
      unicode-vim
      vim-easy-align
      supertab
      fzfWrapper
      fzf-vim
      vim-multiple-cursors
      vim-abolish
      auto-pairs
      vim-sensible
      ale
      nerdtree
      vim-gitgutter
      nerdtree-git-plugin
      vim-airline
      vim-airline-themes
      vim-devicons
      haskell-vim
      vim-nix
    ];
    enable = true;
  };
}