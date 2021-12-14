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


  outputs = { self, nixpkgs, home-manager, darwin}: 
  let 
    home =  "/Users/ares";
    homeConfig = 
            { config, pkgs, ... }: 
            let 
              vimFile = builtins.readFile ./vim/plug-config.vim
                + builtins.readFile ./vim/key-map.vim
                + builtins.readFile ./vim/init-setting.vim;
            in
            (import ./home/home.nix {inherit config pkgs vimFile; });
  in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = 
        [ 
          ./nixos/configuration.nix 
          home-manager.nixosModules.home-manager {
            home-manager.users.ares = homeConfig;
          }
        ];
      };

      darwinConfigurations.aress-MacBook-Pro = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = 
        [ 
          ./darwin/configuration.nix 
          home-manager.darwinModule {
            home-manager.users.ares = homeConfig;
          }
        ];
      };
      defaultPackage.aarch64-darwin = (darwin.lib.darwinSystem { system = "aarch64-darwin"; modules = []; }).system;
  };
}
