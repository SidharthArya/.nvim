if type(lspconfig) == 'table' then
  lspconfig.biome.setup({
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

dap = require('dap')

if type(dap) == 'table' then
  dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = "node",
      args = {"/home/arya/.local/share/nvim/js-debug/src/dapDebugServer.js", "${port}"}
    }
  }
  dap.configurations.javascript = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch File",
      program = "${file}",
      cwd = "${workspaceFolder}"
    }
  }
end

print('Typescript File')
