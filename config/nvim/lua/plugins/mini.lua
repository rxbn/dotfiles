return {
  {
    "echasnovski/mini.surround",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
  },
  {
    "echasnovski/mini.comment",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring()
        end,
      },
    },
  },
}
