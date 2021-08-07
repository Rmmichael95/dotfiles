" Maintainer: Ryan M Sullivan
" Last Change: August 1, 2021
" ------------------------------------------------------------------------------
" Vim Configuration
" ------------------------------------------------------------------------ " {{{1

for f in split(glob('~/.config/nvim/config/*.vim'), '\n')
    exe 'source' f
endfor
