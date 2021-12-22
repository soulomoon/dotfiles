{ config, pkgs, xdg, ... }:
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    historyLimit = 10000;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      # dracula
      pain-control
      { 
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15'
          set -g @continuum-boot 'on'
          set -g @continuum-boot-options 'iterm'
        '';
      }
      vim-tmux-navigator
    ];
    extraConfig = 
        builtins.readFile ./.tmux.conf
        + builtins.readFile ./.tmuxline.conf
        ;
  };
}
