vim.defer_fn(function()
  require("copilot").setup({
    panel = {
      enabled = false,
    },
    suggestion = {
      enabled = false,
    },
    filetypes = {
      ["*"] = true,
    },
  })
end, 100)
