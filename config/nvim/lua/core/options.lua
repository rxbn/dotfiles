vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.guicursor = ""

vim.opt.shortmess:append("I")
vim.opt.showmode = false
vim.opt.backspace = '2'
vim.opt.showcmd = false
vim.opt.laststatus = 3
vim.cmd [[highlight WinSeparator guibg=None]]
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.opt.swapfile = false

vim.wo.number = true

vim.wo.relativenumber = true

vim.opt.updatetime = 300

vim.opt.signcolumn = "yes"

vim.opt.scrolloff = 10

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

local yank_group = vim.api.nvim_create_augroup('HighlightYank', {})
vim.api.nvim_create_autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 40,
    })
  end,
})

local rxbn_group = vim.api.nvim_create_augroup('rxbn', {})
vim.api.nvim_create_autocmd('BufWritePre', {
  group = rxbn_group,
  pattern = '*',
  command = [[%s/\s\+$//e]],
})
