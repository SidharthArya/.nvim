packages = {}

local modules = {"core", "keys", "appearance", "completion", "vc", "files", "projects", "mason", "programming", "lsp", "terminal",
                 "dashboard", "lazy"}

for _, module in ipairs(modules) do
    local mout = (require('modules.' .. module))
    if type(mout) == 'table' then
        for _, v in ipairs(mout) do
            table.insert(packages, v)
        end
    end
end

