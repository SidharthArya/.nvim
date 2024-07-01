local function lspSymbol(name, icon)
    local hl = "DiagnosticSign" .. name
    vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
  end
  
  lspSymbol("Error", "󰅙")
  lspSymbol("Info", "󰋼")
  lspSymbol("Hint", "󰌵")
  lspSymbol("Warn", "")
  
  vim.diagnostic.config {
    virtual_text = {
      prefix = "",
    },
    signs = true,
    underline = true,
    -- update_in_insert = false,
  
    float = {
      border = "single",
    },
  }
  
--   --  LspInfo window borders
--   local win = require "lspconfig.ui.windows"
--   local _default_opts = win.default_opts
  
--   win.default_opts = function(options)
--     local opts = _default_opts(options)
--     opts.border = "single"
--     return opts
--   end

  return {
    {
      "neovim/nvim-lspconfig",
      event = "User FilePost",
      config = function()
        LSPCONFIG = {}
  local map = vim.keymap.set
  
  -- export on_attach & capabilities
  LSPCONFIG.on_attach = function(_, bufnr)
    local function opts(desc)
      return { buffer = bufnr, desc = "LSP " .. desc }
    end
  
    map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
    map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
    map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
    map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
  
    map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts "List workspace folders")
  
    map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
  
    map("n", "<leader>ra", function()
      require "modules.lsp.renamer"()
    end, opts "NvRenamer")
  
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
    map("n", "gr", vim.lsp.buf.references, opts "Show references")
  end
  
  -- disable semanticTokens
  LSPCONFIG.on_init = function(client, _)
    if client.supports_method "textDocument/semanticTokens" then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end
  
  LSPCONFIG.capabilities = vim.lsp.protocol.make_client_capabilities()
  
  LSPCONFIG.capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      },
    },
  }
  
  LSPCONFIG.defaults = function()
    -- require "modules.lsp"
    lspconfig = require("lspconfig")
  end
  
  return LSPCONFIG.defaults()
      end,
    },
  }
  
