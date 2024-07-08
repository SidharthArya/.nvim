
keymapper = vim.api.nvim_set_keymap
map = vim.keymap.set
-- map the leader key
local options = { noremap = true }

keymapper('n', '<Space><esc>', ':nohlsearch<cr>', options)
keymapper('n', '<Space>bn', ':bnext<cr>', options)
keymapper('n', '<Space>bp', ':bprev<cr>', options)
keymapper('n', '<Space>bl', ':b#<cr>', options)
keymapper('n', '<Space>bd', ':bdel<cr>', options)


map("n", "<Space>fn", function()
return ":e " .. vim.fn.expand('%:h')
end, { desc = "new file in same directory", expr = true })

map("n", "<Space>dn", function()
return ":!mkdir " .. vim.fn.expand('%:h')
end, { desc = "new directory in same folder", expr = true })


map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "file save" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "file copy whole" })

map("n", "<Space>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<Space>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
map("n", "<Space>ch", "<cmd>NvCheatsheet<CR>", { desc = "toggle nvcheatsheet" })

map("n", "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "format files" })

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "lsp diagnostic loclist" })

-- tabufline
map("n", "<Space>bn", "<cmd>enew<CR>", { desc = "buffer new" })

-- map("n", "<tab>", function()
--   require("nvchad.tabufline").next()
-- end, { desc = "buffer goto next" })

-- map("n", "<S-tab>", function()
--   require("nvchad.tabufline").prev()
-- end, { desc = "buffer goto prev" })
--
-- map("n", "<leader>x", function()
--   require("nvchad.tabufline").close_buffer()
-- end, { desc = "buffer close" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "comment toggle", remap = true })
map("v", "<leader>/", "gc", { desc = "comment toggle", remap = true })

-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })

-- telescope
-- map("n", "<Space>ff", "<cmd>Telescope find_files<cr>", { desc = "telescope find files" })
map(
  "n",
  "<Space>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "telescope find all files" }
)

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- new terminals
-- map("n", "<leader>h", function()
--   require("nvchad.term").new { pos = "sp" }
-- end, { desc = "terminal new horizontal term" })
--
-- map("n", "<leader>v", function()
--   require("nvchad.term").new { pos = "vsp" }
-- end, { desc = "terminal new vertical window" })
--
-- -- toggleable
-- map({ "n", "t" }, "<A-v>", function()
--   require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
-- end, { desc = "terminal toggleable vertical term" })
--
-- map({ "n", "t" }, "<A-h>", function()
--   require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
-- end, { desc = "terminal new horizontal term" })
--
-- map({ "n", "t" }, "<A-i>", function()
--   require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
-- end, { desc = "terminal toggle floating term" })
--
-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "whichkey all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "whichkey query lookup" })

-- blankline
map("n", "<leader>cc", function()
  local config = { scope = {} }
  config.scope.exclude = { language = {}, node_type = {} }
  config.scope.include = { node_type = {} }
  local node = require("ibl.scope").get(vim.api.nvim_get_current_buf(), config)

  if node then
    local start_row, _, end_row, _ = node:range()
    if start_row ~= end_row then
      vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start_row + 1, 0 })
      vim.api.nvim_feedkeys("_", "n", true)
    end
  end
end, { desc = "blankline jump to current context" })
