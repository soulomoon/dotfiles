{ pkgs, ... }:
let
  doom-emacs = pkgs.callPackage (builtins.fetchTarball {
    sha256 = "1g0izscjh5nv4n0n1m58jc6z27i9pkbxs17mnb05a83ffdbmmva6";
    url = https://github.com/vlaci/nix-doom-emacs/archive/master.tar.gz;
  }) {
    doomPrivateDir = ./doom.d;  # Directory containing your config.el init.el
                                # and packages.el files
    # Use the latest emacs-overlay
    dependencyOverrides = {
      "emacs-overlay" = (builtins.fetchTarball {
          sha256 = "1g0izscjh5nv4n0n1m58jc6z27i9pkbxs17mnb05a83ffdbmmva6";
          url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
      });
    };
    # Look at Issue #394 
    emacsPackagesOverlay = self: super: {
      gitignore-mode = pkgs.emacsPackages.git-modes;
      gitconfig-mode = pkgs.emacsPackages.git-modes;
    };
  };
in {
  home.packages = [ doom-emacs ];
  home.file.".emacs.d/init.el".text = ''
      (load "default.el")
  '';
}