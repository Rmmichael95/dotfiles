vim.cmd([[au BufRead,BufNewFile if &ft == "" | set filetype=text | endif]])
