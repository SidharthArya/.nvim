return { {
  "nvimdev/dashboard-nvim",
  config = function()
    require('dashboard').setup({
      theme = 'hyper',
      config = {
        week_header = {
          enable = true,
        },
        shortcut = {
          { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = 'Label',
            action = 'FzfLua files',
            key = 'f',
          },
          {
            desc = ' Apps',
            group = 'DiagnosticHint',
            action = 'Telescope app',
            key = 'a',
          },
          {
            desc = ' dotfiles',
            group = 'Number',
            action = 'FzfLua files cwd=~/.config/nvim',
            key = 'd',
          },
        },
        project = { enable = true, limit = 8, icon = ' ', label = 'Projects', action = 'FzfLua files cwd=' },
        mru = { limit = 10, icon = ' ', label = 'Files', cwd_only = false },


      },
    })
  end,
  dependencies = { 'nvim-tree/nvim-web-devicons' }
} }
