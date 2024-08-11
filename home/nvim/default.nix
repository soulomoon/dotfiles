{ config, pkgs, xdg, pkgs-unstable, ... }:
let
  vimPlugins =
    with pkgs.vimPlugins; [
      nord-vim
      onedark-nvim
      vim-nix
      trouble-nvim
      nvim-web-devicons
      lsp-colors-nvim
      toggleterm-nvim
      # catppuccin-nvim
      # tokyonight-nvim
      # m-demare-hlargs-nvim
    ];
  hlargs-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "hlargs.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "m-demare";
      repo = "hlargs.nvim";
      rev = "master";
      sha256 = "UAB1vXypJye0UeOo64mHhTuTKcCbwB1AQDFarbLEUAo=";
    };
  };
  nvim-plugintree = (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.c
    p.lua
    p.nix
    p.bash
    p.javascript
    p.cpp
    p.json
    p.python
    p.markdown
    p.haskell
  ]));

  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = nvim-plugintree.dependencies;
  };
in
{
  programs.neovim = {
    enable = true;
    # package = pkgs-unstable.neovim;
    plugins = vimPlugins ++ (with pkgs.vimPlugins; [
      dressing-nvim
      legendary-nvim
      nvim-tree-lua
      hlargs-nvim
      which-key-nvim
      nvim-treesitter
      plenary-nvim
      telescope-nvim
      nvim-lspconfig
      nvim-cmp
      fidget-nvim
      cmp-nvim-lsp
      cmp_luasnip

      luasnip
      nvim-peekup
      telescope-live-grep-args-nvim
      # nvcode-color-schemes-vim
      nvim-spectre
      # vim-tree-lua
      symbols-outline-nvim
      indent-blankline-nvim
      bufferline-nvim
      # feline-nvim
      lualine-nvim
      cheatsheet-nvim
      neorg
      nvim-plugintree

    ]);
    extraConfig = builtins.readFile ./config.vim
      + "lua << EOF\n"
      + builtins.readFile ./config.lua
      + builtins.readFile ./ui.lua
      + "\nEOF"
    ;

  };

  xdg.configFile = {
    "nvim/init.lua".text = ''
      -- Add Treesitter Plugin Path
      vim.opt.runtimepath:append("${pkgs.vimPlugins.nvim-treesitter}")
      -- Add Treesitter Parsers Path
      vim.opt.runtimepath:append("${treesitter-parsers}")
      -- Invoke Real Start
    '';
  };

  # vim
  # xdg.dataFile = {
  #   "nvim/site/parser" = {
  #     source = with pkgs; tree-sitter.withPlugins (_: tree-sitter.allGrammars);
  #     recursive = true;
  #   };
  # };
}
