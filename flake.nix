{
  description = "soulomoon's systems";

  inputs = {
    nixvim.url = "github:soulomoon/nixvim/536dd597855d54aec234bb7b4591c8d77c68268b";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # unstable.url = "github:nixos/nixpkgs/b305dc2006b6882311e2996338e8df70d9cde690";
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


  outputs = { self, nixpkgs, home-manager, darwin, unstable, vscode-server, neovim-nightly-overlay, nixvim, ... }@inputs:
    let
      overlays = [
        neovim-nightly-overlay.overlays.default
      ];
    in
    {
        # programs.neovim = {
        #   enable = true;
        #   package = self.neovim-nightly-overlay.packages.${nixpkgs.system}.default;
        # };
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
            let
              system = "aarch64-darwin";
              pkgs-unstable = import unstable {  inherit system; };
              pkgs = import nixpkgs { inherit system ; };
            in
            home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = { inherit inputs ;};
                modules = [
                    ./home/home.nix
                    { nixpkgs.overlays = overlays; }
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
