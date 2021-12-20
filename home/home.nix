{ config, pkgs, xdg, ... }:
{
  imports = [ 
    ./vim 
    ./nvim 
    ./zsh
    ];
  home.username = "ares";
  home.packages = with pkgs; [
    # pkgs is the set of all packages in the default home.nix implementation
    llvm cmake flex bison gcc
    # ghc
    # ghc
    # stack
    # cabal-install
    # haskellPackages.implicit-hie
    # haskell-language-server
    nodejs swiProlog jdk

    # database
    sqlite

    # tools
    diffutils shellcheck pandoc fasd ripgrep youtube-dl thefuck gtop nixpkgs-fmt
    coreutils
  ];
  # programs.tmux.enable = true;
  # home.stateVersion = "22.05";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "soulomoon";
    userEmail = "fwy996602672@gmail.com";
  };
  programs.dircolors = {
    enable = true;
    extraConfig = builtins.readFile ./dir_colors;
  };
  programs.fzf.enable = true;
}
