{ config, pkgs, lib, ... }: 
let 
  vimrcConf = args: pkgs.lib.recursiveUpdate args {
    vimrcConfig.plug.plugins = args.vimrcConfig.packages.home-manager.start;
    vimrcConfig.packages.home-manage.start = [ ];
    };
  macvim = (pkgs.macvim // {
    customize = (args: pkgs.macvim.configure (vimrcConf args).vimrcConfig);
  });
  vim = pkgs.vim_configurable // {
      customize = (args: pkgs.vim_configurable.customize (vimrcConf args));};
  qline-vim = pkgs.vimUtils.buildVimPlugin {
    name = "qline.vim";
    src = pkgs.fetchFromGitHub {
      owner = "Bakudankun";
      repo = "qline.vim";
      rev = "master";
      sha256 = "0p5dv5axz4xwjcpmf5m2svv2fz8n1kxfvkj2c7yvdg984zndpbym";
    };
  };
in 
{
  programs.vim = {
    # customize vim to use vim-plug
    packageConfigurable = 
    if config.nixpkgs.system == "aarch64-darwin" then vim else vim ;
    extraConfig = 
      builtins.readFile ./init-setting.vim +
      builtins.readFile ./key-map.vim +
      builtins.readFile ./plug-config.vim
    ;
    plugins = with pkgs.vimPlugins; [
      nord-vim
      vim-racket
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
      # lightline-vim
      # qline-vim
      vim-devicons
      haskell-vim
      vim-nix
    ];
    enable = true;
  };
}