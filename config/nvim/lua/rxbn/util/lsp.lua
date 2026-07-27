local augroup_highlight = vim.api.nvim_create_augroup("custom-lsp-references", { clear = true })
local nmap = require("rxbn.util.keymap").nmap

local custom_on_attach = function(client, bufnr)
  if client:supports_method("textDocument/inlineCompletion", bufnr) then
    vim.lsp.inline_completion.enable(true, {
      bufnr = bufnr,
    })

    vim.keymap.set("i", "<C-y>", function()
      if vim.fn.pumvisible() == 1 then
        return "<C-y>"
      end
      if vim.lsp.inline_completion.get({ bufnr = bufnr }) then
        return ""
      end
      return "<C-y>"
    end, {
      buffer = bufnr,
      desc = "Accept completion",
      expr = true,
    })

    vim.keymap.set("i", "<C-g>", function()
      vim.lsp.inline_completion.select({ bufnr = bufnr })
    end, {
      buffer = bufnr,
      desc = "Next inline completion",
    })
  end

  if client.name == "copilot" then
    return
  end

  if client:supports_method("textDocument/completion", bufnr) then
    vim.lsp.completion.enable(true, client.id, bufnr, {
      autotrigger = true,
    })
    vim.keymap.set("i", "<C-e>", vim.lsp.completion.get, {
      buffer = bufnr,
      desc = "Trigger LSP completion",
    })
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
updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false

vim.diagnostic.config({ virtual_text = true })

return {
  capabilities = updated_capabilities,
  setup = function()
    local augroup_attach = vim.api.nvim_create_augroup("custom-lsp-attach", { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
      group = augroup_attach,
      callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        custom_on_attach(client, args.buf)
      end,
    })
  end,
}
