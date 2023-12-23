local nmap = require("rxbn.util.keymap").nmap
local vmap = require("rxbn.util.keymap").vmap
local xmap = require("rxbn.util.keymap").xmap

nmap({ "<leader>pv", vim.cmd.Ex })

nmap({ "<c-q>", "<Cmd>nohlsearch<CR>" })

nmap({ "<leader>qn", "<Cmd>cnext<CR>zz" })
nmap({ "<leader>qp", "<Cmd>cprev<CR>zz" })

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
