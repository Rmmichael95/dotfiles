" ========{ Settings }================================================== " {{{1
set backup
"set backupskip=/tmp/*,/private/tmp/*",*.gpg
set backupdir=~/.nvim/tmp/.backup//,/tmp
set undodir=~/.nvim/tmp/.undo//,/tmp
set directory=~/.nvim/tmp/.swp//,/tmp
set browsedir=buffer
set history=10000
" Copies using system clipboard
set clipboard+=unnamedplus
"set autochdir
set mouse=a
set number
set ruler
set showcmd
set nohlsearch
set ignorecase
set showmatch
set autoindent
set laststatus=2
set tabstop=4
set shiftwidth=4
set expandtab
set hidden
set nospell
set encoding=utf-8
set termencoding=big5
set fileencoding=utf-8
set fileencodings=big5,utf-8
set fileformat=unix
set fileformats=unix,dos,mac
set formatprg=par
set cursorline
set nowrap
set completeopt=longest,menuone
set cot -=preview
set wildmenu
set wildchar=<TAB>
set wildmode=list:longest,list:full
set wildignore=*.o,*.class,*.pyc
set timeoutlen=1000 ttimeoutlen=0
set list lcs=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set noshowmode
set cmdheight=1
set visualbell t_vb=".
set tags=tags;
set fdm=marker
set splitbelow
set splitright
set backspace=indent,eol,start
set shell=/bin/zsh
set omnifunc=syntaxcomplete#Complete
highlight LineNr ctermfg=grey
let perl_include_pod = 1
let perl_extended_vars = 1 " syntax color complex things like @{${foo}}

