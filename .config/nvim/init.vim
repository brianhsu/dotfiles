call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kqito/vim-easy-replace'
Plug 'mhinz/vim-signify'
Plug 'derekwyatt/vim-scala'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""
" NVIM Basic Behavior settings
""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set bs=2
set mouse-=a

"""""""""""""""""""""""""""""""""""""""""""""""""""
" Color / Theme settings
"""""""""""""""""""""""""""""""""""""""""""""""""""

color peachpuff
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme = "bubblegum"

""""""""""""""""""""""""""""""""""""""""""""""""""
"" Signify
""""""""""""""""""""""""""""""""""""""""""""""""""
highlight SignColumn        ctermbg=none
highlight SignifySignAdd    cterm=bold ctermbg=none  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=none  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=none  ctermfg=227


"""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom Functions
"""""""""""""""""""""""""""""""""""""""""""""""""""

function UseSpace()
    set shiftwidth=4
    set tabstop=8
    set softtabstop=4
    set et
endfunction

function UseTab()
    set shiftwidth=0
    set tabstop=8
    set softtabstop=0
    set noet
endfunction

call UseSpace()

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Maps
"""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <F9> <ESC>:call UseSpace()<CR>
nnoremap <F10> <ESC>:call UseTab()<CR>

