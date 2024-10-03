{
  description = "soulomoon's systems";

  inputs = {
    nixvim = {
      url = "github:soulomoon/nixvim-1/5a9a7f36e03e39206695dc4eb3ef705f9983af41";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    unstable.url = "github:nixos/nixpkgs-channels/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # flake utils
    flake-utils.url = "github:numtide/flake-utils";
  };


  outputs = { self, nixpkgs, home-manager, darwin, unstable, vscode-server, neovim-nightly-overlay, nixvim, flake-utils, ... }@inputs:
    let
      overlays = [
        neovim-nightly-overlay.overlays.default
      ];
    in
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
    } //
    (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.homeConfigurations."ares" = (home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home/home.nix
            { _module.args = { inherit system; }; }
            { nixpkgs.overlays = overlays; }
            {
              home = {
                username = "ares";
                # set home directory based on system mac or linux
                homeDirectory = if system == "aarch64-darwin" then "/Users/ares" else "/home/ares";
                packages = [
                  nixvim.packages.${system}.default
                ];
              };
            }
          ];
        });
      }));
}
