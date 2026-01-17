return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {},
      },
      {
        "HiPhish/rainbow-delimiters.nvim",
        submodules = false,
      },
    },
    config = function()
      local treesitter = require("nvim-treesitter")
      local function has_parser(lang)
        return vim.list_contains(treesitter.get_installed(), lang)
      end

      local function is_available(lang)
        return vim.list_contains(treesitter.get_available(), lang)
      end

      treesitter.setup({})

      local ensure_installed = {
        "lua",
        "go",
        "json",
        "yaml",
        "markdown",
        "markdown_inline",
        "terraform",
        "bash",
        "gitcommit",
      }

      treesitter.install(ensure_installed)

      local function start_when_ready(buf, lang, attempts)
        if attempts <= 0 or not vim.api.nvim_buf_is_valid(buf) then
          return
        end
        if has_parser(lang) then
          vim.treesitter.start(buf, lang)
          return
        end
        vim.defer_fn(function()
          start_when_ready(buf, lang, attempts - 1)
        end, 200)
      end

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          if ft == "" then
            return
          end

          local lang = vim.treesitter.language.get_lang(ft)
          if not lang then
            return
          end

          if not is_available(lang) then
            return
          end

          if not has_parser(lang) then
            treesitter.install({ lang })
            start_when_ready(args.buf, lang, 50)
            return
          end

          vim.treesitter.start(args.buf, lang)
        end,
      })
    end,
  },
}
