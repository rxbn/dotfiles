local M = {}

local api = vim.api
local uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main"

M.match = function(bufnr)
  local group, api_version, resource = "", "", ""
  local lines = api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for _, line in ipairs(lines) do
    if string.find(line, "^kind:") then
      _, resource = line:match("([^,]+):([^,]+)")
    elseif string.find(line, "^apiVersion") then
      local _, api_string = line:match("([^,]+):([^,]+)")
      group, api_version = api_string:match("([^,]+)/([^,]+)")
    end
  end

  local url = uri
    .. "/"
    .. string.lower(group):gsub("%s+", "")
    .. "/"
    .. string.lower(resource):gsub("%s+", "")
    .. "_"
    .. api_version
    .. ".json"

  return {
    name = "Kubernetes CRD",
    uri = url,
  }
end

return M
