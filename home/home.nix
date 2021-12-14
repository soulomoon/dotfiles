{ config, pkgs, vimFile,... }:
{
  home.username = "ares";
  programs.vim = {
    # customize vim to use vim-plug
    packageConfigurable = pkgs.vim_configurable // {
      customize = (args: pkgs.vim_configurable.customize (pkgs.lib.recursiveUpdate args {
      vimrcConfig.plug.plugins = args.vimrcConfig.packages.home-manager.start;
      vimrcConfig.packages.home-manage.start = [ ];
      }));
    };
    
    # config in flake 
    extraConfig = vimFile;
    # extraConfig = builtins.readFile "${config.home.homeDirectory}/.vim/plug-config.vim"
    # 	+ builtins.readFile "${config.home.homeDirectory}/.vim/key-map.vim"
    # 	+ builtins.readFile "${config.home.homeDirectory}/.vim/init-setting.vim";
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
  home.stateVersion = "22.05";
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
      updateNixos = "sudo nixos-rebuild switch --impure";
      updateHome = "home-manager switch";
      updateDarwin= "darwin-rebuild switch --flake ~/.config/config";
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
