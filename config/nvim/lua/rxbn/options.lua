vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.termguicolors = true
opt.guicursor = ""
opt.showmode = false
opt.showcmd = true
opt.laststatus = 3
vim.cmd([[highlight WinSeparator guibg=None]])
opt.cursorline = true
opt.signcolumn = "yes"

opt.shortmess:append("I")

opt.swapfile = false

opt.tabstop = 2
opt.shiftwidth = 2
opt.shiftround = true
opt.expandtab = true

opt.relativenumber = true
opt.number = true

opt.updatetime = 300
opt.scrolloff = 10

opt.splitright = true

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

local yank_group = vim.api.nvim_create_augroup("HighlightYank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})

local rxbn_group = vim.api.nvim_create_augroup("rxbn", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = rxbn_group,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

vim.lsp.set_log_level("off")

vim.keymap.del("n", "grr")
vim.keymap.del("n", "gri")
vim.keymap.del("n", "gra")
vim.keymap.del("n", "grn")
