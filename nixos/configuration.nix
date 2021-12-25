# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  virtualisation.docker.enable = true;
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
                  experimental-features = nix-command flakes
    '';

  };
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./nixos-vscode-ssh-fix
    ];
  services.vscode-server.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.logind.lidSwitch = "lock";

  networking.networkmanager = {
    enable = true;
    wifi.macAddress = "preserve";
    ethernet.macAddress = "preserve";
  };
  networking.useDHCP = false;
  users.groups.docker = {};
  users.users.ares = {
    name = "ares";
    home =  "/home/ares";
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
  };

  environment.systemPackages = with pkgs; [
    # myVim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    # python
    gcc
    # python3
    # nodejs
    gtop
    # tldr
    git

    stack
    haskell-language-server
    ghc
    cabal-install
    haskellPackages.implicit-hie
  ];
  # Enable the OpenSSH daemon.
  services.openssh = {
	enable = true;
	passwordAuthentication = true;
	permitRootLogin = "yes";
	};

  config.oci-containers = {
    subconvertor = {
      image = "tindy2013/subconverter:latest";
      ports = ["127.0.0.1:25500:25500"];
      cmd = [
        "--restart=always"
      ];
    };
  };

  users.users."ares".openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDMHfkusbm1hdJ4GnJDWazEgMTH/drADitbZQUdKsuzMd4/027r/ghPLGe23Ar+XIhjJYzsHQ8q4n7KuMPd8WUWvYmTw1yk6A7S2XaKOUnup5yTm18vQmF/4bUZc0RdN6bc46R4Z6QA3I9lWU4VRvTExDep21rg1lRDETPuoQZyuTQ4+yi4nw5bmtDtgDbn+UBtMXoLgtk+PVOt9tpMKw3z9nCCkRwGYTLkECf78O40vpvY8IIKS539UUh1rJgCdugndB1BC0QQ20ICR72JokmdoEpSNfxSs8o+l84Jk7N2QW1sHqQt5FG6k7vIZoKKIleTuZ9qbe9FU4NTy8TeE4D07YTPCgXmflBoUaZSifke4aV1aCLLknfGLqlHqJL4u6MwwYIEB2R7QBtRwlDdpJHAKEIP/KdUfGOKr2wAJ56d4roDLpVGWdVTWxGJlMKHOnkenm8n8wucovs6jDX6YDxeNwRR0zXLuoRu4mngROhhepbNPGJ6rBCwDwsTdsSafUPODI7gpQYQbvev8lhCZrhBt/FpjTgC2rRerOR29oxch9OT1UXgX+LtvZ7dmGhYFO0s8uS8LEtYf/P+5Kz/Zj7dTK9N2vr0KfqP0vL0g4efw5tJx0KFoLs6tFPZczvTvpz7Qe1W1ORtTKuGSgb3xhNd7XOyhhZDO9FTr4cITU8lQQ== ares" # content of authorized_keys file
  ];

  users.users."root".openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDMHfkusbm1hdJ4GnJDWazEgMTH/drADitbZQUdKsuzMd4/027r/ghPLGe23Ar+XIhjJYzsHQ8q4n7KuMPd8WUWvYmTw1yk6A7S2XaKOUnup5yTm18vQmF/4bUZc0RdN6bc46R4Z6QA3I9lWU4VRvTExDep21rg1lRDETPuoQZyuTQ4+yi4nw5bmtDtgDbn+UBtMXoLgtk+PVOt9tpMKw3z9nCCkRwGYTLkECf78O40vpvY8IIKS539UUh1rJgCdugndB1BC0QQ20ICR72JokmdoEpSNfxSs8o+l84Jk7N2QW1sHqQt5FG6k7vIZoKKIleTuZ9qbe9FU4NTy8TeE4D07YTPCgXmflBoUaZSifke4aV1aCLLknfGLqlHqJL4u6MwwYIEB2R7QBtRwlDdpJHAKEIP/KdUfGOKr2wAJ56d4roDLpVGWdVTWxGJlMKHOnkenm8n8wucovs6jDX6YDxeNwRR0zXLuoRu4mngROhhepbNPGJ6rBCwDwsTdsSafUPODI7gpQYQbvev8lhCZrhBt/FpjTgC2rRerOR29oxch9OT1UXgX+LtvZ7dmGhYFO0s8uS8LEtYf/P+5Kz/Zj7dTK9N2vr0KfqP0vL0g4efw5tJx0KFoLs6tFPZczvTvpz7Qe1W1ORtTKuGSgb3xhNd7XOyhhZDO9FTr4cITU8lQQ== ares" # content of authorized_keys file
  ];

  networking.interfaces.enp0s20f0u1u1.wakeOnLan.enable= true;

  system.stateVersion = "21.05"; # Did you read the comment?
  nixpkgs.config.allowUnfree = true; 
  users.defaultUserShell = pkgs.zsh;

  nix.trustedUsers = [ "root" "ares" ];
}

