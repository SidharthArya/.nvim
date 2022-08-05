Plug 'nvim-neorg/neorg'
Plug 'nvim-neorg/neorg-telescope'
call plug#end()


lua << EOF
require('neorg').setup {
    load = {
        ["core.defaults"] = {},
	["core.integrations.telescope"] = {}, -- Enable the telescope module
	["core.norg.dirman"] = {
            config = {
                workspaces = {
                    Work = "~/Documents/Org/Notes/work",
                    Personal = "~/Documents/Org/Notes/personal",
                }
            }
        }
    }
}
requires = "nvim-neorg/neorg-telescope" -- Be sure to pull in the repo
require('nvim-treesitter.configs').setup {
    ensure_installed = { "norg", --[[ other parsers you would wish to have ]] },
    highlight = { -- Be sure to enable highlights if you haven't!
        enable = true,
    }
}
EOF

NeorgStart

nnoremap <Leader>nn :Telescope neorg 

