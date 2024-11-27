vim.cmd([[call system(myfuncs#OpenAll() . " " . expand("%:p")) | buffer# | bdelete# | redraw! | syntax on]])
