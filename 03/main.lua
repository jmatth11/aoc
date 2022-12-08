local helpers = require("utils")

-- Get the priority value of the input char.
-- @param {string} inputChar The input char.
-- @return {int} A positive value representing the characters priority, -1 if error.
local function get_priority(inputChar)
    local b = string.byte(inputChar)
    if b > 64 and b < 91 then
        return (b-64) + 26
    end
    if b > 96 and b < 123 then
        return b - 96
    end
    return -1
end

-- Function to handle problem 1 of AOC day 3.
-- @param {string} line The current line.
-- @param {table} context The shared context between calls.
local function prob_1(line, context)
    local N = #line
    local half = N/2
    for i=1, N do
        -- grab each character
        local c = line:sub(i,i)
        -- only track the first half of the string
        if i <= half then
            context.memory[c] = true
        else
            -- if duplicate, add up priority
            if context.memory[c] == true then
                local p = get_priority(c)
                if p == -1 then
                    print("character was invalid, ", c)
                    break
                end
                context.sum = context.sum + p
                -- clear out value since it's been counted
                context.memory[c] = nil
                break
            end
        end
    end
    -- empty out set
    context.memory = {}
end
--
-- Function to handle problem 1 of AOC day 3.
-- @param {int} index The current line index in the file.
-- @param {string} line The current line.
-- @param {table} context The shared context between calls.
local function prob_2(index, line, context)
    -- local flag to keep up with chars
    local charFlag = {}
    for i=1, #line do
        -- grab each character
        local c = line:sub(i,i)
        if charFlag[c] == nil then
            if context.memory[c] == nil then
                context.memory[c] = 1
            else
                context.memory[c] = context.memory[c] + 1
            end
            -- flag for the line so we don't count more than once
            charFlag[c] = true
        end
    end
    if math.fmod(index, 3) == 0 then
        local p = 0
        for i,v in pairs(context.memory) do
            if v == 3 then
                p = get_priority(i)
                if p == -1 then
                    print("character error")
                end
                break
            end
        end
        context.sum = context.sum + p
        context.memory = {}
    end
end

-- Main execution function.
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
    -- create set to hold chars
    local context = {memory = {}, sum = 0}
    local index = 1
    -- iterate through lines in file
    for line in io.lines(filename) do
        if arg[2] == nil then
            prob_1(line, context)
        else
            prob_2(index, line, context)
        end
        index = index + 1
    end
    print("sum of priorities: ", context.sum)
end

-- call main
Main()
