return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "frappe",
        integrations = {
          harpoon = true,
          lsp_saga = true,
          mason = true,
          treesitter = true,
          treesitter_context = true,
          dap = {
            enabled = true,
            enable_ui = true,
          },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
