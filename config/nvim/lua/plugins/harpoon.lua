return {
  {
    "ThePrimeagen/harpoon",
    keys = {
      { "<c-e>", '<Cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>' },
      { "<leader>a", '<Cmd>lua require("harpoon.mark").add_file()<CR>' },
      { "<c-h>", '<Cmd>lua require("harpoon.ui").nav_file(1)<CR>' },
      { "<c-j>", '<Cmd>lua require("harpoon.ui").nav_file(2)<CR>' },
      { "<c-k>", '<Cmd>lua require("harpoon.ui").nav_file(3)<CR>' },
      { "<c-l>", '<Cmd>lua require("harpoon.ui").nav_file(4)<CR>' },
    },
  },
}
