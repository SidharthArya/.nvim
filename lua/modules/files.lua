return {
-- 	{'junegunn/fzf.vim',
-- 	dependencies = {'ahmedkhalf/project.nvim'},
-- 	config = function()
-- 		keymapper('n', '<Space>ff', ':Files<CR>', {noremap=true})
-- 		keymapper('n', '<Space>fr', ':History<CR>', {noremap=true})
-- 		keymapper('n', '<Space>ch', ':History:<CR>', {noremap=true})
-- 		keymapper('n', '<Space>sn', ':Snippets<CR>', {noremap=true})
-- 		keymapper('n', '<Space>bb', ':Buffers<CR>', {noremap=true})
-- 		keymapper('n', '<Space>fg', ':RG<CR>', {noremap=true})
-- 		keymapper('n', '<Space>ma', ':Marks<CR>', {noremap=true})
-- 		keymapper('n', '<Space>ju', ':Jumps<CR>', {noremap=true})
-- 		keymapper('n', '<C-s><C-s>', ':Lines<CR>', {noremap=true})
-- 		keymapper('i', '<C-s><C-s>', ':Lines<CR>', {noremap=true})
-- 		keymapper('n', '<C-s>', ':BLines<CR>', {noremap=true})
-- 		keymapper('i', '<C-s>', ':BLines<CR>', {noremap=true})
-- 	end
-- },
{
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
		return {
			filters = {
			  dotfiles = false,
			},
			disable_netrw = true,
			hijack_netrw = true,
			hijack_cursor = true,
			hijack_unnamed_buffer_when_opening = false,
			sync_root_with_cwd = true,
			update_focused_file = {
			  enable = true,
			  update_root = false,
			},
			view = {
			  adaptive_size = false,
			  side = "left",
			  width = 30,
			  preserve_window_proportions = true,
			},
			git = {
			  enable = true,
			  ignore = true,
			},
			filesystem_watchers = {
			  enable = true,
			},
			actions = {
			  open_file = {
				resize_window = true,
			  },
			},
			renderer = {
			  root_folder_label = false,
			  highlight_git = true,
			  highlight_opened_files = "none",
		  
			  indent_markers = {
				enable = true,
			  },
		  
			  icons = {
				show = {
				  file = true,
				  folder = true,
				  folder_arrow = true,
				  git = true,
				},
		  
				glyphs = {
				  default = "󰈚",
				  symlink = "",
				  folder = {
					default = "",
					empty = "",
					empty_open = "",
					open = "",
					symlink = "",
					symlink_open = "",
					arrow_open = "",
					arrow_closed = "",
				  },
				  git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				  },
				},
			  },
			}
		}

    end,
    config = function(_, opts)
      require("nvim-tree").setup(opts)
    end,
  },
}