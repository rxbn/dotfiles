local nmap = require("rxbn.util.keymap").nmap
local vmap = require("rxbn.util.keymap").vmap
local xmap = require("rxbn.util.keymap").xmap

vim.keymap.set({ "i", "s" }, "<C-l>", function()
  if vim.snippet.active({ direction = 1 }) then
    return "<Cmd>lua vim.snippet.jump(1)<CR>"
  end
  return "<C-l>"
end, {
  desc = "Jump to next snippet tabstop",
  expr = true,
  silent = true,
})

vim.keymap.set({ "i", "s" }, "<C-h>", function()
  if vim.snippet.active({ direction = -1 }) then
    return "<Cmd>lua vim.snippet.jump(-1)<CR>"
  end
  return "<C-h>"
end, {
  desc = "Jump to previous snippet tabstop",
  expr = true,
  silent = true,
})

nmap({ "<leader>pv", vim.cmd.Ex })

nmap({ "<Esc>", "<Cmd>nohlsearch<CR>" })

nmap({ "]q", "<Cmd>cnext<CR>zz" })
nmap({ "[q", "<Cmd>cprev<CR>zz" })

xmap({ "<leader>p", [["_dP]] })

nmap({ "J", "mzJ`z" })
nmap({ "<c-d>", "<c-d>zz" })
nmap({ "<c-u>", "<c-u>zz" })
nmap({ "n", "nzzzv" })
nmap({ "N", "Nzzzv" })
nmap({ "<c-o>", "<c-o>zz" })
nmap({ "<c-i>", "<c-i>zz" })
nmap({ "}", "}zz" })
nmap({ "{", "{zz" })

vmap({ "J", ":m '>+1<CR>gv=gv" })
vmap({ "K", ":m '<-2<CR>gv=gv" })

nmap({ "<leader>y", '"+y' })
nmap({ "<leader>Y", '"+Y' })

vmap({ "<leader>y", '"+y' })

nmap({ "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]] })

nmap({ "<c-f>", "<Cmd>silent !tmux neww tmux-sessionizer<CR>" })
nmap({ "<c-g>", "<Cmd>silent !tmux neww tmux-sshionizer<CR>" })
