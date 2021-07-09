" Use ; for commands
nnoremap ; :

" Don't use Ex mode, use Q for formatting
nnoremap Q gq

" leader
"map <Space> <Leader>
let leader = "," " remap leader (from \)
let g:leader = "," " remap leader (global)
let mapleader = "," " remap leader (from \)
let g:mapleader = "," " remap leader (global)

nnoremap <leader>r :source ~/.config/nvim/init.vim<cr>
noremap <leader><space> :noh<cr>:call clearmatches()<cr>

" Navigate Vim Splits
nnoremap <C-J> <C-W><C-J> "Ctrl-j to move down a split
nnoremap <C-K> <C-W><C-K> "Ctrl-k to move up a split
nnoremap <C-L> <C-W><C-L> "Ctrl-l to move    right a split
nnoremap <C-H> <C-W><C-H> "Ctrl-h to move left a split

" Easy buffer navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Easy most-recent-buffer switching
nnoremap <Tab> :CocList buffers<CR>

" switch buffers
map <C-9> :bp<CR>
map <C-0> :bn<CR>

nnoremap <leader>q :q!<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>z :wq!<cr>
nnoremap <leader>\ :TagbarToggle<CR>
nmap <silent> <leader>y :FSHere<cr>

" Notes
nnoremap <leader>N :Note
nnoremap <leader>[ :Ngrep

" Open quickfix for last search
noremap <silent> <leader>/ :execute 'vimgrep/'.@/.'/g%'<cr>:copen<cr>

" Ripgrep for next search
noremap <silent> <leader>? :execute "!rg '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<cr>

" urlview
nnoremap <leader>u :w<Home>silent <End> !urlview<CR>

" Delete trailing whitespace with F5
":nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

command! -nargs=0 Format :call CocAction('format')

nnoremap <leader>f :Files<CR>
nnoremap <leader>F :Find .<CR>

" File explorer
nnoremap <F2> :Lexplore<CR>

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json,cpp,c,python,rust,go setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" grep word under cursor
command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>

vnoremap <leader>g :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
nnoremap <leader>g :<C-u>set operatorfunc=<SID>GrepFromSelected<CR>g@

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" change working directory to where the file in the buffer is located
" if user types `,cd`
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>h :split<CR>
