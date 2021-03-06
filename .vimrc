let g:mirodark_disable_color_approximation=1
colorscheme mirodark

" use visual bell instead of beeping
set vb

" incremental search
set incsearch

" Allow hidden buffers
set hidden

" syntax highlighting
set t_Co=256
call pathogen#infect()
" set cursorline
syntax on

" autoindent
set autoindent|set cindent

" 2 space tabs
set tabstop=2|set shiftwidth=2|set expandtab|set softtabstop=2

" Use hard-tabs for shell
" autocmd FileType sh set noexpandtab

" show matching brackets
set showmatch

" show line numbers
set nonumber
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
set statusline=%F%m%r%h%w\ %y\ %=[%l/%L,%04v](%p%%)
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

" Syntax
au BufRead,BufNewFile *.pp   set filetype=puppet
au BufRead,BufNewFile *.cap  set filetype=ruby
au BufRead,BufNewFile *.task set filetype=ruby
au BufRead,BufNewFile *.rake set filetype=ruby

" Mouse
"set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>
set clipboard=unnamed


" Trailing Whitespace
highlight default link EndOfLineSpace ErrorMsg
match EndOfLineSpace / \+$/
autocmd InsertEnter * hi link EndOfLineSpace Normal
autocmd InsertLeave * hi link EndOfLineSpace ErrorMsg
function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction
autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()

"autocmd BufRead,BufNewFile *.md setlocal spell

" Disable puppet validate
let g:syntastic_puppet_validate_disable = 1

" Format Terraform files
function! Tffmt()
  let l:curw = winsaveview()
  let l:tmpfile = tempname() . ".tf"
  call writefile(getline(1, "$"), l:tmpfile)
  let output = system("terraform fmt -write " . l:tmpfile)
  if v:shell_error == 0
    try | silent undojoin | catch | endtry
    call rename(l:tmpfile, expand("%"))
    silent edit!
    let &syntax = &syntax
  else
    echo output
    call delete(l:tmpfile)
  endif
  call winrestview(l:curw)
endfunction

autocmd BufWritePre *.tf call Tffmt()
