local utilFunctions = {}

function utilFunctions.makeReadOnly(table)
    local proxy = {}
    local mt = {       -- create metatable
      __index = table,
      __newindex = function (t,k,v)
        error("attempt to update a read-only table", 2)
      end
    }
    setmetatable(proxy, mt)
    return proxy
end

return utilFunctions.makeReadOnly(utilFunctions)