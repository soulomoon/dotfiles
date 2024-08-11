{ config, pkgs, ... }:
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ ];

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
  programs.fish.enable = true;

  # nix.package = pkgs.nix;
  # Create /etc/bashrc that loads the nix-darwin environment.
  # programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;
  # services.redis.servers."ares".enable=true;
  # services.redis.servers."ares".port=6379;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
  nix.binaryCaches = [ "https://cache.nixos.org/" "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
}
