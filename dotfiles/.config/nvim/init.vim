call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'derekwyatt/vim-scala'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-rooter'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'bkad/CamelCaseMotion'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""
" NVIM
""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on

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
set bs=2
set mouse-=a
set splitbelow
set splitright

color peachpuff

nnoremap <F9> <ESC>:call UseSpace()<CR>
nnoremap <F10> <ESC>:call UseTab()<CR>
imap <C-w> <C-o><C-w>
nmap <C-Down> <C-W><C-J>
nmap <C-Up> <C-W><C-K>
nmap <C-Right> <C-W><C-L>
nmap <C-Left> <C-W><C-H>
nmap <C-S-Left> :tabprevious<CR>
nmap <C-S-Right> :tabnext<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline
""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme = "bubblegum"

"""""""""""""""""""""""""""""""""""""""""""""""""""
"" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""
silent! map <F5> :NERDTreeToggle<CR>
silent! map <F6> :NERDTreeFind<CR>

let g:NERDTreeToggle="<F5>"
let g:NERDTreeMapActivateNode="<F6>"
let g:NERDTreeMapPreviewSplit="<F7>"

""""""""""""""""""""""""""""""""""""""""""""""""""
"" Signify
""""""""""""""""""""""""""""""""""""""""""""""""""
highlight SignColumn        ctermbg=none
highlight SignifySignAdd    cterm=bold ctermbg=none  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=none  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=none  ctermfg=227

call camelcasemotion#CreateMotionMappings('<leader>')

""""""""""""""""""""""""""""""""""""""""""""""""""
" Fuzzy Find
""""""""""""""""""""""""""""""""""""""""""""""""""
silent! map <leader>f :Files<CR>
silent! map <leader>b :Buffers<CR>

let g:fzf_action = {
  \ 'alt-t': 'tab split',
  \ 'alt-s': 'split',
  \ 'alt-v': 'vsplit' }


nnoremap <silent> <Leader>w :exe "resize +5"<CR>
nnoremap <silent> <Leader>s :exe "resize -5"<CR>
nnoremap <silent> <Leader>a :exe "vertical resize +5"<CR>
nnoremap <silent> <Leader>d :exe "vertical resize -5"<CR>

hi TabLineFill cterm=NONE ctermfg=DarkBlue ctermbg=DarkBlue
hi TabLine cterm=NONE ctermfg=Gray ctermbg=DarkBlue
hi TabLineSel cterm=NONE ctermfg=Black ctermbg=LightBlue
