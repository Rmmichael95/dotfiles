if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

au BufRead,BufNewFile,BufEnter   $NOTES_DIR/*/*.txt let &complete="$NOTES_DIR/**/*.txt"
au BufRead,BufNewFile,BufEnter   $NOTES_DIR/*/*.txt lcd %:h
"au BufRead,BufWrite,InsertChange $NOTES_DIR/*/*.txt syn match ErrorMsg '\%>79v.\+'
au Filetype rmd map <C-c> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>

setlocal spell
setlocal spellsuggest
set textwidth=79
setlocal formatexpr=

" Personal preference, I like to see the formatting modifiers
setlocal conceallevel=0

" Don't enable spell check for documentation windows from coc
augroup noPreviewSpell
    autocmd!
    autocmd BufRead,BufNewFile,BufEnter,BufLeave coc://document setlocal nospell
augroup END

" syntax highlighting for latex blocks in markdown
let g:vim_markdown_math = 1

" markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_math = 0
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_default_key_mappings = 1

" YAML syntax highlighting for frontmatter
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_fenced_languages = [
            \'csharp=cs',
            \ 'cpp=cpp',
            \'c=c',
            \'rust=rust',
            \'python=python',
            \'sh=sh',
            \'html=html',
            \'md=markdown']
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_conceal = 0
