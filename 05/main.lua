local helpers = require("utils")
local stack = require("stack")

-- Parse out the index of the numbers in the stack diagram.
-- @param {string} line The line with the numbers.
-- @return {table} The list of indexes for each number.
local function parse_numbers(line)
    local stack_indexes = {}
    for i=1, #line do
        local c = line:sub(i, i)
        if c:match("%d") then
            stack_indexes[#stack_indexes+1] = i
        end
    end
    return stack_indexes
end

-- Parse out stacks from the diagram in the given lines.
-- @param {table} The list of lines that contain the stack diagram.
-- @return {table} List of stack objects.
local function parse_stacks(lines)
    local last_line = lines[#lines]
    local crate_stacks = {}
    -- iterate through last_line and grab out each number
    local stack_indexes = parse_numbers(last_line)
    -- reverse iterate through list to add elements on stack in order
    for i=(#lines-1), 1, -1 do
        local cur_line = lines[i]
        for j=1, #stack_indexes do
            if crate_stacks[j] == nil then
                crate_stacks[j] = stack:new()
            end
            local parse_index = stack_indexes[j]
            local value = cur_line:sub(parse_index,parse_index)
            -- only add if it is a letter
            if value:match("%a") then
                crate_stacks[j]:push(value)
            end
        end
    end
    return crate_stacks
end

-- Handle parsing and executing move logic.
-- @param {string} line The current move line.
-- @param {table} context The shared context between calls.
-- @param {boolean} keep_order Flag to move in reverse order or same order.
local function handle_move(line, context, keep_order)
    if line == "" then return end
    local movements = {}
    for n in line:gmatch("%d+") do
        movements[#movements+1] = n
    end
    local move_n = tonumber(movements[1])
    local from_n = tonumber(movements[2])
    local to_n = tonumber(movements[3])
    -- use movements to swap elements in stack around
    local move_values = {}
    for _=1, move_n do
        move_values[#move_values+1] = context.crates[from_n]:pop()
    end
    local start = 1
    local last = #move_values
    local iter = 1
    if keep_order then
        start = last
        last = 1
        iter = -1
    end
    for i=start, last, iter do
        context.crates[to_n]:push(move_values[i])
    end
end

-- Convenience function to print out the top of each stack concatenated together.
-- @param {table} context The context holding the stacks.
local function print_results(context)
    local result = ""
    for i=1, #context.crates do
        local c = context.crates[i]
        result = result .. c:peek()
    end
    print(result)
end

-- The main executable.
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
    local keep_order = false
    if #arg == 2 then
        keep_order = true
    end
    local stacks_parsed = false
    local stack_lines = {}
    local context = {crates = {}}
    for line in io.lines(filename) do
        if not stacks_parsed then
            stack_lines[#stack_lines+1] = line
            -- find the first line with numbers and send that grouping
            -- of lines to be parsed for stack creation
            if line:match("%d") then
                context.crates = parse_stacks(stack_lines)
                stacks_parsed = true
            end
        else
            handle_move(line, context, keep_order)
        end
    end
    print_results(context)
end

Main()
