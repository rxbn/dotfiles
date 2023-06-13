local M = {}

local augroup_highlight = vim.api.nvim_create_augroup("custom-lsp-references", { clear = true })
local augroup_format = vim.api.nvim_create_augroup("custom-lsp-format", { clear = true })
local nmap = require("rxbn.keymap").nmap
local imap = require("rxbn.keymap").imap

local buf_nnoremap = function(map_opts)
  if map_opts[3] == nil then
    map_opts[3] = {}
  end
  map_opts[3].buffer = 0

  nmap(map_opts)
end

local buf_inoremap = function(map_opts)
  if map_opts[3] == nil then
    map_opts[3] = {}
  end
  map_opts[3].buffer = 0

  imap(map_opts)
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

M.on_attach = function(client, bufnr)
  if client.name == "copilot" then
    return
  end

  buf_nnoremap({ "<leader>rn", "<Cmd>Lspsaga rename<CR>" })
  buf_nnoremap({ "<leader>ca", "<Cmd>Lspsaga code_action<CR>" })
  buf_nnoremap({ "gd", vim.lsp.buf.definition })
  buf_nnoremap({ "gt", vim.lsp.buf.type_definition })
  buf_nnoremap({ "gi", vim.lsp.buf.implementation })
  buf_nnoremap({ "gr", "<Cmd>Telescope lsp_references<CR>" })
  buf_nnoremap({ "<leader>dn", "<Cmd>Lspsaga diagnostic_jump_next<CR>" })
  buf_nnoremap({ "<leader>dp", "<Cmd>Lspsaga diagnostic_jump_prev<CR>" })
  buf_nnoremap({ "<leader>dl", "<Cmd>Telescope diagnostics<CR>" })
  buf_nnoremap({ "<leader>ds", "<Cmd>Lspsaga show_line_diagnostics<CR>" })
  buf_nnoremap({ "K", "<Cmd>Lspsaga hover_doc<CR>" })

  buf_inoremap({ "<c-s>", vim.lsp.buf.signature_help })

  buf_nnoremap({
    "<leader>w",
    function()
      vim.api.nvim_clear_autocmds({
        group = augroup_format,
        buffer = 0,
      })
      vim.cmd("w")
      format_on_save(client)
    end,
  })

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

return M
