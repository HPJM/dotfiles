" Activate built-in plugins
set nocompatible
filetype plugin on

call plug#begin()
Plug 'elixir-editors/vim-elixir'
Plug 'tpope/vim-endwise'
Plug 'sainnhe/sonokai'
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'json', 'markdown', 'yaml', 'html'] }
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

" Expand current dir
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Use new RE engine
set re=0

" Prettier: format on save
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

" Re-map leader to space
let mapleader = " "

" Shorter wait for mappings to apply
set timeoutlen=500

" Insert blank lines
nnoremap oo m`o<Esc>``
nnoremap OO m`O<Esc>``

inoremap aa <Esc>A

" Prev buffer
nnoremap <leader>b :<C-u>b#<CR>

" Easier escape
inoremap jj <Esc>

" Clear search highlight from hlsearch
nnoremap <leader><space> :<C-u>nohlsearch<CR><C-l>

" Close pairs: but allow override with backspace and skip over closing pair with tab
inoremap "<backspace> "
inoremap " ""<left>
inoremap "<Tab> ""

inoremap '<backspace> '
inoremap ' ''<left>
inoremap '<Tab> ''

inoremap `<backspace> `
inoremap ` ``<left>
inoremap `<Tab> ``

inoremap (<backspace> (
inoremap ( ()<left>
inoremap (<Tab> ()

inoremap [<backspace> [
inoremap [ []<left>
inoremap [<Tab> []

inoremap {<backspace> {
inoremap { {}<left>
inoremap {<Tab> {}

" Don't auto-close as useful for HTML etc
inoremap <<Tab> <>

inoremap (<CR> (<CR>)<Esc>O
inoremap [<CR> [<CR>]<Esc>O
inoremap {<CR> {<CR>}<Esc>O
inoremap {;<CR> {<CR>};<Esc>O

" Auto-insert closing JSX/html tag and put cursor in between
inoremap <expr> ><Tab> (getline('.') =~ ' ' ? '><Esc>mmF<l"tyt<space>A</<C-r>t><Esc>F>a' : '><Esc>mmF<l"tyt>A</<C-r>t><Esc>F>a')

inoremap <expr> ><CR> (getline('.') =~ ' ' ? '><Esc>mmF<l"tyt<space>o</<C-r>t><Esc>O' : '><Esc>mmF<l"tyt>o</<C-r>t><Esc>O')

" JS + React shortcuts
autocmd FileType javascript,jsx inoremap im<Tab> import<space><space><Esc>mmi<space>from<space>""<Esc>i
autocmd FileType javascript,jsx inoremap fu<Tab> function<space>(<Esc>maa)<space>{<CR><Tab><Esc>mmi<CR>}<Esc>`ai
autocmd FileType javascript,jsx inoremap if<Tab> if<space>()<Esc>maa<space>{<CR><Tab><Esc>mmi<CR>}<Esc>`ai
autocmd FileType javascript,jsx inoremap ife<Tab> if<space>()<Esc>maa<space>{<CR><Tab><Esc>mmi<CR>}<space>else<space>{<CR><Tab><Esc>mei<CR>}<Esc>`ai
autocmd FileType javascript,jsx inoremap try<Tab> try<space>{<CR><Tab><Esc>mmi<CR>}<space>catch<space>(e)<space>{<CR><Tab><Esc>mci<CR>}<Esc>`mi
autocmd FileType javascript,jsx inoremap =><Tab> ()<Esc>mma<space>=><space>
autocmd FileType javascript,jsx inoremap ex<Tab> export<space>default<space>
autocmd FileType javascript,jsx inoremap us<Tab> const<space>[]<Esc>mma<space>=<space>useState()<Esc>i
autocmd FileType javascript,jsx inoremap ue<Tab> useEffect(()<space>=><space>{<CR><Tab><Esc>mmi<CR>},<space>[])<Esc>hi

" Elixir shortcuts
autocmd FileType elixir         inoremap fn<Tab> fn<space><space><Esc>maa-><space>end<Esc>F>a<space>
autocmd FileType elixir         inoremap fn<CR> fn<space><space><Esc>maa-><CR><Esc>mmi<CR>end<Esc>`mi<Tab><Tab>
autocmd FileType elixir         inoremap def<Tab> def<space><space><Esc>mni<space>do<CR><Esc>mmi<CR>end<Esc>`ni
autocmd FileType elixir         inoremap defp<Tab> defp<space><space><Esc>mni<space>do<CR><Esc>mmi<CR>end<Esc>`ni
autocmd FileType elixir         inoremap defm<Tab> defmodule<space><space><Esc>mni<space>do<CR><Esc>mmi<CR>end<Esc>`ni
autocmd FileType elixir         inoremap doc<Tab> @doc<space>"""<CR><Esc>mdi<CR>"""<Esc>`di<Tab>
autocmd FileType elixir         inoremap mdoc<Tab> @moduledoc<space>"""<CR><Esc>mdi<CR>"""<Esc>`di<Tab>
autocmd FileType elixir         inoremap des<Tab> describe<space>""<Esc>mmA<space>do<CR><CR>end<Esc>`mi
autocmd FileType elixir         inoremap te<Tab> test<space>""<Esc>mmA<space>do<CR><CR>end<Esc>`mi
