return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
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
        yamlls = {},
        jsonls = {},
        gopls = {},
        terraformls = {},
        ansiblels = {},
        bashls = {
          filetypes = { "sh", "bash", "zsh" },
        },
        dockerls = {},
        tflint = {},
        marksman = {},
        tsserver = {},
        tailwindcss = {},
        prismals = {},
        pylsp = {},
        clangd = {
          cmd = {
            "clangd",
            "--offset-encoding=utf-16",
          },
        },
      }

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          on_attach = require("rxbn.util.lsp").on_attach,
          capabilities = require("rxbn.util.lsp").capabilities,
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
        -- Formatter
        "autopep8",
        "gofumpt",
        "prettierd",
        "shfmt",
        "stylua",
        -- Linter
        "ansible-lint",
        "golangci-lint",
        "markdownlint",
        "pylint",
        "yamllint",
        -- DAP
        "debugpy",
        "delve",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)
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
