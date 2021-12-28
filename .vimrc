set nocompatible                                          " Set just to be safe: do not make Vim more Vi-compatible
filetype plugin on                                        " Loads useful filetype plugins when filetype matches
runtime macros/matchit.vim                                " Enhances functionality of tag matching

set wildmenu                                              " Show matches when tab completing

set expandtab tabstop=2 softtabstop=2 shiftwidth=2        " Use spaces instead of tabs
set autoindent                                            " Smarter indentation

set history=1000                                          " More history entries

set number                                                " Show line numbers
set ruler                                                 " Show row and column numbers
set laststatus=2                                          " Status line for each window: show file
set ignorecase                                            " Case insensitive search 
set smartcase                                             " Override ignorecase if upper-case characters used

set hlsearch                                              " Highlight searched text
set incsearch                                             " Find search as you type
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>         " Clear search highlight from hlsearch

set noswapfile                                            " Disable automatic .swp files
