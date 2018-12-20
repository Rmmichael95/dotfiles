silent execute "!ncmpcpp " . shellescape(expand("%:p")) . " &>/dev/null &" | buffer# | bdelete# | redraw! | syntax on
