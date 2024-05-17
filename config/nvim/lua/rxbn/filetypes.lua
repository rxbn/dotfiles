vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.tf", "*.tfvars", "*.tfstate" },
  command = "set filetype=terraform",
})

if
  string.find(vim.fn.getcwd(), vim.fn.expand("~/personal/ansible"))
  or string.find(vim.fn.getcwd(), vim.fn.expand("~/work/ansible"))
then
  vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.yml",
    command = "set filetype=yaml.ansible",
  })
end
