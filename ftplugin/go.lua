if type(lspconfig) == 'table' then
  lspconfig.gopls.setup({
  on_attach = LSPCONFIG.on_attach,
  capabilities = LSPCONFIG.capabilities,
  on_init = LSPCONFIG.on_init,
})
--   lspconfig.astro.setup({
--   on_attach = LSPCONFIG.on_attach,
--   capabilities = LSPCONFIG.capabilities,
--   on_init = LSPCONFIG.on_init,
-- })
end
print('Go File')
