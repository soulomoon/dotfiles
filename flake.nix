{
  description = "soulomoon's systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };


  outputs = { self, nixpkgs, home-manager, darwin }: 
    {
        nixosConfigurations.nixosDesk = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = 
          [ 
            ./nixosDesk/configuration.nix 
          ];
        };
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = 
          [ 
            ./nixos/configuration.nix 
          ];
        };

        darwinConfigurations.aress-MacBook-Pro = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = 
          [ 
            ./darwin/configuration.nix 
          ];
        };

        homeConfigurations = {
          

          mac = with import nixpkgs { system = "aarch64-darwin"; }; 
          let tmuxPlugins = import ./tmux-plugins {inherit lib pkgs fetchFromGitHub stdenv;};
          in
          home-manager.lib.homeManagerConfiguration {
              system = "aarch64-darwin";
              homeDirectory = /Users/ares;
              username = "ares";
              configuration = { config, pkgs, ... }:
                {
                  nixpkgs.overlays = [ 
                    # (final: prev: { tmuxPlugins = import ./tmux-plugins {inherit lib pkgs fetchFromGitHub stdenv;}; } ) 
                    ];
                  nixpkgs.config = {
                    allowUnfree = true;
                  };
                  imports = [ ./home/home.nix ];
                };
            };
          nixos = home-manager.lib.homeManagerConfiguration {
              system = "x86_64-linux";
              homeDirectory = /home/ares;
              username = "ares";
              configuration = ./home/home.nix;
            };
        };

        defaultPackage.aarch64-darwin = self.homeConfigurations.mac.activationPackage;
        defaultPackage.x86_64-linux = self.homeConfigurations.nixos.activationPackage;
      }
    ;
}
