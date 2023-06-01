local ls = require("luasnip")

vim.keymap.set({ 'i', 's' }, '<c-l>', function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ 'i', 's' }, '<c-h>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })
