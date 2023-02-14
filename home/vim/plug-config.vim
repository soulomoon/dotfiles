
" au VimEnter * RainbowParenthesesToggle
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces
"
" set omnifunc=syntaxcomplete#Complete
" # supertab to cycle forward
let g:SuperTabDefaultCompletionType = "<c-n>"

"  let g:ale_haskell_hie_executable = "haskell-language-server-wrapper"
let g:ale_lint_on_text_changed = 1
" let g:ale_lint_on_save = 0

let g:ale_completion_delay = 100
let g:ale_completion_max_suggestions = 50
" let g:ale_python_pylint_options =  '--disable=C'

let g:ale_completion_enabled = 1
let g:ale_linters_explicit = 1
let g:ale_linters = { 
            \'haskell': ['hls'], 
            \'rust': ['analyzer'], 
            \'racket': ['racket_langserver'],
            \}
let g:ale_fixers = { 
            \'javascript': ['eslint'], 
            \'rust': ['analyzer'], 
            \'haskell': ['brittany'],
            \}
let g:ale_haskell_brittany_options = "--write-mode inplace"
" " disable style lint
let g:airline#extensions#ale#enabled = 1


"airline configuration#######################################################
"human readeable linesnumber
"function! MyLineNumber()
"	return substitute(line('.'), '\d\@<=\(\(\d\{3\}\)\+\)$', ',&', 'g'). ' | '.
"				\    substitute(line('$'), '\d\@<=\(\(\d\{3\}\)\+\)$', ',&', 'g')
"endfunction
"call airline#parts#define('linenr', {'function': 'MyLineNumber', 'accents': 'bold'})

 let g:airline_theme = "onedark"
 let g:airline_detect_modified=1
 let g:airline_detect_spell=1
 let g:airline_inactive_collapse=1
 let g:airline_powerline_fonts = 1
 let g:bufferline_echo = 0
 let g:airline#extensions#tabline#enabled = 1
 let g:airline_skip_empty_sections = 1

" extention --------------
" let g:airline#extensions#tagbar#enabled = 1
"let g:airline_section_x = (tagbar, filetype, virtualenv)
"let g:airline_section_z = airline#section#create(['%{ObsessionStatus(''$'', '''')}', 'windowswap', '%3p%% ', 'linenr', ':%3v '])
"autodeletbuffer from airline
" autocmd BufDelete * call airline#extensions#tabline#buflist#invalidate()

"nerdtree ####################################################################################
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
augroup NERDTree_group
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
augroup END
let g:NERDTreeChDirMode = 0
let g:NERDTreeGitStatusShowIgnored = 1

"vim-nerdtree-syntax-highlight'###########
"let g:NERDTreeLimitedSyntax = 1
"let g:NERDTreeSyntaxDisableDefaultExtensions = 1
"let g:NERDTreeDisableExactMatchHighlight = 1
"let g:NERDTreeDisablePatternMatchHighlight = 1
"let g:NERDTreeSyntaxEnabledExtensions = ['c', 'h', 'c++', 'php', 'rb', 'js', 'css'] " example
"vim-pydocstring

"vflazz/vim-colorscheme ###########################################
"let g:solarized_termcolors=256
"let base16colorspace=256

"one
"let g:one_allow_italics = 1 " I love italic for comments
" set background=dark
"colorscheme solarized8
colorscheme onedark
" let g:onedark_terminal_italics = 1
"let g:onedark_termcolors=256
"colorscheme base16-onedark

" fugitive
" autocmd QuickFixCmdPost *grep* cwindow

"Plug 'terryma/vim-multiple-cursors'
" let g:multi_cursor_use_default_mapping=0
" let g:multi_cursor_start_key='<C-g>'
" let g:multi_cursor_next_key='<C-g>'

"airblade/vim-gitgutter
"let g:gitgutter_highlight_lines = 1

"ryanoasis/vim-devicons####################
" let g:WebDevIconsOS = 'Darwin'
" let g:webdevicons_conceal_nerdtree_brackets = 1 
"let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
" let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
" let g:DevIconsEnableFoldersOpenClose = 1
"let g:webdevicons_enable_nerdtree = 1
" let g:DevIconsEnableFolderExtensionPatternMatching = 1
" let g:WebDevIconsUnicodeGlyphDoubleWidth = 1

" haskell
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1       

" autopairs
let g:AutoPairsShortcutFastWrap = '<M-e>'
