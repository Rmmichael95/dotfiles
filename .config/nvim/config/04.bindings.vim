nnoremap ; :

" Don't use Ex mode, use Q for formatting
nnoremap Q gq

" leader
"map <Space> <Leader>
let leader = " " " remap leader (from \)
let g:leader = " " " remap leader (global)
let mapleader = " " " remap leader (from \)
let g:mapleader = " " " remap leader (global)

set pastetoggle=<leader>P

nnoremap <leader>r :source ~/.config/nvim/init.vim<cr>
noremap <leader><space> :noh<cr>:call clearmatches()<cr>

" File explorer
"nnoremap <F2> :Lexplore<CR>

" new tab
map <C-t><C-t> :tabnew<CR>
" close tab
map <C-t><C-z> :tabclose<CR>

" split
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>h :split<CR>

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

" Easy most-recent-buffer switching
nnoremap <Tab> :buffers<CR>:buffer<Space>

" switch buffers
map <C-9> :bp<CR>
map <C-0> :bn<CR>

"nnoremap ,q :q!<cr>
nnoremap ,w :w<cr>
"nnoremap ,z :wq!<cr>
nnoremap <leader>\ :TagbarToggle<CR>
nmap <silent> <leader>y :FSHere<cr>

" Bash like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>

" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv

" :cd. change working directory t6o that of the current file
cmap cd. lcd %:p:h<cr>

" change working directory to where the file in the buffer is located
" if user types `,cd`
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" spell lang
nnoremap <F9> :call myfuncs#CycleLang()<CR>

" Notes & Pandoc
nnoremap <C-n> :cnext<cr>
nnoremap <C-N> :cprevious<cr>

" keep search in center screen
noremap n nzzzv
noremap N Nzzzv
noremap H ^
noremap L g

" Fix linewise visual selection of various text objects
nnoremap VV V
nnoremap Vit vitVkoj
nnoremap Vat vatV
nnoremap Vab vabV
nnoremap VaB vaBV

" gi already moves to "last place you exited insert mode", so we'll map gI to
" something similar: move to last change
nnoremap gI `.

" <ESC> exits in terminal mode
tnoremap <ESC> <C-\><C-n><C-w><C-p>

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

nnoremap <leader>f :Files<CR>
nnoremap <leader>F :Find .<CR>

"vnoremap <leader>g :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
"nnoremap <leader>g :<C-u>set operatorfunc=<SID>GrepFromSelected<CR>g@

" header guard
nnoremap <leader>g :call myfuncs#IncludeGuard()<CR>

" change working directory to where the file in the buffer is located
" if user types `,cd`
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" Symbols ---------------------------------- {{{3
 map! <C-v>ta τ
 map! <C-v>ph ϕ
" Math
 map! <C-v>ll →
 map! <C-v>hh ⇌
 map! <C-v>kk ↑
 map! <C-v>jj ↓
 map! <C-v>= ∝
 map! <C-v>~ ≈
 map! <C-v>!= ≠
 map! <C-v>>= ≥
 map! <C-v><= ≤
 map! <C-v>0  °
 map! <C-v>ce ¢
 map! <C-v>*  •

" Greek
map! <C-v>A Α
map! <C-v>a α
map! <C-v>B Β
map! <C-v>b β
map! <C-v>G Γ
map! <C-v>g γ
map! <C-v>D Δ
map! <C-v>d δ
map! <C-v>E Ε
map! <C-v>e ε
map! <C-v>Z Ζ
map! <C-v>z ζ
map! <C-v>H Η
map! <C-v>h η
map! <C-v>T Θ
map! <C-v>t θ
map! <C-v>I Ι
map! <C-v>i ι
map! <C-v>K Κ
map! <C-v>k κ
map! <C-v>L Λ
map! <C-v>l λ
map! <C-v>M Μ
map! <C-v>m μ
map! <C-v>N Ν
map! <C-v>n ν
map! <C-v>C Ξ
map! <C-v>c ξ
map! <C-v>O Ο
map! <C-v>o ο
map! <C-v>P Π
map! <C-v>p π
map! <C-v>R Ρ
map! <C-v>r ρ
map! <C-v>S Σ
map! <C-v>s σ
map! <C-v>T Τ
map! <C-v>t τ
map! <C-v>U Υ
map! <C-v>u υ
map! <C-v>F Φ
map! <C-v>f φ
map! <C-v>X Χ
map! <C-v>x χ
map! <C-v>Y ψ
map! <C-v>y ψ
map! <C-v>W Ω
map! <C-v>w ω
" Math
map! <C-v>fa ∀
map! <C-v>te ∃
map! <C-v>(- ∈
map! <C-v>-) ∋
map! <C-v>(u ∩
map! <C-v>u) ∪
map! <C-v>in ∫
map! <C-v>di ∬
map! <C-v>io ∮
map! <C-v>tf ∴
map! <C-v>bc ∵
map! <C-v>ae ≅
map! <C-v>ne ≠
map! <C-v>>= ≥
map! <C-v><= ≤
map! <C-v><= ⇐
map! <C-v>=> ⇒
map! <C-v>== ⇔
map! <C-v>ns ∅
map! <C-v>pd ∂
map! <C-v>00 ∞
" French
map! <C-v>A> Â
map! <C-v>a> â
map! <C-v>A' Á
map! <C-v>a' á
map! <C-v>A` À
map! <C-v>a` À
map! <C-v>E> Ê
map! <C-v>e> ê
map! <C-v>E' É
map! <C-v>e' é
map! <C-v>E` È
map! <C-v>e` è
map! <C-v>O> Ô
map! <C-v>o> ô
map! <C-v>O' Ó
map! <C-v>o' ó
map! <C-v>O! Ò
map! <C-v>o! ò
map! <C-v>L' Ĺ
map! <C-v>l' ĺ
map! <C-v>C, Ç
map! <C-v>c, ç
map! <C-v>S, Ş
map! <C-v>s, ş
" Misc
map! <C-v>hh ←
map! <C-v>jj ↓
map! <C-v>kk ↑
map! <C-v>ll →
map! <C-v>hl ↔
" Subscript and Superscript
map! <C-v>1 ~1~
map! <C-v>2 ~2~
map! <C-v>3 ~3~
map! <C-v>4 ~4~
map! <C-v>5 ~5~
map! <C-v>6 ~6~
map! <C-v>7 ~7~
map! <C-v>8 ~8~
map! <C-v>9 ~9~
map! <C-v>== ^+^
map! <C-v>=2 ^2+^
map! <C-v>=3 ^3+^
map! <C-v>-- ^-^
map! <C-v>-2 ^2-^
map! <C-v>-3 ^3-^
nnoremap ; :

" Don't use Ex mode, use Q for formatting
nnoremap Q gq

" leader
"map <Space> <Leader>
let leader = " " " remap leader (from \)
let g:leader = " " " remap leader (global)
let mapleader = " " " remap leader (from \)
let g:mapleader = " " " remap leader (global)

set pastetoggle=<leader>P

nnoremap <leader>r :source ~/.config/nvim/init.vim<cr>
noremap <leader><space> :noh<cr>:call clearmatches()<cr>

" File explorer
nnoremap <F2> :Lexplore<CR>

" new tab
map <C-t><C-t> :tabnew<CR>
" close tab
map <C-t><C-z> :tabclose<CR>

" split
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>h :split<CR>

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

" Easy most-recent-buffer switching
nnoremap <Tab> :buffers<CR>:buffer<Space>

" switch buffers
map <C-9> :bp<CR>
map <C-0> :bn<CR>

"nnoremap ,q :q!<cr>
nnoremap ,w :w<cr>
"nnoremap ,z :wq!<cr>
nnoremap <leader>\ :TagbarToggle<CR>
nmap <silent> <leader>y :FSHere<cr>

" Bash like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>

" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv

" :cd. change working directory t6o that of the current file
cmap cd. lcd %:p:h<cr>

" change working directory to where the file in the buffer is located
" if user types `,cd`
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" spell lang
nnoremap <F9> :call myfuncs#CycleLang()<CR>

" Notes & Pandoc
nnoremap <C-n> :cnext<cr>
nnoremap <C-N> :cprevious<cr>

" keep search in center screen
noremap n nzzzv
noremap N Nzzzv
noremap H ^
noremap L g

" Fix linewise visual selection of various text objects
nnoremap VV V
nnoremap Vit vitVkoj
nnoremap Vat vatV
nnoremap Vab vabV
nnoremap VaB vaBV

" gi already moves to "last place you exited insert mode", so we'll map gI to
" something similar: move to last change
nnoremap gI `.

" <ESC> exits in terminal mode
tnoremap <ESC> <C-\><C-n><C-w><C-p>

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

nnoremap <leader>f :Files<CR>
nnoremap <leader>F :Find .<CR>

"vnoremap <leader>g :<C-u>call <SID>GrepFromSelected(visualmode())<CR>
"nnoremap <leader>g :<C-u>set operatorfunc=<SID>GrepFromSelected<CR>g@

" header guard
nnoremap <leader>g :call myfuncs#IncludeGuard()<CR>

" change working directory to where the file in the buffer is located
" if user types `,cd`
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" Symbols ---------------------------------- {{{3
 map! <C-v>ta τ
 map! <C-v>ph ϕ
" Math
 map! <C-v>ll →
 map! <C-v>hh ⇌
 map! <C-v>kk ↑
 map! <C-v>jj ↓
 map! <C-v>= ∝
 map! <C-v>~ ≈
 map! <C-v>!= ≠
 map! <C-v>>= ≥
 map! <C-v><= ≤
 map! <C-v>0  °
 map! <C-v>ce ¢
 map! <C-v>*  •

" Greek
map! <C-v>A Α
map! <C-v>a α
map! <C-v>B Β
map! <C-v>b β
map! <C-v>G Γ
map! <C-v>g γ
map! <C-v>D Δ
map! <C-v>d δ
map! <C-v>E Ε
map! <C-v>e ε
map! <C-v>Z Ζ
map! <C-v>z ζ
map! <C-v>H Η
map! <C-v>h η
map! <C-v>T Θ
map! <C-v>t θ
map! <C-v>I Ι
map! <C-v>i ι
map! <C-v>K Κ
map! <C-v>k κ
map! <C-v>L Λ
map! <C-v>l λ
map! <C-v>M Μ
map! <C-v>m μ
map! <C-v>N Ν
map! <C-v>n ν
map! <C-v>C Ξ
map! <C-v>c ξ
map! <C-v>O Ο
map! <C-v>o ο
map! <C-v>P Π
map! <C-v>p π
map! <C-v>R Ρ
map! <C-v>r ρ
map! <C-v>S Σ
map! <C-v>s σ
map! <C-v>T Τ
map! <C-v>t τ
map! <C-v>U Υ
map! <C-v>u υ
map! <C-v>F Φ
map! <C-v>f φ
map! <C-v>X Χ
map! <C-v>x χ
map! <C-v>Y ψ
map! <C-v>y ψ
map! <C-v>W Ω
map! <C-v>w ω
" Math
map! <C-v>fa ∀
map! <C-v>te ∃
map! <C-v>(- ∈
map! <C-v>-) ∋
map! <C-v>(u ∩
map! <C-v>u) ∪
map! <C-v>in ∫
map! <C-v>di ∬
map! <C-v>io ∮
map! <C-v>tf ∴
map! <C-v>bc ∵
map! <C-v>ae ≅
map! <C-v>ne ≠
map! <C-v>>= ≥
map! <C-v><= ≤
map! <C-v><= ⇐
map! <C-v>=> ⇒
map! <C-v>== ⇔
map! <C-v>ns ∅
map! <C-v>pd ∂
map! <C-v>00 ∞
" French
map! <C-v>A> Â
map! <C-v>a> â
map! <C-v>A' Á
map! <C-v>a' á
map! <C-v>A` À
map! <C-v>a` À
map! <C-v>E> Ê
map! <C-v>e> ê
map! <C-v>E' É
map! <C-v>e' é
map! <C-v>E` È
map! <C-v>e` è
map! <C-v>O> Ô
map! <C-v>o> ô
map! <C-v>O' Ó
map! <C-v>o' ó
map! <C-v>O! Ò
map! <C-v>o! ò
map! <C-v>L' Ĺ
map! <C-v>l' ĺ
map! <C-v>C, Ç
map! <C-v>c, ç
map! <C-v>S, Ş
map! <C-v>s, ş
" Misc
map! <C-v>hh ←
map! <C-v>jj ↓
map! <C-v>kk ↑
map! <C-v>ll →
map! <C-v>hl ↔
" Subscript and Superscript
map! <C-v>1 ~1~
map! <C-v>2 ~2~
map! <C-v>3 ~3~
map! <C-v>4 ~4~
map! <C-v>5 ~5~
map! <C-v>6 ~6~
map! <C-v>7 ~7~
map! <C-v>8 ~8~
map! <C-v>9 ~9~
map! <C-v>== ^+^
map! <C-v>=2 ^2+^
map! <C-v>=3 ^3+^
map! <C-v>-- ^-^
map! <C-v>-2 ^2-^
map! <C-v>-3 ^3-^
