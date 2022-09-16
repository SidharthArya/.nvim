Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-commentary'

" Plug 'w0rp/ale'
" Plug 'Shougo/deoplete.nvim'
call plug#end()

" nnoremap <M-/> :Commentary<CR>
nnoremap <M-;> :Commentary<CR>
nnoremap <Leader>/ :Commentary<CR>

" let g:ale_completion_enabled = 1
" let b:ale_fixers = {'javascript': ['prettier', 'eslint'], 'go': ['gofmt', 'govet']}
" let b:ale_linters = {'javascript': ['eslint'], 'go': ['gofmt', 'govet']}
" set omnifunc=ale#completion#OmniFunc
" let g:deoplete#enable_at_startup = 1
"
"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

nnoremap <Space>Fj :execute '%!python -m json.tool' <bar> set filetype=json<CR>
nnoremap <Space>Fp :execute '%!black - -q' <bar> set filetype=python<CR>
