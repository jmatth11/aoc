local M = {
    TypeEnum = {
        FILE="file",
        DIR="dir"
    }
}

function M:new(o)
    local obj = o or {}
    if obj.type == nil then obj.type = M.TypeEnum.FILE end
    if obj.size == nil then obj.size = 0 end
    self.__index = self
    return setmetatable(obj, self)
end

return M
