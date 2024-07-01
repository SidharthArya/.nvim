local M = {}
local masonames = require "modules.mason.names"
-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has "win32" ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH


local get_pkgs = function(data)
  local tools = data or {}

  local lsps = require("lspconfig.util").available_servers()
  tools = vim.list_extend(tools, lsps)

  local conform_exists, conform = pcall(require, "conform")

  if conform_exists then
    local formatters = conform.list_all_formatters()

    local formatters_names = vim.tbl_map(function(formatter)
      return formatter.name
    end, formatters)

    tools = vim.list_extend(tools, formatters_names)
  end

  local lint_exists, lint = pcall(require, "lint")

  if lint_exists then
    local linters = lint.linters_by_ft

    for _, v in pairs(linters) do
      table.insert(tools, v[1])
    end
  end

  -- rm duplicates
  local pkgs = {}

  for _, v in pairs(tools) do
    if not (vim.tbl_contains(pkgs, masonames[v])) then
      table.insert(pkgs, masonames[v])
    end
  end

  return pkgs
end

M.install_all = function(data)
  vim.cmd "Mason"

  local mr = require "mason-registry"

  mr.refresh(function()
    for _, tool in ipairs(get_pkgs(data)) do
      local p = mr.get_package(tool)

      if not p:is_installed() then
        p:install()
      end
    end
  end)
end

return {
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
        opts = function()
          return {
            PATH = "skip",
          
            ui = {
              icons = {
                package_pending = " ",
                package_installed = "󰄳 ",
                package_uninstalled = " 󰚌",
              },
          
              keymaps = {
                toggle_server_expand = "<CR>",
                install_server = "i",
                update_server = "u",
                check_server_version = "c",
                update_all_servers = "U",
                check_outdated_servers = "C",
                uninstall_server = "X",
                cancel_installation = "<C-c>",
              },
            },
          
            max_concurrent_installers = 10,
          }
        end,
        config = function(_, opts)
          require("mason").setup(opts)

      vim.api.nvim_create_user_command("MasonInstallAll", function()
        M.install_all(opts.ensure_installed)
      end, {})
    
    
        end,
      },
      {"williamboman/mason-lspconfig.nvim",
      config = function ()
    require('mason-lspconfig').setup()
    require('mason-lspconfig').setup_handlers({
        function(server)
          lspconfig[server].setup({})
        end,})
      end
    }
}