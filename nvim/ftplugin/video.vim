f exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

silent execute "!mpv " . shellescape(expand("%:p")) . " &>/dev/null &" | buffer# | bdelete# | redraw! | syntax on
