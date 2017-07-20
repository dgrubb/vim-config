" .vimrc
" dgrubb
" 07/19/2017
"
" My quick and dirty vim configuration. Nothing particularly exicting
" but there are a few things here which suit me.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install plugins
"
" 1) git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" 2) Open vim and issue: :PluginInstall
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'      " Specify vim's package manager
Plugin 'scrooloose/nerdtree'    " File explorer plugin
" N.B: To add JS error checking first install NodeJS, followed by JSHint:
" npm -g install jshint
Plugin 'scrooloose/syntastic'   " External syntax checking plugin
Plugin 'majutsushi/tagbar'      " Function and property listing in a side-bar

" N.B: YCM requires a manual installation step. After running PluginInstall 
" descend into its installation directory and run the install script to build
" its binary components. E.g.,:
" $ cd $HOME/.vim/bundle/YouCompleteMe
" $ ./install.py --tern-completer --clang-completer
" --term-completer allows for NodeJS integration, required for JS autocomplete
" --clang-completer allows for C-style autocompletion
"  Required packages:
"  apt-get install build-essential cmake python-dev python3-dev
Plugin 'Valloric/YouCompleteMe' " Auto-completion engine
Plugin 'ternjs/tern_for_vim'    " JS code analysis engine
" After installing tern and YCM make the following configurations:
"
" 1) Add a .jshintrc at the root of a project containing:
"
" {
"       "esversion": 6
" }
"
" This prevents warnings related to writing ES6 code (e.g., using const).
"
" 2) Add a .tern-project file to the root of the project containing:
"
" {
"   "libs": [],
"   "loadEagerly": [
"       "./js/third-party/underscore.js",
"       "./js/third-party/jquery-3.1.1.js"
"   ],
"   "plugins": {
"       "requirejs": {
"           "baseURL": "./",
"           "paths": {}
"       }
"   }
" }
"
" This allows for YouCompleteMe to use symbols defined in included libraries.


call vundle#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Look and feel
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set t_Co=256                            " Allow a reasonable amount of colours
syntax on                               " Enable vim's own syntax highlighting
set background=light                    " Tint the background behind characters
colorscheme distinguished               " https://github.com/Lokaltog/vim-distinguished

let NERDTreeMouseMode=2                 " Enable left-hand column file explorer
let NERDTreeMapOpenInTab='<2-LeftMouse>'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Usability
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set mouse=a                             " Switch to Insert mode on mouse click
set number                              " Enable line numbers
set list listchars=trail:.,tab:>-,eol:↲ " Show whitespace
set expandtab                           " Tabs
set tabstop=4                           " Tab width
set shiftwidth=4                        " Spaces (as tabs) width
set cursorline                          " Highlight current line
set hlsearch                            " Highlight searches
filetype plugin indent on               " Insert correct indents on newline

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Personally prefered key-bindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <F2> :NERDTreeToggle <bar> :TagbarToggle<CR>   " F2: open sidebars
nmap <F3> :tabnew<CR>                               " F3: open a new tab
nmap <F4> :%s/\s\+$//<CR>                           " F4: expunge trailing whitespace
nnoremap <F5> :set expandtab!<CR>                   " F5: Toggle spaces/tabs
noremap <C-Left> :tabprevious<CR>                   " Ctrl+Left: Previous tab
noremap <C-Right> :tabnext<CR>                      " Ctrl+Right: Next tab
noremap <silent> <Space> :nohlsearch<Bar>:echo<CR>  " Space: Clear search highlights
map <2-LeftMouse> g]<CR>                            " Search for symbol in ctags file

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Highlight 80 characters

" This is for vim versions <7.3:
" :au BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>77v', -1)
" :au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%80v.\+', -1)

" 7.3 onwards has this functionality built in:
let &colorcolumn=join(range(81,999),",")

" Check for syntax errors when opening and saving a file
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

