packages = {}

local modules = {
  "core",
  "ui",
  "keys",
  "appearance",
  "completion",
  "vc",
  "files",
  "projects",
  "mason",
  "programming",
  "lsp",
  "dap",
  "terminal",
  "dashboard",
  "lazy"
}

for _, module in ipairs(modules) do
  local mout = (require('modules.' .. module))
  if type(mout) == 'table' then
    for _, v in ipairs(mout) do
      table.insert(packages, v)
    end
  end
end
