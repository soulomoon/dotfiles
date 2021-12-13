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

    flake-utils.url = "github:numtide/flake-utils";
  };


  outputs = { self, nixpkgs, home-manager, darwin, flake-utils }: 
    # flake-utils.lib.eachDefaultSystem (system: {
    #   legacyPackages = import nixpkgs {
    #     inherit system;
    #     config.allowUnfree = true;
    #   };
    #   packages.home-manager = home-manager.defaultPackage.${system};
    # }) //
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = 
        [ 
          ./nixos/configuration.nix 
          home-manager.nixosModules.home-manager {
            home-manager.users.ares = import ./home/home.nix;
          }
        ];
      };

      darwinConfigurations.aress-MacBook-Pro = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = 
        [ 
          ./darwin/configuration.nix 
          home-manager.darwinModule {
            home-manager.users.ares = import ./home/home.nix;
          }
        ];
      };
      defaultPackage.aarch64-darwin = (darwin.lib.darwinSystem { system = "aarch64-darwin"; modules = []; }).system;
  };
}
