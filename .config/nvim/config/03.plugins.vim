" ------------------------------------------------------------------------------
" Vim Plugins
" ------------------------------------------------------------------------ " {{{1

for f in split(glob('~/.config/nvim/plugins/*.vim'), '\n')
    exe 'source' f
endfor
