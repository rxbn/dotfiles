local M = {}

local k8s_combined_schema_template = {
  oneOf = {},
}

local builtin_resources = require("yaml-companion.builtin.kubernetes.resources")

M.match = function(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  local api_versions = {}
  local kinds = {}

  for _, line in ipairs(lines) do
    local api_version = line:match("^apiVersion:%s*(%S+)")
    local kind = line:match("^kind:%s*(%S+)")

    if api_version then
      table.insert(api_versions, api_version)
    end
    if kind then
      table.insert(kinds, kind)
    end
  end

  local file_path = vim.api.nvim_buf_get_name(bufnr)
  local file_suffix = file_path:gsub("[/:\\]", "_")
  local k8s_combined_schema_path = vim.fn.stdpath("cache") .. "/k8s_combined_schema" .. file_suffix .. ".json"

  local augroup = vim.api.nvim_create_augroup(k8s_combined_schema_path, { clear = true })

  vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
    group = augroup,
    buffer = bufnr,
    callback = function()
      require("yaml-companion.context").schema(bufnr, M.match(bufnr))
    end,
  })

  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = augroup,
    callback = function()
      os.remove(k8s_combined_schema_path)
    end,
  })

  k8s_combined_schema_template.oneOf = {}

  for i, api_version in ipairs(api_versions) do
    local kind = kinds[i]
    if api_version and kind then
      local is_builtin = vim.tbl_contains(builtin_resources, kind)

      if is_builtin then
        table.insert(k8s_combined_schema_template.oneOf, {
          ["$ref"] = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master-standalone-strict/"
            .. string.lower(kind)
            .. ".json",
        })
      else
        local api_group = api_version:match("^[^/]+")
        local api_version_suffix = api_version:match("/(v%d+.*)")

        if api_group and api_version_suffix then
          table.insert(k8s_combined_schema_template.oneOf, {
            ["$ref"] = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/"
              .. api_group
              .. "/"
              .. string.lower(kind)
              .. "_"
              .. api_version_suffix
              .. ".json",
          })
        end
      end
    end
  end

  local json_output = vim.fn.json_encode(k8s_combined_schema_template)
  local cache_file = io.open(k8s_combined_schema_path, "w")
  if cache_file then
    cache_file:write(json_output)
    cache_file:close()
  else
    vim.api.nvim_err_writeln("Failed to write Kubernetes schema cache file: " .. k8s_combined_schema_path)
  end

  if #k8s_combined_schema_template.oneOf > 0 then
    return {
      name = "Kubernetes",
      uri = k8s_combined_schema_path,
    }
  end

  return nil
end

return M
