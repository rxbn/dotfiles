return {
  "neovim/nvim-lspconfig",
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
  },
  "williamboman/mason-lspconfig.nvim",

  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    opts = {
      ui = {
        kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
      },
    },
  },

  "jose-elias-alvarez/null-ls.nvim",

  {
    "j-hui/fidget.nvim",
    tag = "legacy",
  },

  "b0o/schemastore.nvim",
  "someone-stole-my-name/yaml-companion.nvim",
}
