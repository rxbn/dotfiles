return {
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTelescope" },
    event = {
      "BufReadPost",
      "BufNewFile",
    },
    config = true,
    keys = {
      { "<leader>lt", "<Cmd>TodoTelescope<CR>" },
    },
  },
}
