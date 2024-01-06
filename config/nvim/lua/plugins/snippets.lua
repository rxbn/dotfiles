return {
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    keys = {
      {
        "<c-l>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<c-l>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<c-l>",
        function()
          require("luasnip").jump(1)
        end,
        mode = "s",
      },
      {
        "<c-h>",
        function()
          require("luasnip").jump(-1)
        end,
        mode = { "i", "s" },
      },
    },
  },
}
