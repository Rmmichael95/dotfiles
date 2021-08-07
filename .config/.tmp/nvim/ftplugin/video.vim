if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

call system(myfuncs#OpenAll() . " " . expand("%:p")) | buffer# | bdelete# | redraw! | syntax on
