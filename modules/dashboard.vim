Plug 'glepnir/dashboard-nvim'
Plug 'nvim-tree/nvim-web-devicons'
call plug#end()

lua << EOF
require('dashboard').setup{
  theme = 'hyper',
  config = {
    header,
    week_header = {
      enable,
      concat,
      append
    },
    disable_move,
    packages = { enable = false }
  }
}
EOF
