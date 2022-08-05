let module_root = expand("~/.config/nvim/modules/")
function Load(module_name)
	let module_path = g:module_root . a:module_name . ".vim"
	exec "source " . l:module_path
	" echo "[Module]: " . a:module_name
endfunction
nnoremap <Leader>Pi :PlugInstall<CR>
