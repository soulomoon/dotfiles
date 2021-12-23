{ config, pkgs, xdg, ... }:
let vimPlugins = 
    with pkgs.vimPlugins; [
      nord-vim
      onedark-vim 
      vim-nix trouble-nvim nvim-web-devicons 
      lsp-colors-nvim
      toggleterm-nvim
    ];
in
{
  programs.neovim = {
    enable = true;
    plugins = vimPlugins ++ (with pkgs.vimPlugins; [
        which-key-nvim
        nvim-treesitter
        plenary-nvim telescope-nvim
        nvim-lspconfig nvim-cmp cmp-nvim-lsp cmp_luasnip luasnip
        nvim-peekup
        # nvcode-color-schemes-vim
        nvim-spectre
        # vim-tree-lua
        chadtree
        symbols-outline-nvim
        indent-blankline-nvim
        bufferline-nvim
        # feline-nvim
        lualine-nvim 
        cheatsheet-nvim
        neorg
    ]); 
    extraConfig = builtins.readFile ./config.vim +
        "lua << EOF\n" +
        builtins.readFile ./config.lua +
        "\nEOF"
    ;

  };
  
  # vim
  xdg.dataFile = {
    "nvim/site/parser" = {
      source = with pkgs; tree-sitter.withPlugins (_: tree-sitter.allGrammars);
      recursive = true;
    };
  };
}
