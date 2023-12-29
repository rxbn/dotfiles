return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local linters = {
      "ansible-lint",
      "golangci-lint",
      "markdownlint",
      "pylint",
      "yamllint",
      "shellcheck",
    }
    require("rxbn.util.mason").install_packages(linters)

    local lint = require("lint")

    lint.linters_by_ft = {
      yaml = { "yamllint" },
      go = { "golangcilint" },
      markdown = { "markdownlint" },
      python = { "pylint" },
    }

    local augroup_lint = vim.api.nvim_create_augroup("custom-lsp-lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = augroup_lint,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
