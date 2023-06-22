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
})

require('lualine').setup()
require('telescope').setup()
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<Space>ff', builtin.find_files, {})
vim.keymap.set('n', '<Space>fg', builtin.live_grep, {})
vim.keymap.set('n', '<Space>fb', builtin.buffers, {})
vim.keymap.set('n', '<Space>fh', builtin.help_tags, {})
vim.cmd.colorscheme('tokyonight')


-- LSP
--
vim.lsp.start({
  name = 'python-lsp',
  cmd = {'pyright'},
  root_dir = vim.fs.dirname(vim.fs.find({'setup.py', 'pyproject.toml', 'requirements.txt'}, { upward = true })[1]),
})
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    vim.keymap.set('n', 'D', vim.lsp.buf.hover, { buffer = args.buf })
  end,
})
