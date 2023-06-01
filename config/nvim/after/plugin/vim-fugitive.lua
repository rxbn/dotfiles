local nmap = require("rxbn.keymap").nmap

nmap { '<leader>gs', '<Cmd>Git<CR>' }
nmap { '<leader>ga', '<Cmd>Git add --all<CR>' }
nmap { '<leader>gc', '<Cmd>Git commit<CR>' }
nmap { '<leader>gC', '<Cmd>Git commit --amend<CR>' }
nmap { '<leader>gp', '<Cmd>Git push<CR>' }
nmap { '<leader>gP', '<Cmd>Git pull<CR>' }
nmap { '<leader>gb',
  function()
    vim.cmd('Git switch -c ' .. vim.fn.input('New branch name: '))
  end
}
nmap { '<leader>gB',
  function()
    vim.cmd('Git switch ' .. vim.fn.input('Existing branch name: '))
  end
}
