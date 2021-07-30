" Maintainer: Ryan M Sullivan
" Last Change: December 20, 2018
" ------------------------------------------------------------------------------
" Vim Plugins
" ------------------------------------------------------------------------ " {{{1

for f in split(glob('~/.config/nvim/plugin/*.vim'), '\n')
    exe 'source' f
endfor
