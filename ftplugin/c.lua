if type(lspconfig) == 'table' then
  lspconfig.clangd.setup({
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

dap = require('dap');
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode', -- adjust as needed, must be absolute path
  name = 'lldb'
}
dap.adapters.codelldb = {
  type = 'server',
  port = '${port}',
  executable = {
    command = "$HOME/.local/share/nvim/mason/bin/codelldb",
    args = { '--port', '${port}' },
  }
}

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
--
--
dap.configurations.c = {
  {
    name = 'Launch',
    type = 'codelldb',
    request = 'launch',
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
  },
}
