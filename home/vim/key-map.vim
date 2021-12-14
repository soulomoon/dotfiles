"due to conflicting with vim-tmux-navigato
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

" Enable folding with the spacebar
nnoremap <space> za

"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Clear highlighting on escape in normal mode
"nnoremap <esc> :noh<return><esc>
"nnoremap <esc>^[ <esc>^[


" nmap <silent> <A-l> :ALEFix<cr>
" nmap <silent> <A-b> :ALEGoToDefinition<cr>

"tagebar ########################################################################
nmap <F8> :TagbarToggle<CR>

" Easy align shortcut ########################################
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

map <C-t> :NERDTreeToggle<CR>


" remap essc
inoremap jk <esc>
inoremap <esc> <nop>


set timeoutlen=200
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
let g:which_key_use_floating_win = 0
let g:which_key_centered = 0
let g:which_key_hspace = 2

" fzf
nmap <C-f> :BLines<CR>
nmap <C-p> :Commands<CR>
nmap <S-F> :Rg<Space>
nmap <C-m> :Maps<CR>



nnoremap <leader>r :source $MYVIMRC<cr>

nnoremap <leader>sv :vsplit $MYVIMRC<cr>
nnoremap <leader>sh :split $MYVIMRC<cr>

" tabnext
nnoremap <leader>tb :tabNext<cr>
nnoremap <leader>tn :tabnew<cr>

" nnoremap whl :exe "resize " . (winheight(0) * 3/2)<CR>
" nnoremap whs :exe "resize " . (winheight(0) * 2/3)<CR>
" nnoremap wwl :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
" nnoremap wws :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

nnoremap <silent> <Leader>whl :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>whs :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>wwl :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <Leader>wws :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

" which key
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

