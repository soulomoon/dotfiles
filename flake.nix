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
    # flake-utils.lib.eachDefaultSystem (system:
    # {
    #   legacyPackages = import nixpkgs {
    #     inherit system;
    #     config.allowUnfree = true;
    #   };

    #   legacyPackages.aarch64-darwin.homeConfigurations."ares@aress-MacBook-Pro.local".activationPackage #   = home-manager.lib.homeManagerConfiguration {
    #       system = "aarch64-darwin";
    #       homeDirectory = "Users.ares";
    #       username = "ares";
    #       configuration = ./home/home.nix;
    #     };
    #   packages.home-manager = home-manager.defaultPackage.${system};
    # })
    # //  
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
            { nixpkgs.pkgs = self.legacyPackages."aarch64-darwin"; }
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

        defaultpackage.aarch64-darwin = self.homeconfigurations.mac.activationpackage;
        defaultpackage.x86_64-linux = self.homeconfigurations.nixos.activationpackage;
      }
    ;
}
