if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

set autoindent|set smartindent|syntax on

let perl_include_pod = 1
let perl_extended_vars = 1 " syntax color complex things like @{${foo}}
