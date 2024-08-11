
require("fidget").setup {}

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"

vim.o.signcolumn = "yes"

-- require("catppuccin").setup({
--   flavour = "macchiato", -- latte, frappe, macchiato, mocha
--   background = { -- :h background
--       light = "latte",
--       dark = "mocha",
--   },
--   transparent_background = false, -- disables setting the background color.
--   show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
--   term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
--   dim_inactive = {
--       enabled = false, -- dims the background color of inactive window
--       shade = "dark",
--       percentage = 0.15, -- percentage of the shade to apply to the inactive window
--   },
--   no_italic = false, -- Force no italic
--   no_bold = false, -- Force no bold
--   no_underline = false, -- Force no underline
--   -- styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
--   --     comments = { "italic" }, -- Change the style of comments
--   --     conditionals = { "italic" },
--   --     loops = {},
--   --     functions = {},
--   --     keywords = {},
--   --     strings = {},
--   --     variables = {},
--   --     numbers = {},
--   --     booleans = {},
--   --     properties = {},
--   --     types = {},
--   --     operators = {},
--   -- },
--   color_overrides = {},
--   custom_highlights = {},
--   integrations = {
--       cmp = true,
--       gitsigns = true,
--       nvimtree = true,
--       treesitter = true,
--       notify = false,
--       mini = false,
--       lsp_trouble = true,
--       native_lsp = {
--         enabled = true,
--         virtual_text = {
--             errors = { "italic" },
--             hints = { "italic" },
--             warnings = { "italic" },
--             information = { "italic" },
--         },
--         underlines = {
--             errors = { "undercurl" },
--             hints = { "undercurl" },
--             warnings = { "undercurl" },
--             information = { "undercurl" },
--         },
--         inlay_hints = {
--             background = true,
--         },
--     },
--       -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
--   },
-- })

-- -- setup must be called before loading


-- Lua
require('onedark').load()
-- vim.cmd.colorscheme "onedark"


-- aplugin.background = colors.bg_dark
-- aplugin.my_error = util.lighten(colors.red1, 0.3) -- number between 0 and 1. 0 results in white, 1 results in red1