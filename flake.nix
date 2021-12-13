{
  inputs = {

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

  outputs = { self, nixpkgs, home-manager, darwin, flake-utils }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = 
      [ 
        ./nixos/configuration.nix 
        home-manager.nixosModules.home-manager {
          # home-manager.useGlobalPkgs = true;
          # home-manager.useUserPackages = true;
          home-manager.users.ares = import ./home/home.nix;
      }
      ];
    };

    darwinConfigurations."aress-MacBook-Pro.local" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = 
      [ 
        ./darwin/configuration.nix 
        home-manager.nixosModules.home-manager {
          home-manager.users.ares = import ./home/home.nix;
      }
      ];
    };
  };
}
