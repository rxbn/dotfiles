require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "lua",
    "go",
    "rust",
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
  rainbow = {
    enable = true,
    query = 'rainbow-parens',
    strategy = require("ts-rainbow.strategy.global"),
    max_file_lines = nil,
  },
}
