{
  description = "soulomoon's systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    # nixpkgs.url = "github:nixos/nixpkgs-channels/nixos-unstable";
    unstable.url = "github:nixos/nixpkgs-channels/nixos-unstable";

    
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };


  outputs = { self, nixpkgs, home-manager, darwin, unstable, ... }: 
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

        nixpkgs.config = {
          allowUnfree = true;
        };

        homeConfigurations = {
          mac = 
            with import nixpkgs { system = "aarch64-darwin"; }; 
            let pkgs-unstable = import unstable {  inherit system; };
            in
            home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [
                    ./home/home.nix
                    {
                      home = {
                        username = "ares";
                        homeDirectory = "/Users/ares";
                        # stateVersion = "22.05";
                      };
                    }
                ];
                # extraSpecialArgs = {
                #     inherit pkgs-unstable;
                # };
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
