local nmap = require("rxbn.keymap").nmap

nmap { '<leader>hl', '<Cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>' }
nmap { '<leader>ha', '<Cmd>lua require("harpoon.mark").add_file()<CR>' }

for i = 1, 3 do
  nmap { '<leader>h' .. i, '<Cmd>lua require("harpoon.ui").nav_file(' .. i .. ')<CR>' }
end
