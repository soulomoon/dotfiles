{ config, pkgs, xdg, pkgs-unstable, ... }:
{

  #  home.stateVersion = "23.05"; # Please read the comment before changing.
   home.stateVersion = "24.05"; # Please read the comment before changing.
  #  nixpkgs.overlays = [
  #   (self: super: {
  #     fcitx-engines = pkgs.fcitx5;
  #   })
  # ];
  home.file = {
  };
  imports = [
    ./vim
    ./nvim
    ./shell
    ./tmux
    ];
  home.username = "ares";
  home.packages = with pkgs; [
    bash
    neofetch
    gh
    # neovide
    # macvim
    # pkgs is the set of all packages in the default home.nix implementation
    llvm cmake flex bison
    # direnv
    # gcc
    # ghc
    # stack
    # cabal-install
    # haskellPackages.implicit-hie
    # haskellPackages.haskell-language-server
    # haskellPackages.Agda
    # nodejs
    # swiProlog
    # jdk
    # clojure
    # database
    sqlite
    cachix
    # helix
    # act
    # tools
    diffutils shellcheck pandoc fasd ripgrep thefuck gtop nixpkgs-fmt
    coreutils
    inetutils
    qemu
    docker
    redis
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
  programs.eza = {
    enable = true;
    enableFishIntegration = true;
  };

  # programs.vscode = {
  #   enable = true;
  #   extensions = with pkgs.vscode-extensions; [
  #     # ms-python.python
  #     # ms-vscode.cpptools
  #     # esbenp.prettier-vscode
  #     # dbaeumer.vscode-eslint
  #     # Add more extensions as needed
  #   ];
  #   settings = {
  #     # "editor.fontSize" = 14;
  #     "editor.tabSize" = 2;
  #     "files.autoSave" = "onFocusChange";
  #     # Add more settings as needed
  #   };
  # };

  # programs.go.enable = true;

  programs.dircolors = {
    enable = true;
    extraConfig = builtins.readFile ./dir_colors;
  };
  programs.fzf.enable = true;

}
