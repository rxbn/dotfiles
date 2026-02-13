return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        jsonnetfmt = {
          args = { "--pad-arrays", "-" },
        },
      },
      notify_on_error = false,
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
        terraform = { "tofu_fmt" },
        python = { "autopep8" },
        jsonnet = { "jsonnetfmt" },
        libsonnet = { "jsonnetfmt" },
        libjsonnet = { "jsonnetfmt" },
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
        "jsonnetfmt",
      }
      require("rxbn.util.mason").install_packages(formatters)

      require("conform").setup(opts)
    end,
  },
}
