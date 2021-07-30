" Maintainer: Ryan M Sullivan
" Last Change: July 30, 2021
" ------------------------------------------------------------------------------
" Vim Plugins
" ------------------------------------------------------------------------ " {{{1

for f in split(glob('$XDG_CONFIG_HOME/nvim/plugin/*.vim'), '\n')
    exe 'source' f
endfor
