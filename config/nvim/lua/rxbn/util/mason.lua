local M = {}

M.install_packages = function(packages)
  local mr = require("mason-registry")
  local function ensure_installed()
    for _, tool in ipairs(packages) do
      local p = mr.get_package(tool)
      if not p:is_installed() then
        p:install()
      end
    end
  end
  if mr.refresh then
    mr.refresh(ensure_installed)
  else
    ensure_installed()
  end
end

return M
