vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.tf", "*.tfvars", "*.tfstate" },
  command = "set filetype=terraform",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.h",
  command = "set filetype=c",
})

if string.find(vim.fn.getcwd(), vim.fn.expand("~/personal/ansible")) then
  vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.yml",
    command = "set filetype=yaml.ansible",
  })
end
