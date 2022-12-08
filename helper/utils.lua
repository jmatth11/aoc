local M = {}

-- Convenience function for checking if file exists.
-- @param {string} filename The filename.
-- @return {boolean} True if file exists, false otherwise.
function M.file_exists(filename)
    local f = io.open(filename, "rb")
    if f then f:close() end
    return f ~= nil
end

return M
