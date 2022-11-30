"""""""""""
" PLUGINS "
"""""""""""

" Activate built-in plugins
set nocompatible

" Enables filetype detection, loads ftplugin, and loads indent
filetype plugin indent on

call plug#begin()
  Plug 'elixir-editors/vim-elixir'
  Plug 'junegunn/fzf.vim'
  Plug 'nelstrom/vim-visual-star-search'
  Plug 'sainnhe/sonokai'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
  Plug 'yuezk/vim-js'
  Plug '~/.fzf'
call plug#end()

syntax enable

" Enhances functionality of tag matching
runtime macros/matchit.vim

""""""""""""
" SETTINGS "
""""""""""""

" Avoid crashes on opening TS files
set re=2

" Show matches when tab completing
set wildmenu

" Use spaces instead of tabs
set expandtab

" Set tab width to two spaces
set tabstop=2

" Fixes backspace key: when backspacing remove two spaces at a time
" Ensures similar behaviour to tabstop
set softtabstop=2

" For normal mode indentation
set shiftwidth=2

" Smarter indentation
set autoindent

" Normal backspace behaviour
set backspace=indent,eol,start

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

" Search recursively into subfolders
set path+=**

" Ignore some dirs
set wildignore+=*/deps/*
set wildignore+=*/node_modules/*
set wildignore+=*/_build/*

" Disable automatic .swp files
set noswapfile

" Allow hidden buffers
set hidden

" Shorter wait for mappings to apply
set timeoutlen=500

set foldmethod=syntax
set foldlevelstart=99

"""""""""
" NETRW "
"""""""""

" Disable banner
let g:netrw_banner = 0

" Make 25% of screen width
let g:netrw_winsize = 25

" Tree view
let g:netrw_liststyle = 3

" Open splits to the right
let g:netrw_altv = 1

"""""""
" FZF "
"""""""

" Create/redefine custom command Rg
" Pass 0+ args to rg
" Escape special chars, with column numbers, enable previewer, not fullscreen
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Use ripgrep for file finding
let $FZF_DEFAULT_COMMAND = 'rg --files'

""""""""""""
" MAPPINGS "
""""""""""""

" Re-map leader to space
let mapleader = " "

inoremap jj <Esc>

" Open FZF file finder
nnoremap <silent> <C-p> :FZF -m<CR>

" Re-center screen after jumps
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz

" Expand current dir
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>

map <leader>ew :e %%
map <leader>et :tabe %%
map <leader>cd :lcd %%
map <leader>pbs :execute "rightbelow vsplit " . bufname("#")<cr>
map <leader>eh :rightbelow sp %%
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Copy file path
nnoremap <leader>y :let @+ = expand("%")<cr>

nnoremap Y y$

" Insert blank lines
nnoremap oo m`o<Esc>``
nnoremap OO m`O<Esc>``

nnoremap <leader><space> :<C-u>write<CR>
nnoremap <leader>q ZZ

" Sudo write
cnoremap w!! w !sudo tee > /dev/null %

" Use very magic by default
nnoremap / /\v

" Clear search highlight
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

cnoremap <C-U> <C-E><C-U>

" Make repeating substitutions easier
nnoremap & :&&<CR>
xnoremap & :&&<CR>

func Eatchar(pat)
   let c = nr2char(getchar(0))
   return (c =~ a:pat) ? '' : c
endfunc

" Show trailing whitespace

highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

augroup whitespace
  autocmd!
  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
augroup end

" Elixir shortcuts
augroup elixir_shortcuts
  autocmd!
  autocmd FileType elixir         vnoremap amp :<C-U>silent! normal! va{oh<CR>
  autocmd FileType elixir         omap amp :normal Vamp<CR>
  autocmd FileType elixir         vnoremap al :<C-U>execute "normal! /end\rmx?\\vfn\r:nohls\rv\r`xe"<CR>
  autocmd FileType elixir         omap al :normal Val<CR>
  autocmd FileType elixir         inoreabbrev fn fn<space><Esc>maa-><CR><space><CR>end<Esc>`ai
  autocmd FileType elixir         inoreabbrev def def<space><Esc>mai()<space>do<CR>end<Esc>`ai
  autocmd FileType elixir         inoreabbrev defp defp<space><Esc>mai()<space>do<CR>end<Esc>`ai
  autocmd FileType elixir         inoreabbrev defm defmodule<space><Esc>mni<space>do<CR>end<Esc>`ni
  autocmd FileType elixir         inoreabbrev doc @doc<space>"""<CR>"""<Esc>O<c-r>=Eatchar('\s')<CR>
  autocmd FileType elixir         inoreabbrev mdoc @moduledoc<space>"""<CR>"""<Esc>O<c-r>=Eatchar('\s')<CR>
  autocmd FileType elixir         inoreabbrev des describe<space>""<Esc>mmA<space>do<CR>end<Esc>`mi<c-r>=Eatchar('\s')<CR>
  autocmd FileType elixir         inoreabbrev te test<space>""<Esc>mmA<space>do<CR>end<Esc>`mi<c-r>=Eatchar('\s')<CR>
augroup end

" JS + React shortcuts
augroup js_shortcuts
  autocmd!
  autocmd FileType javascript,jsx inoremap im<Tab> import<space><space><Esc>mmi<space>from<space>""<Esc>i
  autocmd FileType javascript,jsx inoremap fu<Tab> function<space>(<Esc>maa)<space>{<CR><Tab><Esc>mmi<CR>}<Esc>`ai
  autocmd FileType javascript,jsx inoremap if<Tab> if<space>()<Esc>maa<space>{<CR><Tab><Esc>mmi<CR>}<Esc>`ai
  autocmd FileType javascript,jsx inoremap ife<Tab> if<space>()<Esc>maa<space>{<CR><Tab><Esc>mmi<CR>}<space>else<space>{<CR><Tab><Esc>mei<CR>}<Esc>`ai
  autocmd FileType javascript,jsx inoremap try<Tab> try<space>{<CR><Tab><Esc>mmi<CR>}<space>catch<space>(e)<space>{<CR><Tab><Esc>mci<CR>}<Esc>`mi
  autocmd FileType javascript,jsx inoremap =><Tab> ()<Esc>mma<space>=><space>
  autocmd FileType javascript,jsx inoremap ex<Tab> export<space>default<space>
  autocmd FileType javascript,jsx inoremap us<Tab> const<space>[]<Esc>mma<space>=<space>useState()<Esc>i
  autocmd FileType javascript,jsx inoremap ue<Tab> useEffect(()<space>=><space>{<CR><Tab><Esc>mmi<CR>},<space>[])<Esc>hi
augroup end

"""""""""""
" COLOURS "
"""""""""""

colorscheme sonokai

" Needed for italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
