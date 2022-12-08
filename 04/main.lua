local helpers = require("utils")

-- Check if a or b lies inbetween each other.
-- @param {table} a Table a.
-- @param {table} b Table b.
-- @return {boolean} True if one table exists fully in the other, false otherwise.
local function in_between(a, b)
    local a_in_b = a[1] >= b[1] and a[2] <= b[2]
    local b_in_a = b[1] >= a[1] and b[2] <= a[2]
    return a_in_b or b_in_a
end

-- Check if a or b overlaps each other at all.
-- @param {table} a Table a.
-- @param {table} b Table b.
-- @return {boolean} True if either table overlaps each other, false otherwise.
local function overlap(a, b)
    local a1_in_b = a[1] >= b[1] and a[1] <= b[2]
    local a2_in_b = a[2] >= b[1] and a[2] <= b[2]
    local b1_in_a = b[1] >= a[1] and b[1] <= a[2]
    local b2_in_a = b[2] >= a[1] and b[2] <= a[2]
    return a1_in_b or a2_in_b or b1_in_a or b2_in_a
end

-- Parse the given line into sections. They will be arranged in 4 elements.
-- The first 2 elements belong to one section, the second 2 elements belong to the second section.
-- @param {string} line The line to parse.
-- @return {table} The sections broken into 4 elements.
local function parse_line(line)
    local startSection = ""
    local endSection = ""
    local startEndFlag = false
    local sections = {}
    for i=1, #line do
        local c = line:sub(i,i)
        if c:match("%d") then
            if not startEndFlag then
                startSection = startSection .. c
            else
                endSection = endSection .. c
            end
        elseif c:match("-") then
                startEndFlag = true
        elseif c:match(",") then
            sections[#sections + 1] = tonumber(startSection)
            sections[#sections + 1] = tonumber(endSection)
            startEndFlag = false
            startSection = ""
            endSection = ""
        end
    end
    -- add last setion
    sections[#sections + 1] = tonumber(startSection)
    sections[#sections + 1] = tonumber(endSection)
    return sections
end

-- Handle evaluating the given line.
-- @param {string} line The current line to evaluate.
-- @param {table} context The shared context between calls.
local function handle(line, context)
    local sections = parse_line(line)
    local evaluation = false
    if context.overlap then
        evaluation = overlap(helpers.subrange(sections, 1, 2), helpers.subrange(sections, 3, 4))
    else
        evaluation = in_between(helpers.subrange(sections, 1, 2), helpers.subrange(sections, 3, 4))
    end
    if evaluation then
        context.sum = context.sum + 1
    end
end

-- Main function to execute.
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
    local overlapFlag = false
    if #arg == 2 then
        overlapFlag = true
    end
    local context = {sum = 0, overlap = overlapFlag}
    for line in io.lines(filename) do
        handle(line, context)
    end
    print("sum =", context.sum)
end

-- call main
Main()
