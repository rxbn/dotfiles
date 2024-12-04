return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-treesitter",
    },
    config = function()
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("yaml_schema")
    end,
    keys = {
      { "<leader>pf", "<Cmd>Telescope find_files<CR>" },
      { "<c-p>", "<Cmd>Telescope git_files<CR>" },
      {
        "<leader>ps",
        function()
          require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
        end,
      },
      {
        "<leader>pws",
        function()
          local word = vim.fn.expand("<cword>")
          require("telescope.builtin").grep_string({ search = word })
        end,
      },
      {
        "<leader>pWs",
        function()
          local word = vim.fn.expand("<cWORD>")
          require("telescope.builtin").grep_string({ search = word })
        end,
      },
      { "<leader>vh", "<Cmd>Telescope help_tags<CR>" },
      { "<leader>fg", "<Cmd>Telescope live_grep<CR>" },
      {
        "<leader>fG",
        function()
          local opts = {
            prompt_title = "Live Grep (All Files)",
            additional_args = { "--no-ignore", "--hidden" },
          }
          require("telescope.builtin").live_grep(opts)
        end,
      },
      { "<leader>fb", "<Cmd>Telescope buffers<CR>" },
      {
        "<leader>/",
        function()
          local opts = require("telescope.themes").get_dropdown({
            height = 10,
            previewer = false,
          })
          require("telescope.builtin").current_buffer_fuzzy_find(opts)
        end,
      },
      { "<leader>fy", "<Cmd>Telescope yaml_schema<CR>" },
    },
  },
}
