if type(lspconfig) == 'table' then
  lspconfig.dartls.setup({
  on_attach = LSPCONFIG.on_attach,
  capabilities = LSPCONFIG.capabilities,
  on_init = LSPCONFIG.on_init,
  cmd = { "dart", 'language-server', '--protocol=lsp' }
})
end
print('Dart File')
