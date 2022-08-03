Plug 'jremmen/vim-ripgrep'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-commentary'
Plug 'w0rp/ale'
" Plug 'Shougo/deoplete.nvim'
call plug#end()

" nnoremap <M-/> :Commentary<CR>
nnoremap <M-;> :Commentary<CR>
nnoremap <Leader>/ :Commentary<CR>

let g:ale_completion_enabled = 1
let b:ale_fixers = {'javascript': ['prettier', 'eslint'], 'go': ['gofmt', 'govet']}
let b:ale_linters = {'javascript': ['eslint'], 'go': ['gofmt', 'govet']}
set omnifunc=ale#completion#OmniFunc
" let g:deoplete#enable_at_startup = 1
