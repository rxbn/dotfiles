return {
  {
    "stevearc/conform.nvim",
    opts = {
      notify_on_error = false,
      formatters = {
        terraform_fmt = {
          command = "tofu",
        },
      },
      formatters_by_ft = {
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
        lua = { "stylua" },
        go = { "gofumpt" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        css = { "prettierd" },
        html = { "prettierd" },
        json = { "prettierd" },
        yaml = { "prettierd" },
        markdown = { "prettierd" },
        terraform = { "terraform_fmt" },
        python = { "autopep8" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    },
    config = function(_, opts)
      local formatters = {
        "autopep8",
        "gofumpt",
        "prettierd",
        "shfmt",
        "stylua",
      }
      require("rxbn.util.mason").install_packages(formatters)

      require("conform").setup(opts)
    end,
  },
}
