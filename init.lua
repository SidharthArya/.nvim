vim.opt.number = true
vim.opt.mouse = 'a'

-- Case
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.breakindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = false

vim.keymap.set('n', '<space>bs', '<cmd>write<cr>', {desc = 'Save'})


-- Package Management
local lazy = {}

function lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print('Installing lazy.nvim....')
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      path,
    })
  end
end


function lazy.setup(plugins)
  -- You can "comment out" the line below after lazy.nvim is installed
  lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)
  require('lazy').setup(plugins, lazy.opts)
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup({
  ---
  -- List of plugins
  ---
	{'folke/tokyonight.nvim'},
  {'nvim-lualine/lualine.nvim'},
	{'nvim-lua/plenary.nvim'},
	{'nvim-telescope/telescope.nvim'},
	{'neovim/nvim-lspconfig'},
	{'nvim-tree/nvim-web-devicons'},
	{'lewis6991/gitsigns.nvim'},
	{'kdheepak/lazygit.nvim', dependencies="nvim-lua/plenary.nvim"},
	{'romgrk/barbar.nvim'},
	{'numToStr/Comment.nvim'},
	{"ahmedkhalf/project.nvim"},
	{'nvim-treesitter/nvim-treesitter'},
	{'voldikss/vim-floaterm'},
	{'Mofiqul/vscode.nvim'},
	{'nvim-tree/nvim-tree.lua'},
	{'ggandor/leap.nvim'}
})

require('lualine').setup{
options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

vim.g.barbar_auto_setup = true -- disable auto-setup



-- require'barbar'.setup {
--   -- WARN: do not copy everything below into your config!
--   --       It is just an example of what configuration options there are.
--   --       The defaults are suitable for most people.
--
--   -- Enable/disable animations
--   animation = true,
--
--   -- Enable/disable auto-hiding the tab bar when there is a single buffer
--   auto_hide = false,
--
--   -- Enable/disable current/total tabpages indicator (top right corner)
--   tabpages = true,
--
--   -- Enables/disable clickable tabs
--   --  - left-click: go to buffer
--   --  - middle-click: delete buffer
--   clickable = true,
--
--   -- Excludes buffers from the tabline
--   -- exclude_ft = {'javascript'},
--   -- exclude_name = {'package.json'},
--
--   -- A buffer to this direction will be focused (if it exists) when closing the current buffer.
--   -- Valid options are 'left' (the default), 'previous', and 'right'
--   focus_on_close = 'left',
--
--   -- Hide inactive buffers and file extensions. Other options are `alternate`, `current`, and `visible`.
--   hide = {extensions = true, inactive = true},
--
--   -- Disable highlighting alternate buffers
--   highlight_alternate = false,
--
--   -- Disable highlighting file icons in inactive buffers
--   highlight_inactive_file_icons = false,
--
--   -- Enable highlighting visible buffers
--   highlight_visible = true,
--
--   icons = {
--     -- Configure the base icons on the bufferline.
--     -- Valid options to display the buffer index and -number are `true`, 'superscript' and 'subscript'
--     buffer_index = false,
--     buffer_number = false,
--     button = '',
--     -- Enables / disables diagnostic symbols
--     diagnostics = {
--       [vim.diagnostic.severity.ERROR] = {enabled = true, icon = 'ﬀ'},
--       [vim.diagnostic.severity.WARN] = {enabled = false},
--       [vim.diagnostic.severity.INFO] = {enabled = false},
--       [vim.diagnostic.severity.HINT] = {enabled = true},
--     },
--     gitsigns = {
--       added = {enabled = true, icon = '+'},
--       changed = {enabled = true, icon = '~'},
--       deleted = {enabled = true, icon = '-'},
--     },
--     filetype = {
--       -- Sets the icon's highlight group.
--       -- If false, will use nvim-web-devicons colors
--       custom_colors = false,
--
--       -- Requires `nvim-web-devicons` if `true`
--       enabled = true,
--     },
--     separator = {left = '▎', right = ''},
--
--     -- If true, add an additional separator at the end of the buffer list
--     separator_at_end = true,
--
--     -- Configure the icons on the bufferline when modified or pinned.
--     -- Supports all the base icon options.
--     modified = {button = '●'},
--     pinned = {button = '', filename = true},
--
--     -- Use a preconfigured buffer appearance— can be 'default', 'powerline', or 'slanted'
--     preset = 'default',
--
--     -- Configure the icons on the bufferline based on the visibility of a buffer.
--     -- Supports all the base icon options, plus `modified` and `pinned`.
--     alternate = {filetype = {enabled = false}},
--     current = {buffer_index = true},
--     inactive = {button = '×'},
--     visible = {modified = {buffer_number = false}},
--   },
--
--   -- If true, new buffers will be inserted at the start/end of the list.
--   -- Default is to insert after current buffer.
--   insert_at_end = true,
--   insert_at_start = false,
--
--   -- Sets the maximum padding width with which to surround each tab
--   maximum_padding = 1,
--
--   -- Sets the minimum padding width with which to surround each tab
--   minimum_padding = 1,
--
--   -- Sets the maximum buffer name length.
--   maximum_length = 30,
--
--   -- Sets the minimum buffer name length.
--   minimum_length = 0,
--
--   -- If set, the letters for each buffer in buffer-pick mode will be
--   -- assigned based on their name. Otherwise or in case all letters are
--   -- already assigned, the behavior is to assign letters in order of
--   -- usability (see order below)
--   semantic_letters = true,
--
--   -- Set the filetypes which barbar will offset itself for
--   sidebar_filetypes = {
--     -- Use the default values: {event = 'BufWinLeave', text = nil}
--     NvimTree = true,
--     -- Or, specify the text used for the offset:
--     undotree = {text = 'undotree'},
--     -- Or, specify the event which the sidebar executes when leaving:
--     ['neo-tree'] = {event = 'BufWipeout'},
--     -- Or, specify both
--     Outline = {event = 'BufWinLeave', text = 'symbols-outline'},
--   },
--
--   -- New buffer letters are assigned in this order. This order is
--   -- optimal for the qwerty keyboard layout but might need adjustment
--   -- for other layouts.
--   letters = 'asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP',
--
--   -- Sets the name of unnamed buffers. By default format is "[Buffer X]"
--   -- where X is the buffer number. But only a static string is accepted here.
--   no_name_title = nil,
-- }

require('telescope').setup()
local builtin = require('telescope.builtin')
local telescope_projects = require('telescope').load_extension('projects')
vim.keymap.set('n', '<Space>pp', telescope_projects.projects, {})
vim.keymap.set('n', '<Space>ff', builtin.find_files, {})
vim.keymap.set('n', '<Space>fr', builtin.oldfiles, {})
vim.keymap.set('n', '<Space>fg', builtin.live_grep, {})
vim.keymap.set('n', '<Space>f/', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<Space>bb', builtin.buffers, {})
vim.keymap.set('n', '<Space>fh', builtin.help_tags, {})
vim.keymap.set('n', '<Space>fm', builtin.marks, {})
vim.keymap.set('n', '<Space>fq', builtin.quickfix, {})
vim.keymap.set('n', '<Space>fR', builtin.registers, {})
vim.keymap.set('n', '<Space>hk', builtin.keymaps, {})
vim.keymap.set('n', '<Space>ft', builtin.treesitter, {})

vim.keymap.set('n', '<Space>bp', '<cmd>bp<CR>')
vim.keymap.set('n', '<Space>bn', '<cmd>bn<CR>')
vim.keymap.set('n', '<Space>bl', '<cmd>b#<CR>')
vim.keymap.set('n', '<Space>rr', '<cmd>source ~/.config/nvim/init.lua<CR>', {})
vim.cmd.colorscheme('vscode')

vim.keymap.set('n', '<Space>lD', vim.lsp.buf.hover, {buffer = bufnr})
vim.keymap.set('n', '<Space>lr', vim.lsp.buf.references, {buffer = bufnr})
vim.keymap.set('n', '<Space>ld', vim.lsp.buf.implementation, {buffer = bufnr})
vim.keymap.set('n', '<Space>ll', vim.lsp.buf.code_action, {buffer = bufnr})
vim.keymap.set('n', '<Space>lf', vim.lsp.buf.format, {buffer = bufnr})
vim.keymap.set('n', '<Space>lD', vim.lsp.buf.hover, {buffer = bufnr})

-- LSP
--
require'lspconfig'.pyright.setup{}
require'lspconfig'.tsserver.setup{}
local lspconfig = require('lspconfig')
lspconfig.tsserver.setup {}
local on_attach = function(client)
    require'completion'.on_attach(client)
end
lspconfig.rust_analyzer.setup({
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }
})
require'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
require'lspconfig'.lua_ls.setup{}


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', '<space>lD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<space>ld', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<space>li', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>lt', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>lr', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>lc', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<space>lr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>lf', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

---
--Git
vim.g.lazygit_floating_window_winblend = 0 -- transparency of floating window
vim.g.lazygit_floating_window_scaling_factor = 0.9 -- scaling factor for floating window
vim.g.lazygit_floating_window_use_plenary = 0 -- use plenary.nvim to manage floating window if available
vim.g.lazygit_use_neovim_remote = 1 -- fallback to 0 if neovim-remote is not installed

vim.g.lazygit_use_custom_config_file_path = 0 -- config file path is evaluated if this value is 1
vim.g.lazygit_config_file_path = '' -- custom config file path
vim.keymap.set('n', '<space>gg', '<cmd>LazyGit<CR>', opts)


---
--Comments
--
require('Comment').setup {
    ---Add a space b/w comment and the line
    padding = true,
    ---Whether the cursor should stay at its position
    sticky = true,
    ---Lines to be ignored while (un)comment
    ignore = nil,
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
        ---Line-comment toggle keymap
        line = 'gcc',
        ---Block-comment toggle keymap
        block = 'gbc',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
        ---Line-comment keymap
        line = 'gc',
        ---Block-comment keymap
        block = 'gb',
    },
    ---LHS of extra mappings
    extra = {
        ---Add comment on the line above
        above = 'gcO',
        ---Add comment on the line below
        below = 'gco',
        ---Add comment at the end of line
        eol = 'gcA',
    },
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = true,
    },
    ---Function to call before (un)comment
    pre_hook = nil,
    ---Function to call after (un)comment
    post_hook = nil,
}

---
-- Projects
--
require("project_nvim").setup {
  -- Manual mode doesn't automatically change your root directory, so you have
  -- the option to manually do so using `:ProjectRoot` command.
  manual_mode = false,

  -- Methods of detecting the root directory. **"lsp"** uses the native neovim
  -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
  -- order matters: if one is not detected, the other is used as fallback. You
  -- can also delete or rearangne the detection methods.
  detection_methods = { "lsp", "pattern" },

  -- All the patterns used to detect root dir, when **"pattern"** is in
  -- detection_methods
  patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

  -- Table of lsp clients to ignore by name
  -- eg: { "efm", ... }
  ignore_lsp = {},

  -- Don't calculate root dir on specific directories
  -- Ex: { "~/.cargo/*", ... }
  exclude_dirs = {},

  -- Show hidden files in telescope
  show_hidden = false,

  -- When set to false, you will get a message when project.nvim changes your
  -- directory.
  silent_chdir = true,

  -- What scope to change the directory, valid options are
  -- * global (default)
  -- * tab
  -- * win
  scope_chdir = 'global',

  -- Path where project.nvim will store the project history for use in
  -- telescope
  datapath = vim.fn.stdpath("data"),
}



---
-- Terminal
--
vim.keymap.set('n', '<Space>tc', '<cmd>FloatermNew<CR>', {})
vim.keymap.set('t', '<C-Space>tc', '<cmd>FloatermNew<CR>', {})
vim.keymap.set('n', '<Space>tp', '<cmd>FloatermPrev<CR>', {})
vim.keymap.set('t', '<C-Space>tp', '<cmd>FloatermPrev<CR>', {})
vim.keymap.set('n', '<Space>tn', '<cmd>FloatermNext<CR>', {})
vim.keymap.set('t', '<C-Space>tn', '<cmd>FloatermNext<CR>', {})
vim.keymap.set('n', '<Space>tt', '<cmd>FloatermToggle<CR>', {})
vim.keymap.set('t', '<C-Space>tt', '<cmd>FloatermToggle<CR>', {})

---
-- File Browser
--
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- OR setup with some options
local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
  vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
end

-- pass to setup along with your other options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  on_attach = my_on_attach,
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
vim.keymap.set('n', '<space>fb', '<cmd>NvimTreeToggle<cr>', {})

--- Leap
-- require('leap').add_default_mappings()
--

