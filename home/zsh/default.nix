{ config, pkgs, xdg, ... }:

let ConfigFile = "~/.config/nixpkgs";
in {
  programs.zsh = {
    enable = true;
    initExtra = '' 
      export TERM="xterm-256color"
      export ConfigFile="${ConfigFile}"
      export C_INCLUDE_PATH="`xcrun --show-sdk-path`/usr/include/ffi"
      source ~/.p10k.zsh 
      CASE_SENSITIVE="false"
      eval $(thefuck --alias)
      [[ ! -r ~/.opam/opam-init/init.zsh ]] || source ~/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
    '';
    shellAliases = {
      mc = "code ${ConfigFile}";
      ll = "ls -l";
      # replace home
      updatehome = "nix run ${ConfigFile}";
      uh = "nix run ${ConfigFile}";
      # updateNixos = "sudo nixos-rebuild switch";
      updateNixos= "sudo nixos-rebuild switch --flake ${ConfigFile}";
      updateDarwin= "darwin-rebuild switch --flake ${ConfigFile}";
      updateHomeMac = "home-manager switch --flake ${ConfigFile}/#mac -v";
      updateHomeNixos = "home-manager switch --flake ${ConfigFile}/#nixos -v";
      t = "tmux attach -t default || tmux new -s default";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "brew" "fasd"];
      extraConfig = ''
        export PATH=~/.emacs.d/bin:$PATH
        export PATH=~/bin:$PATH
        export PATH=~/.cargo/bin:$PATH
      '';
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "zsh-users/zsh-completions"; }
        { name = "chisui/zsh-nix-shell"; }
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
      ];
    };

  };
}
