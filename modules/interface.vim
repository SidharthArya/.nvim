if has('nvim')
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/denite.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()
" autocmd FileType denite call s:denite_my_settings()
" function! s:denite_my_settings() abort
"   nnoremap <silent><buffer><expr> <CR>
"   \ denite#do_map('do_action')
"   nnoremap <silent><buffer><expr> d
"   \ denite#do_map('do_action', 'delete')
"   nnoremap <silent><buffer><expr> p
"   \ denite#do_map('do_action', 'preview')
"   nnoremap <silent><buffer><expr> q
"   \ denite#do_map('quit')
"   nnoremap <silent><buffer><expr> i
"   \ denite#do_map('open_filter_buffer')
"   nnoremap <silent><buffer><expr> <Space>
"   \ denite#do_map('toggle_select').'j'
" endfunction
" 
" nnoremap <Space>ff :Denite file<CR>
" nnoremap <Space>bb :Denite buffer<CR>
"
"
nnoremap <Space>bn :bnext<CR>
nnoremap <Space>bp :bprev<CR>
nnoremap <Space>bd :bdelete<CR>
nnoremap <Space>bl :b#<CR>
nnoremap <Space>fr :History<CR>
nnoremap <Space>fF :Files<CR>
nnoremap <Space>fl :Lines<CR>
nnoremap <Space>ww :Windows<CR>
nnoremap <Space>bb :Buffers<CR>
nnoremap <Space>hb :Maps<CR>
nnoremap <Space>ff :Files<CR>
nnoremap <Space>fc :call fzf#vim#files('~/.config/nvim', 0)<CR>
nnoremap <Space>fC :call fzf#vim#files('~/.files', 0)<CR>

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', '~/.local/share/nvim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)
command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#gitfiles(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', '~/.local/share/nvim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)


nnoremap <Space>fg :Rg<CR>


function s:cd(path)
    execute 'cd ' a:path
    echo a:path
endfunction

