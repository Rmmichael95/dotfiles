" init.vim contains all of the initialization plugins for vim note that this
" has to be sourced second since dein needs to run its scripts first. This
" contains misc startup settings for vim
let g:python3_host_prog = '~/.local/share/nvim/.venv/bin/python'

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set shell=/usr/bin/zsh
"Enable syntax highlighting
syntax on

"misc
set browsedir=buffer
set history=10000
set showcmd
set nohlsearch
set ignorecase
set showmatch
set autoindent
set laststatus=2
set nospell
set nowrap

" Fixes backspace
set backspace=indent,eol,start

" Enable line/column info at bottom
set ruler

set scrolloff=10
set updatetime=300

" Autoindentation
set autoindent
filetype indent plugin on

" Copies using system clipboard
set clipboard+=unnamedplus

" Tab = 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4 " softtabstop, makes spaces feel like tabs when deleting

" This will set folds disabled by default, but they can be toggled with zi
set nofoldenable
set fdm=marker

" enable mouse support
set mouse=a mousemodel=popup

" relative line numbers
" Sets relative line numbers in normal mode, absolute line numbers in insert mode
set number
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

" use ripgreg instead of grep
set grepprg=rg\ --vimgrep

" Set colors in terminal
" true color support
set termguicolors
set background=dark
colorscheme everforest
highlight Normal guibg=NONE

" Highlight 81st column in long lines
autocmd BufEnter,FocusGained,BufWinEnter,WinEnter * match ColorColumn '\%81v.'

" Don't try to highlight lines longer than 800 characters.
set synmaxcol=800

set hidden
set nomodeline  " the modeline is a well-known security risk

" terminal settings
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

" encoding
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
set formatprg=par

" backup dir
set backupskip=/tmp/*,/private/tmp/*",*.gpg
set backupdir=~/.cache/dein/tmp/.backup//,/tmp
set undodir=~/.cache/dein/tmp/.undo//,/tmp
set directory=~/.cache/dein/tmp/.swp//,/tmp
set backup     " enable backups
set noswapfile

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" more natural splits
set splitbelow
set splitright

" live substitution for text edits
set inccommand=nosplit

" Special chars
set list lcs=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set showbreak=↪
set visualbell t_vb=".

set virtualedit+=block
