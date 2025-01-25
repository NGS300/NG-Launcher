function table.contains(_table, _value)
    for _, v in ipairs(_table) do
        if v == _value then
            return true
        end
    end
    return false
end

function table.find(t, val, idx)
    idx = idx or 1
    if idx < 0 then idx = #t + idx + 1 end
    for i = idx,#t do
        if t[i] == val then return i end
    end
    return nil
end

function table.compare(t1, t2)
    if type(t1) ~= "table" or type(t2) ~= "table" then return false end

    for k in pairs(t1) do
        if t2[k] == nil then return false end
    end

    for k in pairs(t2) do
        if t1[k] == nil then return false end
    end

    for k, v in pairs(t1) do
        if type(v) == "table" and type(t2[k]) == "table" then
            if not table.compare(v, t2[k]) then return false end
        elseif v ~= t2[k] then return false end
    end

    return true
end

return table