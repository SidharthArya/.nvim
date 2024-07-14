return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "jvgrootveld/telescope-zoxide" },
    cmd = "Telescope",
    keys = {
      -- disable the keymap to grep files
      { "<Space>/",  false },
      -- change a keymap
      -- { "<Space>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<Space>pp", "<cmd>Telescope zoxide list<cr>",               desc = "Projects List" },
      { "<Space>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "telescope find in current buffer" },
      { "<Space>pt", "<cmd>Telescope terms<CR>",                     desc = "telescope pick hidden term" },
    },
    opts = function()
      local z_utils = require("telescope._extensions.zoxide.utils")
      local options = {
        defaults = {

          vimgrep_arguments = {
            "rg",
            "-L",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
          prompt_prefix = "   ",
          selection_caret = "  ",
          entry_prefix = "  ",
          initial_mode = "insert",
          selection_strategy = "reset",
          sorting_strategy = "ascending",
          layout_strategy = "bottom_pane",
          layout_config = {
            horizontal = {
              prompt_position = "bottom",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.97,
            height = 0.30,
            preview_cutoff = 120,
          },
          file_sorter = require("telescope.sorters").get_fuzzy_file,
          file_ignore_patterns = { "node_modules" },
          generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
          path_display = { "truncate" },
          winblend = 0,
          border = {},
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
          set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
          file_previewer = require("telescope.previewers").vim_buffer_cat.new,
          grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
          qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
          -- Developer configurations: Not meant for general override
          buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
          mappings = {
            n = { ["q"] = require("telescope.actions").close },
          },

        },

        extensions_list = { "zoxide" },
        extensions = {
          zoxide = {
            prompt_title = "Projects",
            mappings = {
              default = {
                after_action = function(selection)
                  print("Update to (" .. selection.z_score .. ") " .. selection.path)
                end
              },
              ["<C-s>"] = {
                before_action = function(selection) print("before C-s") end,
                action = function(selection)
                  vim.cmd.edit(selection.path)
                end
              },
              -- Opens the selected entry in a new split
              ["<C-q>"] = { action = z_utils.create_basic_command("split") },
            },
          }
        },
        pickers = {
        }
      }

      return options
    end,
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
  },
  {
    "ibhagwan/fzf-lua",
    lazy = false,
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<Space>ff", function() require('fzf-lua').files({ resume = true }) end,  desc = "Find Files" },
      { "<Space>bb", function() require('fzf-lua').buffers({ resume = true }) end, desc = "Find Buffers" },
      { "<Space>ch", "<cmd>FzfLua command_history<CR>", desc = "Find Buffers" },
      { "<Space>fg", "<cmd>FzfLua live_grep<cr>",                 desc = "Live Grep" },
      { "<Space>fo", "<cmd>FzfLua oldfiles<CR>",                  desc = "telescope find oldfiles" },
      { "<Space>fh", "<cmd>FzfLua help_tags<CR>",                 desc = "telescope help page" },
      { "<Space>cm", "<cmd>FzfLua git_commits<CR>",               desc = "telescope git commits" },
      { "<Space>gt", "<cmd>FzfLua git_status<CR>",                desc = "telescope git status" },
      { "<Space>th", "<cmd>FzfLua colorscheme<CR>",                    desc = "telescope nvchad themes" },
      { "<Space>ma", "<cmd>FzfLua marks<cr>",                     desc = "Find Marks" },
      { "<Space>fj", "<cmd>FzfLua jumps<cr>",                     desc = "Find Marks" },

    },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})
    end
  }
}
