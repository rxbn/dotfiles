return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gs", "<Cmd>Git<CR>" },
      { "<leader>ga", "<Cmd>Git add --all<CR>" },
      { "<leader>gc", "<Cmd>Git commit<CR>" },
      { "<leader>gC", "<Cmd>Git commit --amend<CR>" },
      { "<leader>gp", "<Cmd>Git push<CR>" },
      { "<leader>gP", "<Cmd>Git pull<CR>" },
      {
        "<leader>gb",
        function()
          vim.cmd("Git switch -c " .. vim.fn.input("New branch name: "))
        end,
      },
      {
        "<leader>gB",
        function()
          vim.cmd("Git switch " .. vim.fn.input("Existing branch name: "))
        end,
      },
    },
  },
}
