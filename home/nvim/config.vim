let g:chadtree_settings = {
    \'xdg': v:true,
    \'theme.text_colour_set': 'solarized_dark_256',
    \}
" let g:chadtree_settings =theme.text_colour_set = "nord"

set termguicolors
" configure nvcode-color-schemes
" let g:nvcode_termcolors=256
" syntax on
" colorscheme onedark " Or whatever colorscheme you make


" " checks if your terminal has 24-bit color support
" if (has("termguicolors"))
"     set termguicolors
"     hi LineNr ctermbg=NONE guibg=NONE
" endif
let g:chadtree_settings = {'xdg': v:true}



colorscheme nord

let g:peekup_open = '<leader>"'

set timeoutlen=200
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
let g:which_key_use_floating_win = 1
let g:which_key_centered = 0
let g:which_key_hspace = 2


nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>: <cmd>Telescope commands<cr>


nnoremap <leader>S :lua require('spectre').open()<CR>

