local M = {}

local homedir = vim.fn.expand("~")
local builtin_resources = require("yaml-companion.builtin.kubernetes.resources")
-- renovate: datasource=github-releases depName=kubernetes/kubernetes
local k8s_version = "v1.29.3"
local k8s_builtin_url = homedir
  .. "/.yamlls/schemas/kubernetes-json-schema/"
  .. k8s_version
  .. "-standalone-strict/all.json"

local k8s_builtin_schema = {
  name = "Kubernetes",
  uri = k8s_builtin_url,
}

local crds_base_url = homedir .. "/.yamlls/schemas/CRDs-catalog/"

local function file_exists(path)
  return vim.fn.filereadable(path) == 1
end

M.match = function(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local group, api_version, resource = "", "", ""

  for _, line in ipairs(lines) do
    local kind_match = line:match("^kind:%s*(%S+)")
    if kind_match and vim.tbl_contains(builtin_resources, kind_match) then
      return k8s_builtin_schema
    end

    local apiVersion_match = line:match("^apiVersion:%s*(%S+)")
    if apiVersion_match then
      group, api_version = apiVersion_match:match("([^/]+)/([^/]+)")
    end
  end

  if group ~= "" and api_version ~= "" then
    for _, line in ipairs(lines) do
      local kind_match = line:match("^kind:%s*(%S+)")
      if kind_match then
        resource = kind_match
        break
      end
    end

    local url =
      string.format("%s/%s/%s_%s.json", crds_base_url, string.lower(group), string.lower(resource), api_version)
    if file_exists(url) then
      return {
        name = "Kubernetes CRD",
        uri = url,
      }
    end
  end

  return nil
end

return M
