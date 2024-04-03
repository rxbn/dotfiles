return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = {},
    keys = {
      {
        "<leader>a",
        function()
          require("harpoon"):list():add()
        end,
      },
      {
        "<c-e>",
        function()
          require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
        end,
      },
      {
        "<c-h>",
        function()
          require("harpoon"):list():select(1)
        end,
      },
      {
        "<c-j>",
        function()
          require("harpoon"):list():select(2)
        end,
      },
      {
        "<c-k>",
        function()
          require("harpoon"):list():select(3)
        end,
      },
      {
        "<c-l>",
        function()
          require("harpoon"):list():select(4)
        end,
      },
    },
  },
}
