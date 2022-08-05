Plug 'nvim-neorg/neorg-telescope'
Plug 'nvim-neorg/neorg'
call plug#end()


lua << EOF
require('neorg').setup {
     config = {
                workspaces = {
                    work = "~/notes/work",
                    home = "~/notes/home",
                }
}
EOF
