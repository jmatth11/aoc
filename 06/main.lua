local helpers = require("utils")

-- Unit test iterator function.
-- Return an iterator function to iterate through all test input and answers.
-- @return {function} Iteration function.
local function test_iter()
    local i = 0
    local tests = {
        {input="mjqjpqmgbljsphdztnvjfqwrcgsmlb", answer=7},
        {input="bvwbjplbgvbhsrlpgdmjqwftvncz", answer=5},
        {input="nppdvjthqldpwncqszvftbrmjlhg", answer=6},
        {input="nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", answer=10},
        {input="zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", answer=11}
    }
    local N = #tests
    return function()
        i = i + 1
        if i <= N then return tests[i] end
    end
end

-- Find the marker index.
-- @param {string} line The current line to evaluate.
-- @param {int} start The starting position in the line.
-- @param {int} limit The limit of unique characters to find.
-- @return {int} The index.
local function marker_index(line, start, limit)
	local hash = {}
    local result = -1
	for i=start, #line do
        local c = line:sub(i, i)
        local tmp_hash = nil
        for j=1, #hash do
            if hash[j] == c then
                tmp_hash = helpers.subrange(hash, j+1, #hash)
            end
        end
        if tmp_hash ~= nil then
            hash = tmp_hash
        end
        hash[#hash+1] = c
        if #hash == limit then
            result = i
            break
        end
    end
    return result
end

-- The main executable function.
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
    -- unit tests
    for t in test_iter() do
        local test_index = marker_index(t.input)
        assert(test_index == t.answer, string.format("index %d is wrong for input: %s", test_index, t.input))
    end
    local f = io.open(filename, "rb")
    if f == nil then
        print("couldn't open file")
        return 1
    end
    local data = f:read("*all")
    f:close()
    local mark_index = marker_index(data, 1, 4)
    local message_index = marker_index(data, mark_index, 14)
    print("packet marker:", mark_index)
    print("message marker:", message_index)
end

-- Execute main.
Main()
