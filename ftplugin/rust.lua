if type(lspconfig) == 'table' then
  lspconfig.rust_analyzer.setup({
    settings = {
      ['rust-analyzer'] = {},
    },
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

-- dap = require('dap');
-- dap.adapters.delve = {
--   type = 'server',
--   port = '${port}',
--   executable = {
--     command = 'dlv',
--     args = {'dap', '-l', '127.0.0.1:${port}'},
--     -- add this if on windows, otherwise server won't open successfully
--     -- detached = false
--   }
-- }
--
-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
-- dap.configurations.rust = {
--   {
--     type = "delve",
--     name = "Debug",
--     request = "launch",
--     program = "${file}"
--   },
--   {
--     type = "delve",
--     name = "Debug test", -- configuration for debugging test files
--     request = "launch",
--     mode = "test",
--     program = "${file}"
--   },
-- works with go.mod packages and sub packages
--   {
--     type = "delve",
--     name = "Debug test (go.mod)",
--     request = "launch",
--     mode = "test",
--     program = "./${relativeFileDirname}"
--   }
-- }
print('Rust File')
