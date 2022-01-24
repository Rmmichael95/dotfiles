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
      hi clear SpellBad
      hi SpellBad cterm=underline ctermfg=9
  endif
end
]])
-- open unsupported files
vim.cmd([[
function! myfuncs#OpenAll() abort
  if executable("xdg-open")
    return "xdg-open"
  endif
endfunction
]])

