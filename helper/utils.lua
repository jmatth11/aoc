local M = {}

-- Convenience function for checking if file exists.
-- @param {string} filename The filename.
-- @return {boolean} True if file exists, false otherwise.
function M.file_exists(filename)
    local f = io.open(filename, "rb")
    if f then f:close() end
    return f ~= nil
end

-- Get subrange of table/array.
-- @param {table} t The table to get a subrange from.
-- @param {int} first The first index.
-- @param {int} last The last index.
-- @return {table} New table with the subrange of values.
function M.subrange(t, first, last)
    return table.move(t, first, last, 1, {})
end

function M.print_table(t)
    if t == nil then
        print("table is nil")
        return
    end
    if type(t) == "table" then
        for i,v in pairs(t) do
            print(i, " = ", v)
        end
    else
        tostring(t)
    end
end

return M
