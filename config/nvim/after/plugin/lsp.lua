require("fidget").setup({
  window = {
    relative = "editor",
  },
})

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "yamlls", "gopls", "jsonls", "pylsp", "terraformls", "ansiblels", "jsonnet_ls",
    "bashls", "dockerls", "tflint", "rust_analyzer", "marksman", "tsserver", "tailwindcss", "prismals", "taplo" }
})

local augroup_highlight = vim.api.nvim_create_augroup("custom-lsp-references", { clear = true })
local augroup_format = vim.api.nvim_create_augroup("custom-lsp-format", { clear = true })
local nmap = require("rxbn.keymap").nmap
local imap = require("rxbn.keymap").imap

local buf_nnoremap = function(opts)
  if opts[3] == nil then
    opts[3] = {}
  end
  opts[3].buffer = 0

  nmap(opts)
end

local buf_inoremap = function(opts)
  if opts[3] == nil then
    opts[3] = {}
  end
  opts[3].buffer = 0

  imap(opts)
end

local format_on_save = function(client)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_clear_autocmds({
      group = augroup_format,
      buffer = 0,
    })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup_format,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
      buffer = 0,
    })
  end
end

local on_attach = function(client, bufnr)
  if client.name == "copilot" then
    return
  end

  buf_nnoremap { '<leader>rn', '<Cmd>Lspsaga rename<CR>' }
  buf_nnoremap { '<leader>ca', '<Cmd>Lspsaga code_action<CR>' }
  buf_nnoremap { 'gd', vim.lsp.buf.definition }
  buf_nnoremap { 'gt', vim.lsp.buf.type_definition }
  buf_nnoremap { 'gi', vim.lsp.buf.implementation }
  buf_nnoremap { 'gr', '<Cmd>Telescope lsp_references<CR>' }
  buf_nnoremap { '<leader>dn', '<Cmd>Lspsaga diagnostic_jump_next<CR>' }
  buf_nnoremap { '<leader>dp', '<Cmd>Lspsaga diagnostic_jump_prev<CR>' }
  buf_nnoremap { '<leader>dl', '<Cmd>Telescope diagnostics<CR>' }
  buf_nnoremap { '<leader>ds', '<Cmd>Lspsaga show_line_diagnostics<CR>' }
  buf_nnoremap { 'K', '<Cmd>Lspsaga hover_doc<CR>' }

  buf_inoremap { '<c-s>', vim.lsp.buf.signature_help }

  buf_nnoremap { '<leader>w',
    function()
      vim.api.nvim_clear_autocmds({
        group = augroup_format,
        buffer = 0,
      })
      vim.cmd("w")
      format_on_save(client)
    end
  }

  format_on_save(client)

  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_clear_autocmds({
      group = augroup_highlight,
      buffer = bufnr,
    })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = augroup_highlight,
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
      buffer = bufnr,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = augroup_highlight,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
      buffer = bufnr,
    })
  end
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
vim.tbl_deep_extend("force", updated_capabilities, require("cmp_nvim_lsp").default_capabilities())
updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false
updated_capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = updated_capabilities,
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
}

local yamlls_cfg = require("yaml-companion").setup({
  lspconfig = {
    on_attach = on_attach,
    capabilities = updated_capabilities,
  },
})
lspconfig.yamlls.setup(yamlls_cfg)

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = updated_capabilities,
  settings = {
    gopls = {
      gofumpt = true
    },
  },
}

lspconfig.jsonls.setup {
  on_attach = on_attach,
  capabilities = updated_capabilities,
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
}

lspconfig.pylsp.setup {
  on_attach = on_attach,
  capabilities = updated_capabilities,
}

lspconfig.terraformls.setup {
  on_attach = on_attach,
  capabilities = updated_capabilities,
}

lspconfig.tflint.setup {
  on_attach = on_attach,
  capabilities = updated_capabilities,
}

lspconfig.ansiblels.setup {
  on_attach = on_attach,
  capabilities = updated_capabilities,
}

lspconfig.jsonnet_ls.setup {
  on_attach = on_attach,
  capabilities = updated_capabilities,
  cmd = { "jsonnet-language-server", "--jpath", vim.fn.expand "~/.jsonnet" },
  settings = {
    formatting = {
      PadArrays = true,
    },
  },
}

lspconfig.bashls.setup {
  on_attach = on_attach,
  capabilities = updated_capabilities,
}

lspconfig.dockerls.setup {
  on_attach = on_attach,
  capabilities = updated_capabilities,
}

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = updated_capabilities,
}

lspconfig.marksman.setup {
  on_attach = on_attach,
  capabilities = updated_capabilities,
}

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = updated_capabilities,
}

lspconfig.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = updated_capabilities,
}

lspconfig.prismals.setup {
  on_attach = on_attach,
  capabilities = updated_capabilities,
}

lspconfig.taplo.setup {
  on_attach = on_attach,
  capabilities = updated_capabilities,
}

local null_ls = require("null-ls")

null_ls.setup {
  sources = {
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.diagnostics.ansiblelint,
    null_ls.builtins.diagnostics.golangci_lint,
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.formatting.rustfmt,
  },
  on_attach = on_attach,
}
