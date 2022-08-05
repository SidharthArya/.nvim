Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'tom-anders/telescope-vim-bookmarks.nvim'
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'sudormrfbin/cheatsheet.nvim'
call plug#end()

lua require'telescope'.load_extension('project')
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope fd<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>

" Help
nnoremap <leader>ho :Telescope help_tags<CR>
nnoremap <leader>hk :Telescope keymaps<CR>

" Find
nmap <Leader>fb :Telescope vim_bookmarks all<CR>
nmap <Leader>fr :Telescope oldfiles<CR>
nmap <Leader>fd :Dashboard<CR>

" Bookmark
nmap <Leader>fB :Telescope vim_bookmarks all<CR>

" Buffer
nmap <Leader>bb :Telescope buffers<CR>
nmap <Leader>bd :bd<CR>
nmap <Leader>bn :bnext<CR>
nmap <Leader>bp :bprev<CR>
nmap <Leader>bl :bnext<CR>
nmap <Leader>bh :bprev<CR>
nmap <Leader>gb :Telescope git_branches<CR>


" Commands
" nmap <Leader>; :Telescope commands<CR>
"

" Reloads
nmap <Leader>rr :source ~/.config/nvim/init.vim<CR>
nmap <Leader>rR :source %<CR>
