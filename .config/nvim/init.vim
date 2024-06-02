call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kqito/vim-easy-replace'
Plug 'mhinz/vim-signify'
Plug 'derekwyatt/vim-scala'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf.vim'
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

color desert
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

""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""
:let g:NERDTreeWinSize=40

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

" Open File Tree
nnoremap <silent> <F2> <ESC>:NERDTreeToggle<CR>

" Moving between window pane
nmap <C-i> <C-w><up>
nmap <C-k> <C-w><down>
nmap <C-j> <C-w><left>
nmap <C-l> <C-w><right>

" Moving between tabs
nmap <silent> <S-j> <ESC>:tabprevious<CR>
nmap <silent> <S-l> <ESC>:tabnext<CR>

" FZF
nmap <silent> <Leader>f <ESC>:Files<CR>
nmap <silent> <Leader>c <ESC>:Commands<CR>
nmap <silent> <Leader>b <ESC>:Buffers<CR>
nmap <silent> <Leader>w <ESC>:Windows<CR>
