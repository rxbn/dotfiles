return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "catppuccin-nvim",
      },
      sections = {
        lualine_c = {
          {
            "filename",
            path = 1,
          },
        },
        lualine_x = { "filetype" },
      },
    },
  },
}
