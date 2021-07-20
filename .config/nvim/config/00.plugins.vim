" ========{ Plugins }================================================== " {{{1

if has('nvim')
    runtime! python_setup.vim
endif

" ----[ Dein ]------------------------------------ " {{{2

if &compatible
    set nocompatible
endif

if empty(glob('~/.cache/dein'))
    silent !curl -fLo /home/ryanm/.cache/dein/installer.sh --create-dirs
     \ https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh
    silent !sh /home/ryanm/.cache/dein/installer.sh ~/.cache/dein
endif

set runtimepath+=/home/ryanm/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('/home/ryanm/.cache/dein')
	" Required: "
    call dein#begin('/home/ryanm/.cache/dein')

	" Let dein manage dein "
    " Required: "
    call dein#add('/home/ryanm/.cache/dein/repos/github.com/Shougo/dein.vim')

	" Packages "
	if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif
    call dein#add('sheerun/vim-polyglot')
    call dein#add('vim-scripts/L9')
    call dein#add('neovimhaskell/haskell-vim')
    call dein#add('mhinz/vim-startify')
    call dein#add('Shougo/deol.nvim')
    call dein#add('lambdalisue/suda.vim')
    call dein#add('vim-airline/vim-airline')
    call dein#add('tpope/vim-commentary')
    call dein#add('neomutt/neomutt.vim')
    call dein#add('lotabout/skim', {'path': '~/.local/share/skim', 'build': '~/.local/share/skim/install'})
    call dein#add('lotabout/skim.vim')
    call dein#add('jamessan/vim-gnupg')
    call dein#add('justinmk/vim-dirvish')
    call dein#add('Shougo/neco-syntax')
    call dein#add('neoclide/coc-neco')
    call dein#add('neoclide/coc.nvim', {'merged':0, 'rev': 'release'})
    call dein#add('puremourning/vimspector', {'build' : 'python3 install_gadget.py --all'})
    call dein#add('Shougo/vimproc.vim', {'build': 'make'})
    call dein#add('tpope/vim-dispatch')
    call dein#add('radenling/vim-dispatch-neovim')
    call dein#add('tpope/vim-fugitive', {
                \'on_cmd': ['Git', 'Gstatus', 'Gwrite', 'Glog', 'Gcommit', 'Gblame', 'Ggrep', 'Gdiff'],
                \ })
    call dein#add('christoomey/vim-conflicted')
    call dein#add('tpope/vim-sleuth')
    call dein#add('godlygeek/tabular')
    call dein#add('tpope/vim-eunuch')
    call dein#add('ervandew/supertab')
    call dein#add('mbbill/undotree', {'on_cmd': 'UndotreeToggle'})
    call dein#add('jlanzarotta/bufexplorer')
    call dein#add('qpkorr/vim-bufkill')
    call dein#add('tpope/vim-endwise')
    call dein#add('tpope/vim-surround', {
                \ 'on_map': {'n' : ['cs', 'ds', 'ys'], 'x' : 'S'},
                \ 'depends': 'vim-repeat',
                \ })
    call dein#add('tpope/vim-repeat', {'on_map': {'n': ['.']}})
    call dein#add('jiangmiao/auto-pairs')
    call dein#add('jeffkreeftmeijer/vim-numbertoggle')
    call dein#add('ntpeters/vim-better-whitespace')
    call dein#add('luochen1990/rainbow')
    call dein#add('rhysd/vim-grammarous')
    call dein#add('powerman/vim-plugin-viewdoc')
    call dein#add('zhaocai/GoldenView.Vim', {'on_cmd': '<Plug>ToggleGoldenViewAutoResize'})
    call dein#add('dhruvasagar/vim-table-mode')
    call dein#add('Konfekt/FastFold')
    call dein#add('lervag/wiki.vim')
        " Thux
    call dein#add('benmills/vimux')
    call dein#add('christoomey/vim-tmux-navigator')
    " ctags / cscope
    call dein#add('preservim/tagbar', {'on_cmd': 'TagbarToggle'})
    call dein#add('jsfaint/gen_tags.vim', {'on_cmd': ['GenCtags', 'GenGtags']})
    call dein#add('mfulz/cscope.nvim', {'on_ft': ['c', 'cpp']})
    " Rust
    call dein#add('rust-lang/rust.vim')
    " Python
    call dein#add('tmhedberg/SimpylFold')
    call dein#add('vim-scripts/indentpython.vim')
    call dein#add('nvie/vim-flake8')
    " C++
    call dein#add('octol/vim-cpp-enhanced-highlight', {'on_ft': ['c', 'cpp', 'h']})
    call dein#add('derekwyatt/vim-protodef', {'on_ft': ['c', 'cpp', 'h']})
    "R
    call dein#add('jalvesaq/Nvim-R', {'rev': 'stable'})
    " Javascript
    call dein#add('othree/jspc.vim', {'on_ft': 'java'})
    " Markdown
    call dein#add('cespare/vim-toml')
    call dein#add('rhysd/vim-gfm-syntax')
    call dein#add('elzr/vim-json', {'on_ft': 'json'})
    call dein#add('plasticboy/vim-markdown')
    call dein#add('vim-pandoc/vim-pantondoc', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd']})
    call dein#add('vim-pandoc/vim-pandoc-syntax', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd']})

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
 call dein#install()
endif
