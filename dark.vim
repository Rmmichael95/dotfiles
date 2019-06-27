scriptencoding utf-8

let g:airline#themes#dark#palette = {}

" The dark.vim theme:
let s:airline_a_normal   = [ '#303030' , '#ea81ff' , 236 , 5 ]
let s:airline_b_normal   = [ '#b2b2b2' , '#3a3a3a' , 249 , 237 ]
let s:airline_c_normal   = [ '#ea81ff' , '#444444' , 5  , 238 ]
let g:airline#themes#dark#palette.normal = airline#themes#generate_color_map(s:airline_a_normal, s:airline_b_normal, s:airline_c_normal)

let g:airline#themes#dark#palette.normal_modified = {
      \ 'airline_c': [ '#ea81ff' , '#444444' , 5     , 238      , ''     ] ,
      \ }

let s:airline_a_insert = [ '#444444' , '#8ec07c' , 238  , 6  ]
let s:airline_b_insert = [ '#b2b2b2' , '#3a3a3a' , 249 , 237  ]
let s:airline_c_insert = [ '#8ec07c' , '#444444' , 6  , 238  ]
let g:airline#themes#dark#palette.insert = airline#themes#generate_color_map(s:airline_a_insert, s:airline_b_insert, s:airline_c_insert)
let g:airline#themes#dark#palette.insert_modified = {
      \ 'airline_c': [ '#a1efe4' , '#444444' , 6   , 238      , ''     ] ,
      \ }
let g:airline#themes#dark#palette.insert_paste = {
      \ 'airline_a': [  '#c34d50'  , '#444444' , 2 , 238     , ''     ] ,
      \ }

let s:airline_a_replace = [ '#303030'   , '#c34d50' , 236  , 1  , '' ]
let s:airline_b_replace = [ '#b2b2b2' , '#3a3a3a' , 249 , 237 , '' ]
let s:airline_c_replace  = [ '#c34d50' , '#444444' , 1 , 238 , '' ]
let g:airline#themes#dark#palette.replace = airline#themes#generate_color_map(s:airline_a_replace, s:airline_b_replace, s:airline_c_replace)
let g:airline#themes#dark#palette.replace_modified = g:airline#themes#dark#palette.insert_modified


let s:airline_a_visual = [ '#303030' , '#7892ac' , 236 , 2 ]
let s:airline_b_visual = [ '#b2b2b2' , '#3a3a3a' , 249 , 237 ]
let s:airline_c_visual = [ '#7892ac' , '#444444' , 2 , 238  ]
let g:airline#themes#dark#palette.visual = airline#themes#generate_color_map(s:airline_a_visual, s:airline_b_visual, s:airline_c_visual)
let g:airline#themes#dark#palette.visual_modified = {
      \ 'airline_c': [ '#a1efe4' , '#444444' , 2     , 238      , ''     ] ,
      \ }

let s:airline_a_inactive = [ '#b2b2b2' , '#444444' , 249 , 238 , '' ]
let s:airline_b_inactive = [ '#b2b2b2' , '#444444' , 249 , 238 , '' ]
let s:airline_c_inactive = [ '#b2b2b2' , '#444444' , 249 , 238 , '' ]
let g:airline#themes#dark#palette.inactive = airline#themes#generate_color_map(s:airline_a_inactive, s:airline_b_inactive, s:airline_c_inactive)
let g:airline#themes#dark#palette.inactive_modified = {
      \ 'airline_c': [ '#f4bf75' , '' , 7 , '' , '' ] ,
      \ }

let g:airline#themes#dark#palette.accents = {
      \ 'red': [ '#c34d50' , '' , 1 , ''  ]
      \ }

" Here we define the color map for ctrlp.  We check for the g:loaded_ctrlp
" variable so that related functionality is loaded iff the user is using
" ctrlp. Note that this is optional, and if you do not define ctrlp colors
" they will be chosen automatically from the existing palette.
if get(g:, 'loaded_ctrlp', 0)
  let g:airline#themes#dark#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
        \ [ '#bfbff5' , '#444444' , 3 , 238  , ''     ],
        \ [ '#bfbdf5' , '#3a3a3a' , 3 , 237  , ''     ],
        \ [ '#303030' , '#bfbdf5' , 236  , 3 , 'bold' ])
endif
