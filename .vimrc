" Activate built-in plugins
set nocompatible
filetype plugin on

call plug#begin()
Plug 'elixir-editors/vim-elixir'
Plug 'tpope/vim-endwise'
Plug 'sainnhe/sonokai'
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
call plug#end()

" Enables syntax
syntax enable

" Enhances functionality of tag matching
runtime macros/matchit.vim

" Show matches when tab completing
set wildmenu

" Use spaces instead of tabs
set expandtab tabstop=2 softtabstop=2 shiftwidth=2

" Smarter indentation
set autoindent

" More history entries
set history=1000

" Show line numbers
set number

" Show row and column numbers
set ruler

" Status line for each window: show file
set laststatus=2

" Show partial command
set showcmd

" Case insensitive search
set ignorecase

" Override ignorecase if upper-case characters used
set smartcase

" Highlight searched text
set hlsearch

" Find search as you type
set incsearch

" Clear search highlight from hlsearch
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Disable automatic .swp files
set noswapfile

" Search recursively into subfolders
set path+=**

" Ignore some dirs
set wildignore+=*/deps/*
set wildignore+=*/node_modules/*
set wildignore+=*/_build/*

" Allow hidden buffers
set hidden

" Disable banner
let g:netrw_banner = 0

" Make 25% of screen width
let g:netrw_winsize = 25

" Tree view
let g:netrw_liststyle = 3

" Open splits to the right
let g:netrw_altv = 1

" Enables filetype detection, loads ftplugin, and loads indent
filetype plugin indent on

if has('termguicolors')
  set termguicolors
endif

" Needed for italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

colorscheme sonokai

" Open FZF file finder
nnoremap <silent> <C-p> :FZF -m<CR>

" Create/redefine custom command Rg
" Pass 0+ args to rg
" Escape special chars, with column numbers, enable previewer, not fullscreen
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Use ripgrep for file finding
let $FZF_DEFAULT_COMMAND = 'rg --files'

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
