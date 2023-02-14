{ config, pkgs, xdg, ... }:
{
  imports = [ 
    ./vim 
    ./nvim 
    ./zsh
    ./tmux
    ./fish
    ];
  home.username = "ares";
  home.packages = with pkgs; [
    bash
    # macvim
    # pkgs is the set of all packages in the default home.nix implementation
    llvm cmake flex bison 
    direnv
    # gcc
    # ghc
    # stack
    # cabal-install
    # haskellPackages.implicit-hie
    # haskellPackages.haskell-language-server
    # haskellPackages.Agda
    nodejs 
    swiProlog 
    jdk 
    clojure
    # database
    sqlite
    cachix
    act
    # tools
    diffutils shellcheck pandoc fasd ripgrep thefuck gtop nixpkgs-fmt
    coreutils
    inetutils
    qemu
    docker
    # irssi
    
    # btop
    # libsecret
  ];
  # programs.tmux.enable = true;
  # home.stateVersion = "22.05";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "soulomoon";
    userEmail = "fwy996602672@gmail.com";
    extraConfig = {
      credential.helper = "store --file ~/.git-credentials";
    };
  };

  # programs.go.enable = true;

  programs.dircolors = {
    enable = true;
    extraConfig = builtins.readFile ./dir_colors;
  };
  programs.fzf.enable = true;

}
