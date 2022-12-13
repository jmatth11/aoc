local helpers = require("utils")
local fp_info = require("fp_info")
local stack = require("stack")

local function command(line, context)
    local m = line:match("cd (.+)")
    if m then
        if m == "/" then
            context.current_level = 1
        end
        if m == ".." then
            context.current_level:pop()
        else
            context.current_level:push(m)
        end
    end
    if line:match("ls") then
    end
end

local function fp(line, context)
    local m = line:match("(%d+)")
    if m then
        local name = line:match("(%a)")
    end
    if line:sub(1,3) == "dir" then
    end
end

local function evaluate_line(line, context)
    local c = line:sub(1,1)
    if c:match("%$") then
        command(line, context)
    else
        fp(line, context)
    end
end

function Main()
    if #arg < 1 then
        print("must supply an input file")
        return
    end
    local filename = arg[1]
    if not helpers.file_exists(filename) then
        print("file did not exist")
        return
    end
    -- TODO filesystem is more like tree structure.
    -- this won't work as an array.
    -- change from stack to something else
    local context = { system = {}, current_level=stack.new(nil) }
    for line in io.lines(filename) do
        evaluate_line(line, context)
    end
    print("done")
end

Main()
