{ config, pkgs, xdg, ... }:
let tmuxPlugins = import ./tmux-plugins;
in
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    historyLimit = 10000;

    plugins = with tmuxPlugins; [
        net-speed
        prefix-highlight
        { 
          plugin = power-theme;
          extraConfig = ''
            set -g @tmux_power_theme 'default'
            # set -g @tmux_power_theme 'gold'
            set -g @tmux_power_prefix_highlight_pos 'LR'
            # set -g @tmux_power_show_upload_speed true
            # set -g @tmux_power_show_download_speed true
          '';
        }
      sensible
      yank
      pain-control
    #   { 
    #     plugin = resurrect;
    #     extraConfig = ''
    #       set -g @resurrect-strategy-vim 'session'
    #       set -g @resurrect-capture-pane-contents 'on'
    #     '';
    #   }
    #   {
    #     plugin = continuum;
    #     extraConfig = ''
    #       set -g @continuum-restore 'on'
    #       set -g @continuum-save-interval '15'
    #       set -g @continuum-boot 'on'
    #       set -g @continuum-boot-options 'iterm'
    #     '';
    #   }
      vim-tmux-navigator
    ];
    extraConfig = 
        builtins.readFile ./.tmux.conf;
  };
}
