return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = "TSUpdate",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {},
      },
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "go",
          "json",
          "yaml",
          "markdown",
          "markdown_inline",
          "terraform",
          "bash",
          "gitcommit",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
        },
      })
    end,
  },
}
