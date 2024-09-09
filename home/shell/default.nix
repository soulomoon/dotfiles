{ config, pkgs, xdg, ... }:

let
  ConfigFile = "~/.config/nixpkgs";
  shellAliases = {
    mc = "code ${ConfigFile}";
    ll = "ls -l";
    # replace home
    # updatehome = "nix run ${ConfigFile}";
    uh = "nix run ${ConfigFile}";
    # updateNixos = "sudo nixos-rebuild switch";
    updateNixos = "sudo nixos-rebuild switch --flake ${ConfigFile}";
    updateDarwin = "darwin-rebuild switch --flake ${ConfigFile}";
    updateHomeMac = "home-manager switch --flake ${ConfigFile}/#mac -v";
    updateHomeNixos = "home-manager switch --flake ${ConfigFile}/#nixos -v";
    bubu = "brew update && brew outdated && brew upgrade && brew cleanup";

    t = "tmux attach -t default || tmux new -s default";
  };
in
{

  # programs.carapace = {
  #   enable = true;
  #   enableNushellIntegration = true;
  # };
  # programs.nushell = {
  #   enable = true;
  #   configFile.text = ''
  #     $env.PATH = (
  #       $env.PATH
  #       | split row (char esep)
  #       | append /usr/local/bin
  #       | append ($env.CARGO_HOME | path join bin)
  #       | append ($env.HOME | path join .local bin)
  #       | uniq # filter so the paths are unique
  #     )

  #     $env.config.completions.external = {
  #       enable: true
  #       max_results: 100
  #       completer: $completer
  #     }
  #   '';
  # };
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;

  };
  programs.fish = {
    enable = true;
    # plugins = [ "z" ];
    interactiveShellInit = ''
      fish_vi_key_bindings
      fish_add_path /Users/ares/.nix-profile/bin/
      fish_add_path /opt/homebrew/bin/
      fish_add_path ~/.ghcup/bin
      fish_add_path ~/.cabal/bin
      fish_add_path ~/bin
    '';
    inherit shellAliases;
    plugins = [
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "ddeb28a7b6a1f0ec6dae40c636e5ca4908ad160a";
          sha256 = "0c5i7sdrsp0q3vbziqzdyqn4fmp235ax4mn4zslrswvn8g3fvdyh";
        };
      }
    ];
  };


  programs.zsh = {
    enable = true;
    initExtra = ''
      export TERM="xterm-256color"
      export PATH=~/.ghcup/bin:$PATH
      export PATH=~/bin:$PATH
      export PATH="/opt/homebrew/opt/m4/bin:$PATH"
      export ConfigFile="${ConfigFile}"
      CASE_SENSITIVE="true"
      # export C_INCLUDE_PATH="`xcrun --show-sdk-path`/usr/include/ffi"
      # source ~/.p10k.zsh
      # eval $(thefuck --alias)
      # [[ ! -r ~/.opam/opam-init/init.zsh ]] || source ~/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

      # export PATH=~/.emacs.d/bin:$PATH
      # export PATH=~/.cargo/bin:$PATH
      # export PATH="/opt/homebrew/opt/sphinx-doc/bin:$PATH"
      # for ghc compilation
    '';
    inherit shellAliases;
    oh-my-zsh = {
      enable = false;
      plugins = [ "brew" "fasd" ];
      extraConfig = ''
        export PATH=~/.emacs.d/bin:$PATH
        export PATH=~/bin:$PATH
        export PATH=~/.cargo/bin:$PATH
        # export PATH=/opt/homebrew/Cellar/pcre/8.45/include/:$PATH
        export NVM_DIR="$HOME/.nvm"
        export PATH="/opt/homebrew/opt/sphinx-doc/bin:$PATH"
        export PATH="/opt/homebrew/opt/m4/bin:$PATH"
        [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
        [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
      '';
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "zsh-users/zsh-completions"; }
        { name = "chisui/zsh-nix-shell"; }
        # { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
      ];
    };

  };
}
