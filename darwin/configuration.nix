{ config, pkgs, ... }:
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ 
      # pkgs.vim
      # pkgs.yarn
      # pkgs.home-manager
      # pkgs.macvim
    ];
  
  # environment.profiles =
  # [ "$HOME/.nix-profile" ]
  users.users.ares = {
     name = "ares";
     home =  "/Users/ares";
   };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;
  # Create /etc/bashrc that loads the nix-darwin environment.
  # programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
  nix.binaryCaches = [ "https://cache.nixos.org/" "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];


  # fileSystems."Users/ares/mnt/share" = {
  #     device = "smb://192.168.31.1";
  #     fsType = "cifs";
  #     options = let
  #       # this line prevents hanging on network split
  #       automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
  #     in ["${automount_opts}"];
  # };
}
