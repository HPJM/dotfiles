" Set just to be safe: do not make Vim more Vi-compatible
set nocompatible

" Loads useful filetype plugins when filetype matches
filetype plugin on

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
