local M = {}

function M:new(o)
    local obj = o or {}
    if obj.name == nil then obj.name = "" end
    if obj.items == nil then obj.items = {} end
    self.__index = self
    return setmetatable(obj, self)
end

return M
