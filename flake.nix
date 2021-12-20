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

    # flake-utils.url = "github:numtide/flake-utils";
  };


  outputs = { self, nixpkgs, home-manager, darwin }: 
    {
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
          mac = home-manager.lib.homeManagerConfiguration {
              system = "aarch64-darwin";
              homeDirectory = /Users/ares;
              username = "ares";
              configuration = ./home/home.nix;
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
