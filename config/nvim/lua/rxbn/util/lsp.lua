local augroup_highlight = vim.api.nvim_create_augroup("custom-lsp-references", { clear = true })
local nmap = require("rxbn.util.keymap").nmap

local buf_nnoremap = function(map_opts)
  if map_opts[3] == nil then
    map_opts[3] = {}
  end
  map_opts[3].buffer = 0

  nmap(map_opts)
end

local custom_on_attach = function(client, bufnr)
  if client.name == "copilot" then
    return
  end

  buf_nnoremap({ "<leader>ca", vim.lsp.buf.code_action })
  buf_nnoremap({ "gd", vim.lsp.buf.definition })
  buf_nnoremap({ "gt", vim.lsp.buf.type_definition })
  buf_nnoremap({ "gi", vim.lsp.buf.implementation })
  buf_nnoremap({ "gr", "<Cmd>Telescope lsp_references<CR>" })
  buf_nnoremap({ "<leader>dn", vim.diagnostic.goto_next })
  buf_nnoremap({ "<leader>dp", vim.diagnostic.goto_prev })
  buf_nnoremap({ "<leader>dl", "<Cmd>Telescope diagnostics<CR>" })
  buf_nnoremap({ "<leader>ds", vim.diagnostic.open_float })
  buf_nnoremap({ "K", vim.lsp.buf.hover })

  if client.server_capabilities.renameProvider then
    buf_nnoremap({ "<leader>r", vim.lsp.buf.rename })
  end

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
updated_capabilities.textDocument.completion.completionItem.snippetSupport = true
updated_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
vim.tbl_deep_extend("force", updated_capabilities, require("cmp_nvim_lsp").default_capabilities())
updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false

local border_style = "rounded"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = border_style,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = border_style,
})

vim.diagnostic.config({
  float = { border = border_style },
})

return {
  on_attach = custom_on_attach,
  capabilities = updated_capabilities,
}
