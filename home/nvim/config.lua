-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true


local telescope = require("telescope")
local lga_actions = require("telescope-live-grep-args.actions")


telescope.setup {
  extensions = {
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      -- define mappings, e.g.
      mappings = { -- extend mappings
        i = {
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        },
      },
      -- ... also accepts theme settings, for example:
      -- theme = "dropdown", -- use dropdown theme
      -- theme = { }, -- use own theme spec
      -- layout_config = { mirror=true }, -- mirror preview pane
    }
  }
}
-- vim.keymap.set("n", "<C-f>", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

-- empty setup using defaults
-- require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

require("nvim-treesitter.configs").setup {
    auto_install = false, 
    highlight = {
        enable = true
    },
    indent = {
        enable = true
    },
    incremental_selection = {
        enable = true
    }
}
require("trouble").setup {}
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end)
vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)



vim.o.pumblend = 30
vim.o.winblend = 30
vim.o.updatetime = 500
-- Add additional capabilities supported by nvim-cmp
local capabilities    = require('cmp_nvim_lsp').default_capabilities()

local nvim_lsp    = require('lspconfig')
local on_attach   = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = {
        noremap   = true,
        silent    = true
    }
    
    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
          local opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = 'none',
            source = 'always',
            prefix = ' ',
            scope = 'cursor',
          }
          vim.diagnostic.open_float(nil, opts)
        end
      })

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<space>li', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<space>lk', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>la', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>lr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>ll', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>ld', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>ln', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    buf_set_keymap('n', '<space>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    buf_set_keymap('v', 'f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
    buf_set_keymap('n', '<space>.', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
end
-- haskell = {
--     cabalFormattingProvider = "cabalfmt",
--     formattingProvider = "ormolu"
--   }


local servers = { }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150
        }
    }
end

vim.lsp.set_log_level("debug")

nvim_lsp.hls.setup{
        filetypes = { 'haskell', 'lhaskell', 'cabal' },
        cmd = {"/Users/ares/.cabal/bin/haskell-language-server", "--lsp"},
        settings = {
          haskell = {
              plugin = {
                semanticTokens = {
                  config = {
                      classMethodToken= "method",
                      classToken = "class",
                      dataConstructorToken=  "enumMember",
                      functionToken= "function",
                      moduleToken= "namespace",
                      patternSynonymToken= "macro",
                      recordFieldToken= "property",
                      typeConstructorToken= "enum",
                      typeFamilyToken= "interface",
                      typeSynonymToken= "type",
                      typeVariableToken= "typeParameter",
                      variableToken= "variable"
                  },
                  globalOn = true
              }
            }
          }
        },
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150
        }
}


local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end




vim.o.completeopt = 'menuone,noselect'
local luasnip = require 'luasnip'
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    mapping = {
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end
    },
    sources = {{
        name = 'nvim_lsp'
    }, {
        name = 'luasnip'
    }}
}

-- require("indent_blankline").setup {
--     -- for example, context is off by default, use this to turn it on
--     show_current_context = true,
--     show_current_context_start = true,
-- }

require'nvim-web-devicons'.setup {
    -- your personnal icons can go here (to override)
    -- you can specify color or cterm_color instead of specifying both of them
    -- DevIcon will be appended to `name`
    override = {
     zsh = {
       icon = "",
       color = "#428850",
       cterm_color = "65",
       name = "Zsh"
     }
    };
    -- globally enable different highlight colors per icon (default to true)
    -- if set to false all icons will have the default icon's color
    color_icons = true;
    -- globally enable default icons (default to false)
    -- will get overriden by `get_icons` option
    default = true;
    -- globally enable "strict" selection of icons - icon will be looked up in
    -- different tables, first by filename, and if not found by extension; this
    -- prevents cases when file doesn't have any extension but still gets some icon
    -- because its name happened to match some extension (default to false)
    strict = true;
    -- same as `override` but specifically for overrides by filename
    -- takes effect when `strict` is true
    override_by_filename = {
     [".gitignore"] = {
       icon = "",
       color = "#f1502f",
       name = "Gitignore"
     }
    };
    -- same as `override` but specifically for overrides by extension
    -- takes effect when `strict` is true
    override_by_extension = {
     ["log"] = {
       icon = "",
       color = "#81e043",
       name = "Log"
     }
    };
   }

require('bufferline').setup {}

-- require('feline').setup()
require'lualine'.setup {
    extensions = {
        'quickfix',
        'symbols-outline',
    }
}
require("symbols-outline").setup()


require("cheatsheet").setup({
    -- Whether to show bundled cheatsheets

    -- For generic cheatsheets like default, unicode, nerd-fonts, etc
    bundled_cheatsheets = true,
    -- bundled_cheatsheets = {
    --     enabled = {},
    --     disabled = {},
    -- },

    -- For plugin specific cheatsheets
    bundled_plugin_cheatsheets = true,
    -- bundled_plugin_cheatsheets = {
    --     enabled = {},
    --     disabled = {},
    -- }

    -- For bundled plugin cheatsheets, do not show a sheet if you
    -- don't have the plugin installed (searches runtimepath for
    -- same directory name)
    include_only_installed_plugins = true,
    telescope_mappings = {
        ['C-f'] = require('telescope').extensions.live_grep_args.live_grep_args
    }
})







require("toggleterm").setup{ 
    -- open_mapping = [[<ESC>]], 
}

local wk = require("which-key")
wk.register({
    ["<leader>"] = {
        f = {
          name = "telescope",
        --   f = { "<cmd>Telescope find_files<cr>", "Find File" },
        --   r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
        --   n = { "<cmd>enew<cr>", "New File" },
          g = { require('telescope').extensions.live_grep_args.live_grep_args, "telescope livegrep args" } -- you can also pass functions!
        },
      },
  }, {})
wk.setup {}

require('hlargs').setup()

vim.api.nvim_set_keymap("n", "<a-2>", "<esc><cmd>lua vim.diagnostic.goto_prev()<cr>", {}) -- pre error
vim.api.nvim_set_keymap("n", "<a-3>", "<esc><cmd>lua vim.diagnostic.goto_next()<cr>", {}) -- next error

require('legendary').setup({
  -- Initial keymaps to bind, can also be a function that returns the list
  keymaps = {},
  -- Initial commands to bind, can also be a function that returns the list
  commands = {},
  -- Initial augroups/autocmds to bind, can also be a function that returns the list
  autocmds = {},
  -- Initial functions to bind, can also be a function that returns the list
  funcs = {},
  -- Initial item groups to bind,
  -- note that item groups can also
  -- be under keymaps, commands, autocmds, or funcs;
  -- can also be a function that returns the list
  itemgroups = {},
  -- default opts to merge with the `opts` table
  -- of each individual item
  default_opts = {
    -- for example, { silent = true, remap = false }
    keymaps = {},
    -- for example, { args = '?', bang = true }
    commands = {},
    -- for example, { buf = 0, once = true }
    autocmds = {},
  },
  -- Customize the prompt that appears on your vim.ui.select() handler
  -- Can be a string or a function that returns a string.
  select_prompt = ' legendary.nvim ',
  -- Character to use to separate columns in the UI
  col_separator_char = '│',
  -- Optionally pass a custom formatter function. This function
  -- receives the item as a parameter and the mode that legendary
  -- was triggered from (e.g. `function(item, mode): string[]`)
  -- and must return a table of non-nil string values for display.
  -- It must return the same number of values for each item to work correctly.
  -- The values will be used as column values when formatted.
  -- See function `default_format(item)` in
  -- `lua/legendary/ui/format.lua` to see default implementation.
  default_item_formatter = nil,
  -- Customize icons used by the default item formatter
  icons = {
    -- keymap items list the modes in which the keymap applies
    -- by default, you can show an icon instead by setting this to
    -- a non-nil icon
    keymap = nil,
    command = '',
    fn = '󰡱',
    itemgroup = '',
  },
  -- Include builtins by default, set to false to disable
  include_builtin = true,
  -- Include the commands that legendary.nvim creates itself
  -- in the legend by default, set to false to disable
  include_legendary_cmds = true,
  -- Options for list sorting. Note that fuzzy-finders will still
  -- do their own sorting. For telescope.nvim, you can set it to use
  -- `require('telescope.sorters').fuzzy_with_index_bias({})` when
  -- triggered via `legendary.nvim`. Example config for `dressing.nvim`:
  --
  require('dressing').setup({
   select = {
     get_config = function(opts)
       if opts.kind == 'legendary.nvim' then
         return {
           telescope = {
             sorter = require('telescope.sorters').fuzzy_with_index_bias({})
           }
         }
       else
         return {}
       end
     end
   }
  }),

  sort = {
    -- put most recently selected item first, this works
    -- both within global and item group lists
    most_recent_first = true,
    -- sort user-defined items before built-in items
    user_items_first = true,
    -- sort the specified item type before other item types,
    -- value must be one of: 'keymap', 'command', 'autocmd', 'group', nil
    item_type_bias = nil,
    -- settings for frecency sorting.
    -- https://en.wikipedia.org/wiki/Frecency
    -- Set `frecency = false` to disable.
    -- this feature requires sqlite.lua (https://github.com/kkharji/sqlite.lua)
    -- and will be automatically disabled if sqlite is not available.
    -- NOTE: THIS TAKES PRECEDENCE OVER OTHER SORT OPTIONS!
    frecency = {
      -- the directory to store the database in
      db_root = string.format('%s/legendary/', vim.fn.stdpath('data')),
      -- the maximum number of timestamps for a single item
      -- to store in the database
      max_timestamps = 10,
    },
  },
  lazy_nvim = {
    -- Automatically register keymaps that are defined on lazy.nvim plugin specs
    -- using the `keys = {}` property.
    auto_register = false,
  },
  which_key = {
    -- Automatically add which-key tables to legendary
    -- see ./doc/WHICH_KEY.md for more details
    auto_register = true,
    -- you can put which-key.nvim tables here,
    -- or alternatively have them auto-register,
    -- see ./doc/WHICH_KEY.md
    mappings = {},
    opts = {},
    -- controls whether legendary.nvim actually binds they keymaps,
    -- or if you want to let which-key.nvim handle the bindings.
    -- if not passed, true by default
    do_binding = true,
    -- controls whether to use legendary.nvim item groups
    -- matching your which-key.nvim groups; if false, all keymaps
    -- are added at toplevel instead of in a group.
    use_groups = true,
  },
  -- Which extensions to load; no extensions are loaded by default.
  -- Setting the plugin name to `false` disables loading the extension.
  -- Setting it to any other value will attempt to load the extension,
  -- and pass the value as an argument to the extension, which should
  -- be a single function. Extensions are modules under `legendary.extensions.*`
  -- which return a single function, which is responsible for loading and
  -- initializing the extension.
  extensions = {
    nvim_tree = false,
    smart_splits = false,
    op_nvim = false,
    diffview = false,
  },
  scratchpad = {
    -- How to open the scratchpad buffer,
    -- 'current' for current window, 'float'
    -- for floating window
    view = 'float',
    -- How to show the results of evaluated Lua code.
    -- 'print' for `print(result)`, 'float' for a floating window.
    results_view = 'float',
    -- Border style for floating windows related to the scratchpad
    float_border = 'rounded',
    -- Whether to restore scratchpad contents from a cache file
    keep_contents = true,
  },
  -- Directory used for caches
  cache_path = string.format('%s/legendary/', vim.fn.stdpath('cache')),
  -- Log level, one of 'trace', 'debug', 'info', 'warn', 'error', 'fatal'
  log_level = 'info',
})
