local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.load_extension("dap")
telescope.load_extension("fzf")

local nmap = require("rxbn.keymap").nmap

nmap({ "<leader>pf", builtin.find_files })
nmap({ "<c-p>", builtin.git_files })
nmap({
  "<leader>ps",
  function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
  end,
})
nmap({ "<leader>vh", builtin.help_tags })
nmap({ "<leader>fg", "<Cmd>Telescope live_grep<CR>" })
nmap({
  "<leader>fG",
  function()
    local opts = {
      additional_args = { "--no-ignore", "--hidden" },
    }
    builtin.live_grep(opts)
  end,
})
nmap({ "<leader>fb", "<Cmd>Telescope buffers<CR>" })
nmap({ "<leader>lb", "<Cmd>Telescope dap list_breakpoints<CR>" })
nmap({ "<leader>lt", "<Cmd>TodoTelescope<CR>" })
nmap({
  "<leader>/",
  function()
    local opts = require("telescope.themes").get_dropdown({
      height = 10,
      previewer = false,
    })
    builtin.current_buffer_fuzzy_find(opts)
  end,
})
