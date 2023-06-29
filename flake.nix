{
  description = "soulomoon's systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/cfa78cb43389635df0a9086cb31b74d3c3693935";
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

        darwinConfigurations.aress-mbp = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = 
          [ 
            ./darwin/configuration.nix 
          ];
        };

        homeConfigurations = {
          mac = with import nixpkgs { system = "aarch64-darwin"; }; 
            home-manager.lib.homeManagerConfiguration {
                system = "aarch64-darwin";
                homeDirectory = /Users/ares;
                username = "ares";
                pkgs = pkgs;
                configuration = { config, pkgs, ... }:
                  {
                    nixpkgs.overlays = [ ];
                    nixpkgs.config = {
                      allowUnfree = true;
                    };
                    imports = [ ./home/home.nix ];
                  };
              };
          nixos = with import nixpkgs { system = "x86_64-linux"; };
          home-manager.lib.homeManagerConfiguration {
              system = "x86_64-linux";
              homeDirectory = /home/ares;
              username = "ares";
              configuration = ./home/home.nix;
              pkgs = pkgs;
            };
          # multipass = home-manager.lib.homeManagerConfiguration {
          #     system = "aarch64-linux";
          #     homeDirectory = /home/ubuntu;
          #     username = "ubuntu";
          #     configuration = ./home/home.nix;
          #     pkgs = pkgs;
          #   };
        };

        defaultPackage.aarch64-darwin = self.homeConfigurations.mac.activationPackage;
        defaultPackage.x86_64-linux = self.homeConfigurations.nixos.activationPackage;
      }
    ;
}
