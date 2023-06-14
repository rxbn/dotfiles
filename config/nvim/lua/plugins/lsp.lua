return {
  {
    "neovim/nvim-lspconfig",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    dependencies = {
      {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        opts = {},
      },
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            "lua_ls",
            "yamlls",
            "gopls",
            "jsonls",
            "pylsp",
            "terraformls",
            "ansiblels",
            "jsonnet_ls",
            "bashls",
            "dockerls",
            "tflint",
            "rust_analyzer",
            "marksman",
            "tsserver",
            "tailwindcss",
            "prismals",
            "taplo",
          },
        },
      },
      {
        "glepnir/lspsaga.nvim",
        event = "LspAttach",
        opts = {
          ui = {
            kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
          },
        },
      },
      {
        "jose-elias-alvarez/null-ls.nvim",
        opts = function()
          local nullls = require("null-ls")
          return {
            sources = {
              nullls.builtins.formatting.prettier,
              nullls.builtins.formatting.shfmt,
              nullls.builtins.formatting.rustfmt,
              nullls.builtins.formatting.stylua,
              nullls.builtins.diagnostics.yamllint,
              nullls.builtins.diagnostics.ansiblelint,
              nullls.builtins.diagnostics.golangci_lint,
              nullls.builtins.diagnostics.markdownlint,
            },
          }
        end,
      },
      {
        "j-hui/fidget.nvim",
        tag = "legacy",
        opts = {
          window = {
            relative = "editor",
          },
        },
      },
      "b0o/schemastore.nvim",
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
        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = false,
              },
              schemas = require("schemastore").yaml.schemas(),
            },
          },
        },
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
            },
          },
        },
        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },
        pylsp = {},
        terraformls = {},
        ansiblels = {},
        jsonnet_ls = {
          cmd = { "jsonnet-language-server", "--jpath", vim.fn.expand("~/.jsonnet") },
          settings = {
            formatting = {
              PadArrays = true,
            },
          },
        },
        bashls = {},
        dockerls = {},
        tflint = {},
        rust_analyzer = {},
        marksman = {},
        tsserver = {},
        tailwindcss = {},
        prismals = {},
        taplo = {},
      }

      local function setup(server, server_opts)
        if not server_opts then
          return
        end

        if type(server_opts) ~= "table" then
          server_opts = {}
        end

        server_opts = vim.tbl_deep_extend("force", {
          on_attach = require("rxbn.lsp").on_attach,
          capabilities = require("rxbn.lsp").capabilities,
        }, server_opts)

        require("lspconfig")[server].setup(server_opts)
      end

      for server, server_opts in pairs(servers) do
        setup(server, server_opts)
      end
    end,
  },
}
