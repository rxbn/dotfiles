require("dap-go").setup()
require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
require("dapui").setup()
require("nvim-dap-virtual-text").setup()

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "⭕️", texthl = "", linehl = "", numhl = "" })

local nmap = require("rxbn.keymap").nmap

nmap({ "<leader>db", '<Cmd>lua require("dap").toggle_breakpoint()<CR>' })
nmap({ "<leader>dB", '<Cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>' })
nmap({ "<leader>dc", '<Cmd>lua require("dap").continue()<CR>' })
nmap({ "<leader>dt", '<Cmd>lua require("dap").terminate()<CR>' })
nmap({ "<leader>di", '<Cmd>lua require("dap").step_into()<CR>zz<CR>' })
nmap({ "<leader>do", '<Cmd>lua require("dap").step_over()<CR>zz<CR>' })
nmap({ "<leader>dv", '<Cmd>lua require("dap").step_out()<CR>zz<CR>' })
