require'lspconfig'.pyright.setup{}
vim.lsp.start({
  name = 'python',
  cmd = {'pyright'},
  root_dir = vim.fs.dirname(vim.fs.find({'setup.py', 'pyproject.toml', 'main.py'}, { upward = true })[1]),
})

