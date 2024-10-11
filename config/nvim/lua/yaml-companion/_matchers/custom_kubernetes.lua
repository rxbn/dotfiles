local M = {}

local homedir = vim.fn.expand("~")
-- renovate: datasource=github-releases depName=kubernetes/kubernetes
local k8s_version = "v1.31.1"

-- Template for the schema structure
local k8s_combined_schema_template = {
  oneOf = {},
}

-- Retrieve the list of built-in Kubernetes resources
local builtin_resources = require("yaml-companion.builtin.kubernetes.resources")

M.match = function(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  local api_versions = {}
  local kinds = {}

  -- Find all occurrences of apiVersion and kind
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

  -- Get the full path of the current buffer and use it to create a unique schema file name
  local file_path = vim.api.nvim_buf_get_name(bufnr)
  local file_suffix = file_path:gsub("[/:\\]", "_") -- Replace path separators with underscores
  local k8s_combined_schema_path = vim.fn.stdpath("cache") .. "/kubernetes_combined" .. file_suffix .. ".json"

  -- Create an autocmd-group for the schema file
  local augroup = vim.api.nvim_create_augroup(k8s_combined_schema_path, { clear = true })

  -- Autocmd to trigger the schema update when the file is changed
  vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
    group = augroup,
    buffer = bufnr,
    callback = function()
      require("yaml-companion.context").schema(bufnr, M.match(bufnr))
    end,
  })

  -- Autocmd to delete the schema file when leaving vim
  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = augroup,
    callback = function()
      os.remove(k8s_combined_schema_path)
    end,
  })

  -- Clear the schema to start fresh
  k8s_combined_schema_template.oneOf = {}

  -- Generate the schema for each apiVersion/kind pair
  for i, api_version in ipairs(api_versions) do
    local kind = kinds[i]
    if api_version and kind then
      local is_builtin = vim.tbl_contains(builtin_resources, kind)

      -- Include the default Kubernetes schema only if a built-in resource is detected
      if is_builtin then
        table.insert(k8s_combined_schema_template.oneOf, {
          ["$ref"] = homedir
            .. "/.yamlls/schemas/kubernetes-json-schema/"
            .. k8s_version
            .. "-standalone-strict/"
            .. string.lower(kind)
            .. ".json",
        })
      else
        -- Handle CRD schema for non-builtin resources
        local api_group = api_version:match("^[^/]+") -- Everything before the slash
        local api_version_suffix = api_version:match("/(v%d+.*)") -- Everything after the slash

        if api_group and api_version_suffix then
          local crd_schema_path = homedir
            .. "/.yamlls/schemas/CRDs-catalog/"
            .. api_group
            .. "/"
            .. string.lower(kind)
            .. "_"
            .. api_version_suffix
            .. ".json"
          table.insert(k8s_combined_schema_template.oneOf, {
            ["$ref"] = crd_schema_path,
          })
        end
      end
    end
  end

  -- Save the generated schema to the unique cache file, overwriting it
  local json_output = vim.fn.json_encode(k8s_combined_schema_template)
  local cache_file = io.open(k8s_combined_schema_path, "w")
  if cache_file then
    cache_file:write(json_output)
    cache_file:close()
  else
    vim.api.nvim_err_writeln("Failed to write to cache file: " .. k8s_combined_schema_path)
  end

  -- Return the Kubernetes schema configuration only if there are resources to validate
  if #k8s_combined_schema_template.oneOf > 0 then
    return {
      name = "Kubernetes",
      uri = k8s_combined_schema_path,
    }
  end

  return nil
end

return M
