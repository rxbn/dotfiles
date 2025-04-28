local augroup_highlight = vim.api.nvim_create_augroup("custom-lsp-references", { clear = true })
local nmap = require("rxbn.util.keymap").nmap

local custom_on_attach = function(client, bufnr)
  if client.name == "copilot" then
    return
  end

  local map_opts = { buffer = bufnr }
  nmap({ "<leader>ca", vim.lsp.buf.code_action, map_opts })
  nmap({ "gd", vim.lsp.buf.definition, map_opts })
  nmap({ "gt", vim.lsp.buf.type_definition, map_opts })
  nmap({ "gi", vim.lsp.buf.implementation, map_opts })
  nmap({ "gr", require("telescope.builtin").lsp_references, map_opts })
  nmap({
    "]d",
    function()
      vim.diagnostic.jump({ count = 1, float = true })
    end,
    map_opts,
  })
  nmap({
    "[d",
    function()
      vim.diagnostic.jump({ count = -1, float = true })
    end,
    map_opts,
  })
  nmap({ "<leader>dl", "<Cmd>Telescope diagnostics<CR>", map_opts })
  nmap({ "<leader>ds", vim.diagnostic.open_float, map_opts })
  nmap({ "K", vim.lsp.buf.hover, map_opts })

  if client.server_capabilities.renameProvider then
    nmap({ "<leader>r", vim.lsp.buf.rename, map_opts })
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

vim.diagnostic.config({ virtual_text = true })

return {
  on_attach = custom_on_attach,
  capabilities = updated_capabilities,
}
