return {
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    keys = {
      { "<leader>lt", "<Cmd>TodoTelescope<CR>" },
    },
  },
}
