{ config, pkgs, xdg, ... }:
{
  
  home.username = "ares";
  xdg.configFile."../.vim".source = ./vim;
  # xdg.configFile."vim".source = ./vim;
  programs.vim = {
    # customize vim to use vim-plug
    packageConfigurable = pkgs.vim_configurable // {
      customize = (args: pkgs.vim_configurable.customize (pkgs.lib.recursiveUpdate args {
      vimrcConfig.plug.plugins = args.vimrcConfig.packages.home-manager.start;
      vimrcConfig.packages.home-manage.start = [ ];
      }));
    };
    extraConfig = "
      runtime init-setting.vim
      runtime key-map.vim
      runtime plug-config.vim
    ";
    
    # extraConfig = 
    #   builtins.readFile ./vim/plug-config.vim
    #   + builtins.readFile ./vim/key-map.vim
    #   + builtins.readFile ./vim/init-setting.vim;

    enable = true;
    plugins = with pkgs.vimPlugins; [
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
  };


  #  imports = [ ./myVim.nix ];
  #   programs.myVim.enable = true;

  home.packages = with pkgs; [
    # pkgs is the set of all packages in the default home.nix implementation

    llvm
    cmake
    flex
    bison
    gcc

    # ghc
    # ghc
    # stack
    # cabal-install
    # haskellPackages.implicit-hie
    # haskell-language-server

    nodejs
    swiProlog
    jdk

    # database
    sqlite

    # tools
    diffutils
    shellcheck
    pandoc
    fasd
    ripgrep
    youtube-dl
    thefuck
    gtop

    nixpkgs-fmt
  ];
  # programs.tmux.enable = true;
  # home.stateVersion = "22.05";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.fzf.enable = true;
  programs.git = {
    enable = true;
    userName = "soulomoon";
    userEmail = "fwy996602672@gmail.com";
  };
  programs.zsh = {
    enable = true;
    initExtra = '' 
      export TERM="xterm-256color"
      source ~/.p10k.zsh 
      CASE_SENSITIVE="false"
    '';
    shellAliases = {
      ll = "ls -l";
      # updateHome = "home-manager switch";
      # updateNixos = "sudo nixos-rebuild switch";
      updateNixos= "sudo nixos-rebuild switch --flake ~/.config/nixpkgs";
      updateDarwin= "darwin-rebuild switch --flake ~/.config/nixpkgs";
      updateHomeMac = "home-manager switch --flake ~/.config/nixpkgs/#mac -v";
      updateHomeNixos = "home-manager switch --flake ~/.config/nixpkgs/#nixos -v";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "brew" "fasd"];
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "zsh-users/zsh-completions"; }
        { name = "chisui/zsh-nix-shell"; }
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
      ];
    };
  };
  # vim
}
