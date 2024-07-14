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
    "SmiteshP/nvim-navbuddy",
    dependencies = {
        "neovim/nvim-lspconfig",
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim",
        "numToStr/Comment.nvim",
        "nvim-telescope/telescope.nvim" -- Optional
    },
    keys = {
      {"<Space>ln", "<cmd>Navbuddy<CR>", desc="Navbuddy"}
    },
    config = function()
      local navbuddy = require("nvim-navbuddy")
local actions = require("nvim-navbuddy.actions")

navbuddy.setup {
    window = {
        border = "single",  -- "rounded", "double", "solid", "none"
                            -- or an array with eight chars building up the border in a clockwise fashion
                            -- starting with the top-left corner. eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
        size = "60%",       -- Or table format example: { height = "40%", width = "100%"}
        position = "50%",   -- Or table format example: { row = "100%", col = "0%"}
        scrolloff = nil,    -- scrolloff value within navbuddy window
        sections = {
            left = {
                size = "20%",
                border = nil, -- You can set border style for each section individually as well.
            },
            mid = {
                size = "40%",
                border = nil,
            },
            right = {
                -- No size option for right most section. It fills to
                -- remaining area.
                border = nil,
                preview = "leaf",  -- Right section can show previews too.
                                   -- Options: "leaf", "always" or "never"
            }
        },
    },
    node_markers = {
        enabled = true,
        icons = {
            leaf = "  ",
            leaf_selected = " → ",
            branch = " ",
        },
    },
    icons = {
        File          = "󰈙 ",
        Module        = " ",
        Namespace     = "󰌗 ",
        Package       = " ",
        Class         = "󰌗 ",
        Method        = "󰆧 ",
        Property      = " ",
        Field         = " ",
        Constructor   = " ",
        Enum          = "󰕘",
        Interface     = "󰕘",
        Function      = "󰊕 ",
        Variable      = "󰆧 ",
        Constant      = "󰏿 ",
        String        = " ",
        Number        = "󰎠 ",
        Boolean       = "◩ ",
        Array         = "󰅪 ",
        Object        = "󰅩 ",
        Key           = "󰌋 ",
        Null          = "󰟢 ",
        EnumMember    = " ",
        Struct        = "󰌗 ",
        Event         = " ",
        Operator      = "󰆕 ",
        TypeParameter = "󰊄 ",
    },
    use_default_mappings = true,            -- If set to false, only mappings set
                                            -- by user are set. Else default
                                            -- mappings are used for keys
                                            -- that are not set by user
    mappings = {
        ["<esc>"] = actions.close(),        -- Close and cursor to original location
        ["q"] = actions.close(),

        ["j"] = actions.next_sibling(),     -- down
        ["k"] = actions.previous_sibling(), -- up

        ["h"] = actions.parent(),           -- Move to left panel
        ["l"] = actions.children(),         -- Move to right panel
        ["0"] = actions.root(),             -- Move to first panel

        ["v"] = actions.visual_name(),      -- Visual selection of name
        ["V"] = actions.visual_scope(),     -- Visual selection of scope

        ["y"] = actions.yank_name(),        -- Yank the name to system clipboard "+
        ["Y"] = actions.yank_scope(),       -- Yank the scope to system clipboard "+

        ["i"] = actions.insert_name(),      -- Insert at start of name
        ["I"] = actions.insert_scope(),     -- Insert at start of scope

        ["a"] = actions.append_name(),      -- Insert at end of name
        ["A"] = actions.append_scope(),     -- Insert at end of scope

        ["r"] = actions.rename(),           -- Rename currently focused symbol

        ["d"] = actions.delete(),           -- Delete scope

        ["f"] = actions.fold_create(),      -- Create fold of current scope
        ["F"] = actions.fold_delete(),      -- Delete fold of current scope

        ["c"] = actions.comment(),          -- Comment out current scope

        ["<enter>"] = actions.select(),     -- Goto selected symbol
        ["o"] = actions.select(),

        ["J"] = actions.move_down(),        -- Move focused node down
        ["K"] = actions.move_up(),          -- Move focused node up

        ["s"] = actions.toggle_preview(),   -- Show preview of current node

        ["<C-v>"] = actions.vsplit(),       -- Open selected node in a vertical split
        ["<C-s>"] = actions.hsplit(),       -- Open selected node in a horizontal split

        ["t"] = actions.telescope({         -- Fuzzy finder at current level.
            layout_config = {               -- All options that can be
                height = 0.60,              -- passed to telescope.nvim's
                width = 0.60,               -- default can be passed here.
                prompt_position = "top",
                preview_width = 0.50
            },
            layout_strategy = "horizontal"
        }),

        ["g?"] = actions.help(),            -- Open mappings help window
    },
    lsp = {
        auto_attach = true,   -- If set to true, you don't need to manually use attach function
        preference = nil,      -- list of lsp server names in order of preference
    },
    source_buffer = {
        follow_node = true,    -- Keep the current node in focus on the source buffer
        highlight = true,      -- Highlight the currently focused node
        reorient = "smart",    -- "smart", "top", "mid" or "none"
        scrolloff = nil        -- scrolloff value when navbuddy is open
    },
	custom_hl_group = nil,     -- "Visual" or any other hl group to use instead of inverted colors
}
    end
},
  {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    keys = {
      { "<Space>lf",  "<cmd>lua vim.lsp.buf.format()<CR>",     desc = 'Format File' },
      { "<Space>ld",  "<cmd>FzfLua lsp_definitions<CR>",       desc = 'LSP Definitions' },
      { "<Space>lD",  "<cmd>FzfLua lsp_declarations<CR>",      desc = 'LSP Declarations' },
      { "<Space>lr",  "<cmd>FzfLua lsp_references<CR>",        desc = 'LSP References' },
      { "<Space>lo",  "<cmd>FzfLua lsp_document_symbols<CR>",  desc = 'LSP Document Symbols' },
      { "<Space>lwo", "<cmd>FzfLua lsp_workspace_symbols<CR>", desc = 'LSP Document Symbols' },
      { "<Space>lo",  "<cmd>FzfLua lsp_implementations<CR>",   desc = 'LSP Implementations' },
      { "<Space>lc",  "<cmd>FzfLua lsp_outgoing_calls<CR>",    desc = 'LSP Implementations' },
      { "<Space>lF",  "<cmd>FzfLua lsp_finder<CR>",            desc = 'LSP Find' },
    },
    config = function()
      LSPCONFIG = {}
      local map = vim.keymap.set

      -- export on_attach & capabilities
      LSPCONFIG.on_attach = function(client, bufnr)
        if client.server_capabilities.documentSymbolProvider then
          require('nvim-naivic').attach(client, bufnr)
          require('nvim-navbuddy').attach(client, bufnr)
        end
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
          require "modules.lsp.renamer" ()
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
