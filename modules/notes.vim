Plug 'mickael-menu/zk-nvim'
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
call plug#end()

lua << END
local home = vim.fn.expand("~/Documents/Zettel")
require("zk").setup({
  picker = "telescope",
  -- notebook_path = home .. "/work",
  lsp = {
    config = {
      cmd = { "zk", "lsp" },
      name = "zk",
    },
    auto_attach = {
      enabled = true,
      filetypes = { "markdown" },
    },
  },
})
require("telescope").load_extension("zk")
local opts = { noremap=true, silent=false}

-- Create a new note after asking for its title.
vim.api.nvim_set_keymap("n", "<leader>nc", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)

-- Open notes.
vim.api.nvim_set_keymap("n", "<leader>nn", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)
-- Open notes associated with the selected tags.
vim.api.nvim_set_keymap("n", "<leader>nt", "<Cmd>ZkTags<CR>", opts)

-- Search for the notes matching a given query.
-- vim.api.nvim_set_keymap("n", "<leader>nf", "<Cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>", opts)
-- Search for the notes matching the current visual selection.
-- vim.api.nvim_set_keymap("v", "<leader>zf", ":'<,'>ZkMatch<CR>", opts)
END

nnoremap <leader>now :let $ZK_NOTEBOOK_DIR="/home/arya/Documents/Zettel/work"<CR>
nnoremap <leader>nop :let $ZK_NOTEBOOK_DIR="/home/arya/Documents/Zettel/personal"<CR>
nnoremap <leader>nod :let $ZK_NOTEBOOK_DIR="/home/arya/Documents/Zettel/braindump"<CR>
nnoremap <leader>nob :let $ZK_NOTEBOOK_DIR="/home/arya/Documents/Zettel/blog"<CR>
" nnoremap <leader>nod :let $ZK_NOTEBOOK_DIR="/home/arya/Documents/Zettel/daily"<CR>
