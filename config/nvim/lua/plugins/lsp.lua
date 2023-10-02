return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "nvimtools/none-ls.nvim",
        opts = function()
          local nullls = require("null-ls")
          return {
            on_attach = require("rxbn.lsp").on_attach,
            sources = {
              nullls.builtins.formatting.shfmt,
              nullls.builtins.formatting.stylua,
              nullls.builtins.formatting.gofumpt,
              nullls.builtins.formatting.terraform_fmt,
              nullls.builtins.formatting.prettierd.with({
                extra_filetypes = { "prisma" },
              }),
              nullls.builtins.formatting.jsonnetfmt.with({
                extra_args = { "--pad-arrays" },
              }),
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
        jsonnet_ls = {
          cmd = { "jsonnet-language-server", "--jpath", vim.fn.expand("~/.jsonnet") },
        },
        yamlls = {},
        jsonls = {},
        gopls = {},
        terraformls = {},
        ansiblels = {},
        bashls = {},
        dockerls = {},
        tflint = {},
        marksman = {},
        tsserver = {},
        tailwindcss = {},
        prismals = {},
      }

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          on_attach = require("rxbn.lsp").on_attach,
          capabilities = require("rxbn.lsp").capabilities,
        }, servers[server])

        require("lspconfig")[server].setup(server_opts)
      end

      local ensure_installed = {}
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          ensure_installed[#ensure_installed + 1] = server
        end
      end

      require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
        handlers = { setup },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {
      ensure_installed = {
        "prettierd",
        "shfmt",
        "stylua",
        "gofumpt",
        "yamllint",
        "ansible-lint",
        "golangci-lint",
        "markdownlint",
        "delve",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
}
