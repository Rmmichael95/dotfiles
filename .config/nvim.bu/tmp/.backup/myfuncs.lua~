-- CycleLang
vim.cmd([[
function! myfuncs#CycleLang()
  let langs = ['', 'en_us', 'fr']

  let i = index(langs, &spl)
  let j = (i+1)%len(langs)
  let &spl = langs[j]

  if empty(&spl)
      set nospell
  else
      set spell
      hi clear SpellWrong
      hi SpellWrong cterm=underline ctermfg=9
  endif
end
]])
-- open unsupported files
vim.cmd([[
function! myfuncs#OpenAll() abort
  if executable("handlr")
    return "handlr"
  endif
endfunction
]])

