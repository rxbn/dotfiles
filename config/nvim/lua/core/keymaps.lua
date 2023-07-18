local nmap = require("rxbn.keymap").nmap
local vmap = require("rxbn.keymap").vmap

nmap({ "<leader>pv", vim.cmd.Ex })

nmap({ "<c-q>", "<Cmd>nohlsearch<CR>" })

nmap({ "<m-.>", "<Cmd>bnext<CR>" })
nmap({ "<m-,>", "<Cmd>bprevious<CR>" })
nmap({ "<m-c>", "<Cmd>bd<CR>" })
nmap({ "<m-C>", "<Cmd>bd!<CR>" })

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
