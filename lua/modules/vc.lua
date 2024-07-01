return {
	{'kdheepak/lazygit.nvim',
	dependencies = {"nvim-lua/plenary.nvim"},
	-- cond = pckr_keys('n', '<Space>gg'),
	config = function()
		vim.api.nvim_set_keymap('n', '<Space>gg', '<cmd>LazyGit<CR>', {noremap=true})
	end
},
{
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
      return {
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "󰍵" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "│" },
        },
      
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
      
          local function opts(desc)
            return { buffer = bufnr, desc = desc }
          end
      
          local map = vim.keymap.set
      
          map("n", "<leader>rh", gs.reset_hunk, opts "Reset Hunk")
          map("n", "<leader>ph", gs.preview_hunk, opts "Preview Hunk")
          map("n", "<leader>gb", gs.blame_line, opts "Blame Line")
        end,
      }
    end,
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },
}
