return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text"

    },
    keys = {
      { "<Space>dd", function() dap.toggle_breakpoint() end,  desc = "Toggle Breakpoint" },
      { "<Space>db", function() dap.toggle_breakpoint() end,  desc = "Toggle Breakpoint" },
      { "<Space>dc", function() dap.continue() end,           desc = "DAP Continue" },
      { "<Space>dn", function() dap.step_into() end,          desc = "DAP Step Into" },
      { "<Space>dS", function() dap.step_over() end,          desc = "DAP Step Over" },
      { "<Space>dt", function() dap.terminate() end,          desc = "DAP Step Over" },
      { "<Space>dr", function() dap.repl.open() end,          desc = "DAP REPL" }
    },
    config = function()
      dap = require("dap")
      require("nvim-dap-virtual-text").setup()
      require("dapui").setup()
      local dapui = require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end

  }
}
