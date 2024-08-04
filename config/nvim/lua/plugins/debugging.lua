return {
  {
    "mfussenegger/nvim-dap",
    init = function()
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
      )
      vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
    end,
    config = function()
      local debuggers = {
        "debugpy",
        "delve",
      }
      require("rxbn.util.mason").install_packages(debuggers)
    end,
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = {
          "nvim-neotest/nvim-nio",
        },
        config = function()
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup()
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
        end,
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
      {
        "leoluz/nvim-dap-go",
        opts = {},
      },
      {
        "mfussenegger/nvim-dap-python",
        config = function()
          local debugpy_path = require("mason-core.path").concat({
            ---@diagnostic disable-next-line: assign-type-mismatch
            vim.fn.stdpath("data"),
            "mason",
            "packages",
            "debugpy",
            "venv",
            "bin",
            "python",
          })
          require("dap-python").setup(debugpy_path)
        end,
      },
      {
        "nvim-telescope/telescope-dap.nvim",
        config = function()
          require("telescope").load_extension("dap")
        end,
      },
    },
    keys = {
      { "<leader>db", '<Cmd>lua require("dap").toggle_breakpoint()<CR>' },
      { "<leader>lb", "<Cmd>Telescope dap list_breakpoints<CR>" },
      { "<leader>dB", '<Cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>' },
      { "<leader>dc", '<Cmd>lua require("dap").continue()<CR>' },
      { "<leader>dt", '<Cmd>lua require("dap").terminate()<CR>' },
      { "<leader>di", '<Cmd>lua require("dap").step_into()<CR>zz<CR>' },
      { "<leader>do", '<Cmd>lua require("dap").step_over()<CR>zz<CR>' },
      { "<leader>dv", '<Cmd>lua require("dap").step_out()<CR>zz<CR>' },
    },
  },
}
