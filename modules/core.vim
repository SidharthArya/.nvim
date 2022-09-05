call plug#begin()
Plug 'chrisbra/NrrwRgn'
call plug#end()

syntax on
set mouse=a
set autochdir
" nnoremap <SPACE> <Nop>
" let mapleader=" "
" let mapleader="\<Space>"
"
"
set encoding=UTF-8

filetype plugin on


nnoremap <Space>nr :NR<CR>
nnoremap <Space>rr :source %<CR>
nnoremap <Space>rR :source ~/.config/nvim/init.vim<CR>
