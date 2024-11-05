{ config, pkgs, xdg, fetchFromGitHub, lib, system, ... }:
let
  m-prefix-highlight = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "prefix-highlight";
    version = "unstable-2021-09-26";
    src = pkgs.fetchFromGitHub {
      owner = "tmux-plugins";
      repo = "tmux-prefix-highlight";
      rev = "15acc6172300bc2eb13c81718dc53da6ae69de4f";
      sha256 = "08rkflfnynxgv2s26b33l199h6xcqdfmlqbyqa1wkw7h85br3dgl";
    };
  };

  m-power-theme = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "power";
    rtpFilePath = "tmux-power.tmux";
    version = "unstable-2021-09-12";
    src = pkgs.fetchFromGitHub {
      owner = "wfxr";
      repo = "tmux-power";
      rev = "2a9a4d19df170c7744ccadeacf0c254444e058fa";
      sha256 = "17p3qf9cmcfx6lldqvn61a6m0kfzfb1aiwg6bvxiyh14nl50z1zn";
    };
  };
in
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    historyLimit = 10000;


    plugins = with pkgs.tmuxPlugins; [
      # net-speed
      {
        plugin = m-power-theme;
        extraConfig = ''
          set -g @tmux_power_theme 'moon'
          set -g @tmux_power_prefix_highlight_pos 'LR'
        '';
      }
      # need to place after power-theme to work
      {
        plugin = m-prefix-highlight;
        extraConfig = ''
          set -g @prefix_highlight_empty_has_affixes 'on' # default is 'off'
          set -g @prefix_highlight_empty_prompt 'Tmux'
          set -g @prefix_highlight_fg 'white' # default is 'colour231'
          set -g @prefix_highlight_bg 'blue'  # default is 'colour04'
        '';
      }

      # {
      # plugin = dracula;
      # extraConfig = ''
      #   set -g @dracula-show-fahrenheit false
      #   # set -g @dracula-plugins "battery git cpu-usage ram-usage network-bandwidth weather time"
      #   set -g @dracula-show-powerline true
      #   set -g @dracula-refresh-rate 10
      # '';
      # }
      sensible
      yank
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
      ''
      unbind C-b
      set -g prefix C-a
      bind a send-prefix
      set-option -g default-shell $SHELL
      set -g mode-keys vi
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
      bind-key M-q select-layout even-horizontal
      set-option -g @pane_resize "10"
      set -g mouse on
      set -g default-terminal "xterm-256color"
      set-option -ga terminal-overrides ",xterm-256color:Tc"
      set -as terminal-overrides ',*:Smul=\E[4m'  # undercurl support
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0
      '';
  };
}
