if type(lspconfig) == 'table' then
  lspconfig.jdtls.setup({
  on_attach = LSPCONFIG.on_attach,
  capabilities = LSPCONFIG.capabilities,
  on_init = LSPCONFIG.on_init,
})
end
print('Python File')
