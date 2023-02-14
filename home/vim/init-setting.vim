"set shell=bash\ -i
let mapleader = ","
syntax on
set nocompatible 
set showcmd
set hlsearch
set cmdheight=1
set linebreak
set noshowmode
set encoding=utf8
set ts=4 sts=4 sw=4 expandtab
"list completion options
set wildmenu
set wildmode=longest:full,full
set completeopt=menu,menuone,preview,noselect,noinsert
set splitbelow
set splitright

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
:autocmd InsertEnter * set cul
:autocmd InsertLeave * set nocul
"case
"set ignorecase
" set smartcase
"line Number
set number
" set relativenumber
"story command history
set history=10000
"syntax enable
" set nolazyredraw
"auto reload file
" set autoread

filetype plugin indent on
"On pressing tab, insert 4 spaces

augroup file_setting
    autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
    "javascript set 2 as indent
    autocmd Filetype javascript.jsx.html.rkt setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType rkt setl commentstring=;\ %s
    autocmd FileType cl setl commentstring=;\ %s
    autocmd BufRead,BufNewFile *.rkt setlocal filetype=racket
augroup END

" enable true color
set termguicolors

"set relativenumber
set list
set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮
set showbreak=↪


if (has("nvim"))
    let g:python_host_prog = '~/.pyenv/versions/neovim2/bin/python'
    let g:python3_host_prog = '~/.pyenv/versions/neovim3/bin/python3'
endif
set foldmethod=syntax


set signcolumn=yes
set guifont=JetBrainsMono\ Nerd\ Font:h12
" remove scrollbars
set guioptions=
