let mapleader = "<space>"

set clipboard+=unnamedplus
:set ignorecase 
noremap gV `[v`] 

if exists('g:vscode')
    " VSCode extension
else
    " ordinary neovim

set relativenumber
set showcmd
set number
set showmatch           " Show matching brackets.


if !&scrolloff
        set scrolloff=3       " Show next 3 lines while scrolling.
    endif
    if !&sidescrolloff
        set sidescrolloff=5   " Show next 5 columns while side-scrolling.
    endif

call plug#begin()

"Plug 'ThePrimeagen/vim-be-good'
Plug 'morhetz/gruvbox'

Plug 'scrooloose/nerdtree'
"Comment Plugin
Plug 'scrooloose/nerdcommenter'

"code auto-formatter
Plug 'sbdchd/neoformat'

"Plug 'Shougo/defx.nvim'
"Plug 'roxma/nvim-yarp'
"Plug 'roxma/vim-hug-neovim-rpc'


Plug 'lervag/vimtex'

"Code Checker
"Plug 'neomake/neomake'

"
Plug 'sheerun/vim-polyglot'


"Python IDE 
"Plug 'davidhalter/jedi-vim'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'zchee/deoplete-jedi'

"Auto Quote Completion
Plug 'jiangmiao/auto-pairs'

"Status bar plugin: vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Code Folding Plugin
"Plug 'tmhedberg/SimpylFold'

"Fuzzy Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"Show Commands
Plug 'liuchengxu/vim-which-key'

call plug#end()

colorscheme gruvbox


" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

"Python IDE
"let g:deoplete#enable_at_startup = 1
" disable autocompletion, because we use deoplete for completion
"let g:jedi#completions_enabled = 0
" open the go-to function in split, not another buffer
"let g:jedi#use_splits_not_buffers = "right"
"let g:python3_host_prog = 'C:\Users\arnau\AppData\Local\Programs\Python\Python37\python.exe'
"How to use jedi-vim
"Move the cursor to the class or method you want to check, then press the various supported shortcut provided by jedi-vim:
"<leader>d: go to definition
"K: check documentation of class or method
"<leader>n: show the usage of a name in current file
"<leader>r: rename a name

"Status bar plugin: vim-airline
let g:airline_theme='tomorrow' " <theme> is a valid theme name

"Code Checker
"call neomake#configure#automake('nrwi', 500)

"Source Information
"https://jdhao.github.io/2018/12/24/centos_nvim_install_use_guide_en/
"https://vim.fandom.com/wiki/Macros
"
endif
