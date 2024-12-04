return {
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.statusline").setup()
      require("mini.diff").setup()
      require("mini.indentscope").setup({
        draw = {
          delay = 0,
          animation = require("mini.indentscope").gen_animation.none(),
        },
      })
    end,
  },
}
