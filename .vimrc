" use visual bell instead of beeping
set vb

" incremental search
set incsearch

" Allow hidden buffers
set hidden

" syntax highlighting
set t_Co=256
set cursorline
color ir_black
syntax on

" autoindent
set autoindent|set cindent

" 2 space tabs
set tabstop=2|set shiftwidth=2|set expandtab|set softtabstop=2

" show matching brackets
set showmatch

" show line numbers
set number
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

" make tab in v mode ident code
vmap <tab> >gv
vmap <s-tab> <gv

" make tab in normal mode ident code
nmap <tab> I<tab><esc>
nmap <s-tab> ^i<bs><esc>

" paste mode - this will avoid unexpected effects when you
" cut or copy some text from one window and paste it in Vim.
set pastetoggle=<F5>

" Turn plugin on
filetype plugin indent on

set foldenable
set foldmarker={,}
set foldmethod=marker
set foldlevel=100
set listchars=tab:>-,trail:-
set statusline=%F%m%r%h%w\ %y\ [%l/%L,%04v](%p%%)
set laststatus=2

" Buffer navigation
map <C-k> :bp<CR>
map <C-j> :bn<CR>
map <C-h> :tabp<CR>
map <C-l> :tabn<CR>

" File edit shortcuts
let mapleader=','
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Set wrapping
set wrap
set linebreak
if executable("par")
    set formatprg=par\ -w80rq
endif

" vim bundles
call pathogen#infect()
nnoremap <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Syntax
au BufRead,BufNewFile *.pp              set filetype=puppet

" Mouse
set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>
set clipboard=unnamed
