termColors = require 'src.Addons.TermColors'

--- Prints a text with format styled
---@param _str string
function io.printf(_str)
    local s = _str:gsub("{[^}]+}", "")
    table.insert(_G.GLOBAL_BUFFER, ("[%s] %s"):format(os.date("%Y/%m/%d %H:%M:%S"), s))
    for t, c in pairs(termColors) do
        _str = _str:gsub("{" .. t .. "}", c)
    end
    io.write(_str)
end

return io.printf