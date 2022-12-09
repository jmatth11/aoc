local M = {}

-- Create new instance of stack object.
-- @param {table} o Object to instantiate with.
-- @return {table} The new instance.
function M:new(o)
    local obj = o or { data = {} }
    if obj.data == nil then obj.data = {} end
    self.__index = self
    return setmetatable(obj, self)
end

-- Push item onto stack.
-- @param {any} item The item to push.
function M:push(item)
    self.data[#self.data+1] = item
end

-- Pop item off of stack.
-- @return {any} The item off the top of the stack.
function M:pop()
    local item = self.data[#self.data]
    self.data[#(self.data)] = nil
    return item
end

-- Peek at the top stack value.
-- @return {any} The top stack value.
function M:peek()
    return self.data[#(self.data)]
end

return M
