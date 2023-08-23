return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "catppuccin",
      },
      sections = {
        lualine_c = { "buffers" },
      },
    },
  },
}
