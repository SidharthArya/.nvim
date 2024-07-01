if type(lspconfig) == 'table' then
      lspconfig.lua_ls.setup {
      on_attach = LSPCONFIG.on_attach,
      capabilities = LSPCONFIG.capabilities,
      on_init = LSPCONFIG.on_init,
  
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              vim.fn.expand "$VIMRUNTIME/lua",
              vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
            --   vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
              vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
            },
            maxPreload = 100000,
            preloadFileSize = 10000,
          },
        },
      },
    }

end
print('Lua File')
