vim.g.vscode_snippets_path = '../../snippets/snippets';


return { {
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      "<Space>bf",
      function()
        require('conform').format({
          lsp_fallback = true,
          async = true,
          timeout_ms = 500,
        })
      end,
      desc = "Format buffer"
    },
  },
  opts = {},
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        nix = { "nixfmt" },
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        graphql = { "prettier" },
        python = { "isort", "black" }
      },
      format_on_save = {
        lsp_fallback = true,
        async = true
      }
    });
  end
},
  {
    'mfussenegger/nvim-lint',
    opts = {},
    keys = {
      {
        "<Space>be",
        function()
          require('lint').try_lint()
        end,
        desc = "Format buffer"
      },
    },
    config = function()
      local lint = require("lint");
      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        python = { "pylint" },
        lua = { "luacheck" },
      };
    end
  },
  -- {
  --     "SmiteshP/nvim-navic",
  --     lazy = false,
  --     config = function()
  --       require('nvim-navic').setup {
  --     icons = {
  --         File          = "󰈙 ",
  --         Module        = " ",
  --         Namespace     = "󰌗 ",
  --         Package       = " ",
  --         Class         = "󰌗 ",
  --         Method        = "󰆧 ",
  --         Property      = " ",
  --         Field         = " ",
  --         Constructor   = " ",
  --         Enum          = "󰕘",
  --         Interface     = "󰕘",
  --         Function      = "󰊕 ",
  --         Variable      = "󰆧 ",
  --         Constant      = "󰏿 ",
  --         String        = "󰀬 ",
  --         Number        = "󰎠 ",
  --         Boolean       = "◩ ",
  --         Array         = "󰅪 ",
  --         Object        = "󰅩 ",
  --         Key           = "󰌋 ",
  --         Null          = "󰟢 ",
  --         EnumMember    = " ",
  --         Struct        = "󰌗 ",
  --         Event         = " ",
  --         Operator      = "󰆕 ",
  --         TypeParameter = "󰊄 ",
  --     },
  --     lsp = {
  --         auto_attach = true,
  --         preference = nil,
  --     },
  --     highlight = false,
  --     separator = " > ",
  --     depth_limit = 0,
  --     depth_limit_indicator = "..",
  --     safe_output = true,
  --     lazy_update_context = false,
  --     click = false,
  --     format_text = function(text)
  --         return text
  --     end,
  -- }
  --
  --     end
  -- },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = { {
      -- snippet plugin
      "L3MON4D3/LuaSnip",
      dependencies = "rafamadriz/friendly-snippets",
      opts = {
        history = true,
        updateevents = "TextChanged,TextChangedI"
      },
      config = function(_, opts)
        require("luasnip.loaders.from_vscode").lazy_load {
          exclude = vim.g.vscode_snippets_exclude or {}
        }
        require("luasnip.loaders.from_vscode").lazy_load {
          paths = vim.g.vscode_snippets_path or ""
        }

        -- snipmate format
        require("luasnip.loaders.from_snipmate").load()
        require("luasnip.loaders.from_snipmate").lazy_load {
          paths = vim.g.snipmate_snippets_path or ""
        }

        -- lua format
        require("luasnip.loaders.from_lua").load()
        require("luasnip.loaders.from_lua").lazy_load {
          paths = vim.g.lua_snippets_path or ""
        }

        vim.api.nvim_create_autocmd("InsertLeave", {
          callback = function()
            if require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()] and
                not require("luasnip").session.jump_active then
              require("luasnip").unlink_current()
            end
          end
        })
        require("luasnip").config.set_config(opts)
      end
    }, -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" }
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end
      }, -- cmp sources plugins
      { "saadparwaiz1/cmp_luasnip", "hrsh7th/cmp-nvim-lua", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path" } },
    opts = function()
      local cmp = require "cmp"


      local cmp_ui = {
        icons = true,
        lspkind_text = true,
        style = "default", -- default/flat_light/flat_dark/atom/atom_colored
      }
      local cmp_style = cmp_ui.style

      local field_arrangement = {
        atom = { "kind", "abbr", "menu" },
        atom_colored = { "kind", "abbr", "menu" },
      }

      -- local formatting_style = {
      --   -- default fields order i.e completion word + item.kind + item.kind icons
      -- fields = field_arrangement[cmp_style] or { "abbr", "kind", "menu" },
      --
      -- format = function(_, item)
      --   local icons = require "nvchad.icons.lspkind"
      --   local icon = (cmp_ui.icons and icons[item.kind]) or ""
      --
      --   if cmp_style == "atom" or cmp_style == "atom_colored" then
      --     icon = " " .. icon .. " "
      --     item.menu = cmp_ui.lspkind_text and "   (" .. item.kind .. ")" or ""
      --     item.kind = icon
      --   else
      --     icon = cmp_ui.lspkind_text and (" " .. icon .. " ") or icon
      --     item.kind = string.format("%s %s", icon, cmp_ui.lspkind_text and item.kind or "")
      --   end
      --
      --   return item
      -- end,
      -- }

      local function border(hl_name)
        return {
          { "╭", hl_name },
          { "─", hl_name },
          { "╮", hl_name },
          { "│", hl_name },
          { "╯", hl_name },
          { "─", hl_name },
          { "╰", hl_name },
          { "│", hl_name },
        }
      end

      local options = {
        completion = {
          completeopt = "menu,menuone",
        },

        window = {
          completion = {
            side_padding = (cmp_style ~= "atom" and cmp_style ~= "atom_colored") and 1 or 0,
            winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
            scrollbar = false,
          },
          documentation = {
            border = border "CmpDocBorder",
            winhighlight = "Normal:CmpDoc",
          },
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },

        -- formatting = formatting_style,
        --
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),

          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "nvim_lua" },
          { name = "path" },
        },
      }

      if cmp_style ~= "atom" and cmp_style ~= "atom_colored" then
        options.window.completion.border = border "CmpBorder"
      end

      return options
    end,
    config = function(_, opts)
      require("cmp").setup(opts)
    end
  }, {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
  opts = function()
    return {
      ensure_installed = { "lua", "luadoc", "printf", "vim", "vimdoc" },

      highlight = {
        enable = true,
        use_languagetree = true
      },

      indent = {
        enable = true
      }
    }
  end,
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end
},
  {
    'MeanderingProgrammer/markdown.nvim',
    main = "render-markdown",
    opts = {},
    name = 'render-markdown',
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    config = function()
      require('render-markdown').setup({
        heading = {
          -- Turn on / off heading icon & background rendering
          enabled = true,
          -- Turn on / off any sign column related rendering
          sign = true,
          -- Replaces '#+' of 'atx_h._marker'
          -- The number of '#' in the heading determines the 'level'
          -- The 'level' is used to index into the array using a cycle
          -- The result is left padded with spaces to hide any additional '#'
          icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
          -- Added to the sign column if enabled
          -- The 'level' is used to index into the array using a cycle
          signs = { '󰫎 ' },
          -- Width of the heading background:
          --  block: width of the heading text
          --  full: full width of the window
          width = 'full',
          -- The 'level' is used to index into the array using a clamp
          -- Highlight for the heading icon and extends through the entire line
          backgrounds = {
            'RenderMarkdownH1Bg',
            'RenderMarkdownH2Bg',
            'RenderMarkdownH3Bg',
            'RenderMarkdownH4Bg',
            'RenderMarkdownH5Bg',
            'RenderMarkdownH6Bg',
          },
          -- The 'level' is used to index into the array using a clamp
          -- Highlight for the heading and sign icons
          foregrounds = {
            'RenderMarkdownH1',
            'RenderMarkdownH2',
            'RenderMarkdownH3',
            'RenderMarkdownH4',
            'RenderMarkdownH5',
            'RenderMarkdownH6',
          },
        },
        code = {
          -- Turn on / off code block & inline code rendering
          enabled = true,
          -- Turn on / off any sign column related rendering
          sign = true,
          -- Determines how code blocks & inline code are rendered:
          --  none: disables all rendering
          --  normal: adds highlight group to code blocks & inline code, adds padding to code blocks
          --  language: adds language icon to sign column if enabled and icon + name above code blocks
          --  full: normal + language
          style = 'full',
          -- Amount of padding to add to the left of code blocks
          left_pad = 0,
          -- Amount of padding to add to the right of code blocks when width is 'block'
          right_pad = 0,
          -- Width of the code block background:
          --  block: width of the code block
          --  full: full width of the window
          width = 'full',
          -- Determins how the top / bottom of code block are rendered:
          --  thick: use the same highlight as the code body
          --  thin: when lines are empty overlay the above & below icons
          border = 'thin',
          -- Used above code blocks for thin border
          above = '▄',
          -- Used below code blocks for thin border
          below = '▀',
          -- Highlight for code blocks & inline code
          highlight = 'RenderMarkdownCode',
          highlight_inline = 'RenderMarkdownCodeInline',
        },
        dash = {
          -- Turn on / off thematic break rendering
          enabled = true,
          -- Replaces '---'|'***'|'___'|'* * *' of 'thematic_break'
          -- The icon gets repeated across the window's width
          icon = '─',
          -- Width of the generated line:
          --  <integer>: a hard coded width value
          --  full: full width of the window
          width = 'full',
          -- Highlight for the whole line generated from the icon
          highlight = 'RenderMarkdownDash',
        },
        bullet = {
          -- Turn on / off list bullet rendering
          enabled = true,
          -- Replaces '-'|'+'|'*' of 'list_item'
          -- How deeply nested the list is determines the 'level'
          -- The 'level' is used to index into the array using a cycle
          -- If the item is a 'checkbox' a conceal is used to hide the bullet instead
          icons = { '●', '○', '◆', '◇' },
          -- Padding to add to the right of bullet point
          right_pad = 0,
          -- Highlight for the bullet icon
          highlight = 'RenderMarkdownBullet',
        },
        checkbox = {
          -- Turn on / off checkbox state rendering
          enabled = true,
          unchecked = {
            -- Replaces '[ ]' of 'task_list_marker_unchecked'
            icon = '󰄱 ',
            -- Highlight for the unchecked icon
            highlight = 'RenderMarkdownUnchecked',
          },
          checked = {
            -- Replaces '[x]' of 'task_list_marker_checked'
            icon = '󰱒 ',
            -- Highligh for the checked icon
            highlight = 'RenderMarkdownChecked',
          },
          -- Define custom checkbox states, more involved as they are not part of the markdown grammar
          -- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks
          -- Can specify as many additional states as you like following the 'todo' pattern below
          --   The key in this case 'todo' is for healthcheck and to allow users to change its values
          --   'raw': Matched against the raw text of a 'shortcut_link'
          --   'rendered': Replaces the 'raw' value when rendering
          --   'highlight': Highlight for the 'rendered' icon
          custom = {
            todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo' },
          },
        },
        pipe_table = {
          -- Turn on / off pipe table rendering
          enabled = true,
          -- Determines how the table as a whole is rendered:
          --  none: disables all rendering
          --  normal: applies the 'cell' style rendering to each row of the table
          --  full: normal + a top & bottom line that fill out the table when lengths match
          style = 'full',
          -- Determines how individual cells of a table are rendered:
          --  overlay: writes completely over the table, removing conceal behavior and highlights
          --  raw: replaces only the '|' characters in each row, leaving the cells unmodified
          --  padded: raw + cells are padded with inline extmarks to make up for any concealed text
          cell = 'padded',
          -- Gets placed in delimiter row for each column, position is based on alignmnet
          alignment_indicator = '━',
          -- Characters used to replace table border
          -- Correspond to top(3), delimiter(3), bottom(3), vertical, & horizontal
          -- stylua: ignore
          border = {
            '┌', '┬', '┐',
            '├', '┼', '┤',
            '└', '┴', '┘',
            '│', '─',
          },
          -- Highlight for table heading, delimiter, and the line above
          head = 'RenderMarkdownTableHead',
          -- Highlight for everything else, main table rows and the line below
          row = 'RenderMarkdownTableRow',
          -- Highlight for inline padding used to add back concealed space
          filler = 'RenderMarkdownTableFill',
        },
        callout = {
          note = { raw = '[!NOTE]', rendered = '󰋽 Note', highlight = 'RenderMarkdownInfo' },
          tip = { raw = '[!TIP]', rendered = '󰌶 Tip', highlight = 'RenderMarkdownSuccess' },
          important = { raw = '[!IMPORTANT]', rendered = '󰅾 Important', highlight = 'RenderMarkdownHint' },
          warning = { raw = '[!WARNING]', rendered = '󰀪 Warning', highlight = 'RenderMarkdownWarn' },
          caution = { raw = '[!CAUTION]', rendered = '󰳦 Caution', highlight = 'RenderMarkdownError' },
          -- Obsidian: https://help.a.md/Editing+and+formatting/Callouts
          abstract = { raw = '[!ABSTRACT]', rendered = '󰨸 Abstract', highlight = 'RenderMarkdownInfo' },
          todo = { raw = '[!TODO]', rendered = '󰗡 Todo', highlight = 'RenderMarkdownInfo' },
          success = { raw = '[!SUCCESS]', rendered = '󰄬 Success', highlight = 'RenderMarkdownSuccess' },
          question = { raw = '[!QUESTION]', rendered = '󰘥 Question', highlight = 'RenderMarkdownWarn' },
          failure = { raw = '[!FAILURE]', rendered = '󰅖 Failure', highlight = 'RenderMarkdownError' },
          danger = { raw = '[!DANGER]', rendered = '󱐌 Danger', highlight = 'RenderMarkdownError' },
          bug = { raw = '[!BUG]', rendered = '󰨰 Bug', highlight = 'RenderMarkdownError' },
          example = { raw = '[!EXAMPLE]', rendered = '󰉹 Example', highlight = 'RenderMarkdownHint' },
          quote = { raw = '[!QUOTE]', rendered = '󱆨 Quote', highlight = 'RenderMarkdownQuote' },
        },
        link = {
          -- Turn on / off inline link icon rendering
          enabled = true,
          -- Inlined with 'image' elements
          image = '󰥶 ',
          -- Inlined with 'inline_link' elements
          hyperlink = '󰌹 ',
          -- Applies to the inlined icon
          highlight = 'RenderMarkdownLink',
        },
        sign = {
          -- Turn on / off sign rendering
          enabled = true,
          -- More granular mechanism, disable signs within specific buftypes
          exclude = {
            buftypes = { 'nofile' },
          },
          -- Applies to background of sign text
          highlight = 'RenderMarkdownSign',
        },
      })
    end
  }

}
