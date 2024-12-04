return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    tag = "stable",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        integrations = {
          fidget = true,
          harpoon = true,
          mason = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
