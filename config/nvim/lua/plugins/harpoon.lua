return {
  {
    "ThePrimeagen/harpoon",
    keys = {
      { "<c-e>", '<Cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>' },
      { "<leader>a", '<Cmd>lua require("harpoon.mark").add_file()<CR>' },
      { "<leader>1", '<Cmd>lua require("harpoon.ui").nav_file(1)<CR>' },
      { "<leader>2", '<Cmd>lua require("harpoon.ui").nav_file(2)<CR>' },
      { "<leader>3", '<Cmd>lua require("harpoon.ui").nav_file(3)<CR>' },
      { "<leader>4", '<Cmd>lua require("harpoon.ui").nav_file(4)<CR>' },
    },
  },
}
