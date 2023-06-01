local nmap = require("rxbn.keymap").nmap

nmap { '<leader>sr', '<Cmd>lua require("spectre").open()<CR>' }
