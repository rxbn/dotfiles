return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    tag = "stable",
    config = function()
      require("catppuccin").setup({
        flavour = "frappe",
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
