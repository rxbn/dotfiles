local nmap = require("rxbn.keymap").nmap
local imap = require("rxbn.keymap").imap
local vmap = require("rxbn.keymap").vmap

-- netrw
nmap({ "<leader>pv", vim.cmd.Ex })

-- Remove search highlighting
nmap({ "<c-q>", "<Cmd>nohlsearch<CR>" })

-- Buffer navigation
nmap({ "<m-.>", "<Cmd>bnext<CR>" })
nmap({ "<m-,>", "<Cmd>bprevious<CR>" })
nmap({ "<m-c>", "<Cmd>bd<CR>" })
nmap({ "<m-C>", "<Cmd>bd!<CR>" })

-- Always center vim motions
nmap({ "<c-d>", "<c-d>zz" })
nmap({ "<c-u>", "<c-u>zz" })
nmap({ "n", "nzzzv" })
nmap({ "N", "Nzzzv" })
nmap({ "<c-o>", "<c-o>zz" })
nmap({ "<c-i>", "<c-i>zz" })
nmap({ "}", "}zz" })
nmap({ "{", "{zz" })

-- Move code blocks
vmap({ "J", ":m '>+1<CR>gv=gv" })
vmap({ "K", ":m '<-2<CR>gv=gv" })

-- Copy to system clipboard
nmap({ "<leader>y", '"+y' })
nmap({ "<leader>Y", '"+Y' })

vmap({ "<leader>y", '"+y' })

-- Replace selected word globally
nmap({ "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]] })

-- tmux-sessionizer
nmap({ "<c-f>", "<Cmd>silent !tmux neww tmux-sessionizer<CR>" })

-- ThePrimeagen
imap({ "<c-c>", "<Esc>" })
