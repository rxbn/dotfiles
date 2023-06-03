local nmap = require("rxbn.keymap").nmap

nmap { '<c-e>', '<Cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>' }
nmap { '<leader>a', '<Cmd>lua require("harpoon.mark").add_file()<CR>' }

nmap { '<c-h>', '<Cmd>lua require("harpoon.ui").nav_file(1)<CR>' }
nmap { '<c-j>', '<Cmd>lua require("harpoon.ui").nav_file(2)<CR>' }
nmap { '<c-k>', '<Cmd>lua require("harpoon.ui").nav_file(3)<CR>' }
nmap { '<c-l>', '<Cmd>lua require("harpoon.ui").nav_file(4)<CR>' }
