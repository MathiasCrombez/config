set nocompatible
filetype off
""""""""""""""""""""""""""""""
" => Load vundle paths
""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
" let vundle manage vundle
" required!
Plugin 'gmarik/vundle'

""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
Plugin 'crookedneighbor/bufexplorer'
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
let g:bufExplorerFindActive=1
let g:bufExplorerSortBy='name'
map <leader>o :BufExplorer<cr>


""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
Plugin 'mru.vim'
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>


""""""""""""""""""""""""""""""
" => YankRing
""""""""""""""""""""""""""""""
Plugin 'YankRing.vim'
let g:yankring_history_dir = '~/.vim/temp_dirs/'


""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
Plugin 'kien/ctrlp.vim'
let g:ctrlp_working_path_mode = 0

let g:ctrlp_map = '<c-f>'
map <leader>j :CtrlP<cr>
map <c-b> :CtrlPBuffer<cr>
nnoremap <leader>. :CtrlPTag<cr>

let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'


""""""""""""""""""""""""""""""
" => ZenCoding
""""""""""""""""""""""""""""""
Plugin 'mattn/emmet-vim'
" Enable all functions in all modes
let g:user_emmet_mode='a'


""""""""""""""""""""""""""""""
" => snipMate (beside <TAB> support <CTRL-j>)
""""""""""""""""""""""""""""""
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
let g:snipMate = { 'snippet_version' : 1 }

" Optional:
Plugin 'honza/vim-snippets'
ino <c-j> <c-r>=snipMate#TriggerSnippet()<cr>
snor <c-j> <esc>i<right><c-r>=snipMate#TriggerSnippet()<cr>


""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
Plugin 'grep.vim'
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'scrooloose/nerdtree'
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <F2> :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark 
map <leader>nf :NERDTreeFind<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => surround.vim config
" Annotate strings with gettext http://amix.dk/blog/post/19678
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'tpope/vim-surround'
vmap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-airline config (force color)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
set t_Co=256
let g:airline_powerline_fonts = 1
let g:airline_theme = "solarized"
let g:airline_solarized_bg='dark'
"let g:airline#extensions#tabline#enabled = 1
set laststatus=2
set showtabline=2
"set term=rxvt-unicode-256color

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntastic (syntax checker)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'scrooloose/syntastic'
let g:syntastic_python_checkers=['pyflakes']
let g:syntastic_javascript_checkers = ['jshint']

" Custom CoffeeScript SyntasticCheck
func! SyntasticCheckCoffeescript()
    let l:filename = substitute(expand("%:p"), '\(\w\+\)\.coffee', '.coffee.\1.js', '')
    execute "e " . l:filename
    execute "SyntasticCheck"
    execute "Errors"
endfunc
nnoremap <silent> <leader>l :call SyntasticCheckCoffeescript()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git gutter (Git diff)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'airblade/vim-gitgutter'
nnoremap <silent> <leader>d :GitGutterToggle<cr>
let g:airline#extensions#hunks#non_zero_only = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Python
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'klen/python-mode'
let g:pymode_rope = 0

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

let g:pymode_indent = 1
"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

Plugin 'davidhalter/jedi-vim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'cuviper/vim-colors-solarized'
set background=dark

colorscheme solarized

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" = Tabular * align text
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'godlygeek/tabular.git'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vimagit
" https://github.com/jreybert/vimagit
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'jreybert/vimagit'
"    :Magit
"    Open magit buffer with :Magit command.
"    <C-n>
"    Jump to next hunk with <C-n>, or move the cursor as you like. The cursor is on a hunk.
"    S
"    While the cursor is on an unstaged hunk, press S in Normal mode: the hunk is now staged, and appears in "Staged changes" section (you can also unstage a hunk from "Staged section" with S).
"    CC
"    Once you have stage all the required changes, press CC.
"        Section "Commit message" is shown.
"        Type your commit message in this section.
"        To commit, go back in Normal mode, and press CC (or :w if you prefer).

Plugin 'tpope/vim-fugitive.git'


""""""""""""""""""""""""""""""""""""""
" => TagBar
" Require universal ctags
""""""""""""""""""""""""""""""""""""""
Plugin 'majutsushi/tagbar'
nmap <F3> :TagbarToggle<CR>

""""""""""""""""""""""""""""""""""""""
" => YouCompleteMe
" Require sudo apt-get install python-dev python3-dev
"         cd ~/.vim/bundle/YouCompleteMe
"         ./install.py --clang-completer
""""""""""""""""""""""""""""""""""""""
Plugin 'valloric/youcompleteme'
let g:ycm_confirm_extra_conf = 0

