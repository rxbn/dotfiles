return {
  "mfussenegger/nvim-lint",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      yaml = { "yamllint" },
      ["yaml.ansible"] = { "ansible_lint" },
      go = { "golangcilint" },
      markdown = { "markdownlint" },
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
