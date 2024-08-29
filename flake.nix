{
  description = "soulomoon's systems";

  inputs = {
    nixvim.url = "github:soulomoon/nixvim";
    nixpkgs.url = "github:nixos/nixpkgs/master";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
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


  outputs = { self, nixpkgs, home-manager, darwin, unstable, vscode-server, nixvim, ... }:
    {
        programs.neovim = {
          enable = true;
          package = self.neovim-nightly-overlay.packages.${nixpkgs.system}.default;
        };
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
            vscode-server.nixosModules.default
              ({ config, pkgs, ... }: {
                services.vscode-server.enable = true;
              })
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
                        packages = [
                          nixvim.packages."aarch64-darwin".default
                        ];

                      };
                    }
                ];
                # extraSpecialArgs = {
                #     inherit pkgs-unstable;
                # };
              };
        nixos =
          with import nixpkgs { system = "x86_64-linux"; };
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              ./home/home.nix
              {
                home = {
                  username = "ares";
                  homeDirectory = "/home/ares";
                };
              }
            ];
          };
        };

        defaultPackage.aarch64-darwin = self.homeConfigurations.mac.activationPackage;
        defaultPackage.x86_64-linux = self.homeConfigurations.nixos.activationPackage;
      }
    ;
}
