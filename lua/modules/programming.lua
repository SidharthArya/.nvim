return {{
    'stevearc/conform.nvim',
    opts = {}
}, -- {
--   'mfussenegger/nvim-lint',
--   opts = {}
-- },
{
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {{
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = {
            history = true,
            updateevents = "TextChanged,TextChangedI"
        },
        config = function(_, opts)
            require("luasnip.loaders.from_vscode").lazy_load {
                exclude = vim.g.vscode_snippets_exclude or {}
            }
            require("luasnip.loaders.from_vscode").lazy_load {
                paths = vim.g.vscode_snippets_path or ""
            }

            -- snipmate format
            require("luasnip.loaders.from_snipmate").load()
            require("luasnip.loaders.from_snipmate").lazy_load {
                paths = vim.g.snipmate_snippets_path or ""
            }

            -- lua format
            require("luasnip.loaders.from_lua").load()
            require("luasnip.loaders.from_lua").lazy_load {
                paths = vim.g.lua_snippets_path or ""
            }

            vim.api.nvim_create_autocmd("InsertLeave", {
                callback = function()
                    if require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()] and
                        not require("luasnip").session.jump_active then
                        require("luasnip").unlink_current()
                    end
                end
            })
            require("luasnip").config.set_config(opts)
        end
    }, -- autopairing of (){}[] etc
    {
        "windwp/nvim-autopairs",
        opts = {
            fast_wrap = {},
            disable_filetype = {"TelescopePrompt", "vim"}
        },
        config = function(_, opts)
            require("nvim-autopairs").setup(opts)

            -- setup cmp for autopairs
            local cmp_autopairs = require "nvim-autopairs.completion.cmp"
            require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end
    }, -- cmp sources plugins
    {"saadparwaiz1/cmp_luasnip", "hrsh7th/cmp-nvim-lua", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer",
     "hrsh7th/cmp-path"}},
    opts = function()
return {}
    end,
    config = function(_, opts)
        require("cmp").setup(opts)
    end
}, {
    "nvim-treesitter/nvim-treesitter",
    event = {"BufReadPost", "BufNewFile"},
    cmd = {"TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo"},
    build = ":TSUpdate",
    opts = function()
        return {
            ensure_installed = {"lua", "luadoc", "printf", "vim", "vimdoc"},

            highlight = {
                enable = true,
                use_languagetree = true
            },

            indent = {
                enable = true
            }
        }
    end,
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end
}}
