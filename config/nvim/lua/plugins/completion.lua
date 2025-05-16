return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      {
        "onsails/lspkind-nvim",
        config = function()
          require("lspkind").init({
            symbol_map = {
              Copilot = "",
            },
          })
          vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = require("catppuccin.palettes.mocha").green })
        end,
      },
      {
        "zbirenbaum/copilot-cmp",
        opts = {},
      },
    },
    config = function()
      vim.opt.completeopt = { "menu", "menuone", "noselect" }
      local cmp = require("cmp")
      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = {
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.complete(),
          ["<c-y>"] = cmp.mapping(
            cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Insert,
              select = true,
            }),
            { "i", "c" }
          ),
          ["<tab>"] = cmp.config.disable,
        },
        sources = cmp.config.sources({
          { name = "nvim_lua" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "copilot" },
        }, {
          { name = "path" },
          { name = "buffer", keyword_length = 5 },
        }),
        formatting = {
          format = require("lspkind").cmp_format({
            with_text = true,
            menu = {
              buffer = "[buf]",
              nvim_lsp = "[LSP]",
              nvim_lua = "[api]",
              path = "[path]",
              luasnip = "[snip]",
            },
          }),
        },
      })
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        enabled = false,
      },
      filetypes = {
        ["*"] = true,
      },
    },
  },
}
