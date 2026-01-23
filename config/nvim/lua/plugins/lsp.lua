return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      {
        dir = "/Users/robinscherrer/personal/kube-schema.nvim",
        opts = {},
      },
      {
        "j-hui/fidget.nvim",
        opts = {
          notification = {
            window = {
              winblend = 0,
            },
          },
        },
      },
      {
        "ray-x/lsp_signature.nvim",
        opts = {
          hint_enable = false,
        },
      },
    },
    config = function()
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
        yamlls = require("kube-schema").configure_yamlls(),
        jsonls = {},
        gopls = {},
        tofu_ls = {},
        ansiblels = {},
        bashls = {
          filetypes = { "sh", "bash", "zsh" },
        },
        dockerls = {},
        tflint = {},
        marksman = {},
        ts_ls = {},
        tailwindcss = {},
        pylsp = {},
        helm_ls = {},
      }

      for server in pairs(servers) do
        local server_opts = vim.tbl_deep_extend("force", {
          on_attach = require("rxbn.util.lsp").on_attach,
          capabilities = require("rxbn.util.lsp").capabilities,
        }, servers[server])

        vim.lsp.config(server, server_opts)
      end

      local ensure_installed = {}
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          ensure_installed[#ensure_installed + 1] = server
        end
      end

      ---@diagnostic disable-next-line: missing-fields
      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
      })
    end,
  },
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
    end,
  },
}
