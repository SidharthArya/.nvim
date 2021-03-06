" Ensuring plugin manager is installed
if !filereadable(expand("~/.local/share/nvim/site/autoload/plug.vim"))
	echom "Installing Vim Plug"
	call system(expand("curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"))
endif

source ~/.config/nvim/modules/modular_config.vim
" Loading modules
call Load("core")
call Load("dashboard")
call Load("appearance")
call Load("files")
call Load("programming")
call Load("vc")
call Load("completion")
call Load("space")
call Load("finance")
call Load("emacs")
