local telescope = require("telescope")
local telescopeConfig = require("telescope.config")
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

telescope.setup({
  defaults = {
    vimgrep_arguments = vimgrep_arguments,
  },
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "--no-ignore", "--glob", "!**/.git/*", "--glob", "!**/venv/*",
        "--glob", "!**/.terraform/*", "--glob", "!**/node_modules/*", "--glob", "!**/.next/*" },
    },
  },
  extensions = {
    file_browser = {
      hijack_netrw = true,
      hidden = true,
      respect_gitignore = false,
    },
  },
})

telescope.load_extension('dap')
telescope.load_extension('file_browser')
telescope.load_extension('fzf')

local nmap = require("rxbn.keymap").nmap

nmap { '<c-p>', '<Cmd>Telescope find_files<CR>' }
nmap { '<leader>fi', '<Cmd>Telescope git_files<CR>' }
nmap { '<leader>fg', '<Cmd>Telescope live_grep<CR>' }
nmap { '<leader>fG',
  function()
    local opts = {
      additional_args = { "--no-ignore", "--hidden" }
    }
    require("telescope.builtin").live_grep(opts)
  end
}
nmap { '<leader>fh', '<Cmd>Telescope help_tags<CR>' }
nmap { '<leader>fb', '<Cmd>Telescope buffers<CR>' }
nmap { '<leader>lb', '<Cmd>Telescope dap list_breakpoints<CR>' }
nmap { '<leader>lt', '<Cmd>TodoTelescope<CR>' }
nmap { '<leader>/',
  function()
    local opts = require("telescope.themes").get_dropdown({
      height = 10,
      previewer = false,
    })
    require("telescope.builtin").current_buffer_fuzzy_find(opts)
  end
}
nmap { '<leader>ne', '<Cmd>Telescope file_browser<CR>' }
nmap { '<leader>nE',
  function()
    local opts = {
      cwd = vim.fn.expand('%:p:h'),
    }
    telescope.extensions.file_browser.file_browser(opts)
  end
}
