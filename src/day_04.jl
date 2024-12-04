module AoC_Day_04
    
import AdventOfCode
using DelimitedFiles

function getTestData()
    filepath = pkgdir(AdventOfCode, "data", "04", "test.txt")
    data = stack(readlines(filepath), dims=1)
end

function getData()
    filepath = pkgdir(AdventOfCode, "data", "04", "input.txt")
    data = stack(readlines(filepath), dims=1)
end

function solve_part1(data)
    WORD = "XMAS" # The word we're trying to match
    width, height = size(data) # Bounds of our search grid

    function line_search(data, word, i, j, di, dj)
        # Build indices
        n = length(word)
        rows = [i + (c-1) * di for c = 1 : n]
        cols = [j + (c-1) * dj for c = 1 : n]

        # Check for out-of-bounds
        row_is_invalid = any(rows .< 1) | any(rows .> height)
        col_is_invalid = any(cols .< 1) | any(cols .> width)

        if row_is_invalid | col_is_invalid
            return false
        end
        
        # Now we know we're safe - grab string and compare
        idxs = CartesianIndex.(rows, cols)
        candidate = String(data[idxs])
        return isequal(candidate, word)
    end
    
    function check_square(data, word, i, j)
        # Make list of all directions
        directions = [1 0; # down
                      -1 0; # up
                      0 1; # right
                      0 -1; # left
                      1 1; # down and right
                      -1 1; # up and right
                      1 -1; # down and left
                      -1 -1] # up and left

        # Check how many (if any) words begin on this square
        n = length(word)

        count = 0
        for dir = 1 : size(directions, 1)
            # Get row/col steps to build line
            di = directions[dir, 1]
            dj = directions[dir, 2]
            # Check if the word is on that line
            found = line_search(data, word, i, j, di, dj)
            if found
                count += 1
            end
        end
        return count
    end

    count = 0
    for i = 1 : height
        for j = 1 : width
            count += check_square(data, WORD, i, j)
        end
    end
    return count
end

function solve_part2(data)
    
    function check_square(data, i, j)
        # Check if this square is the center of an X-mas, e.g.
        # M.S
        # .A.
        # M.S
        
        # Short-circuit: data[i, j] _must_ be an A
        if !isequal(data[i, j], 'A')
            return false
        end

        # Make sure square to search is in the grid
        height, width = size(data)
        is_row_valid = ((i - 1) >= 1) & ((i + 1) <= height)
        is_col_valid = ((j - 1) >= 1) & ((j + 1) <= width)
        if !(is_row_valid & is_col_valid)
            return false
        end
        
        # Divide into forward and back slash lines
        # Top left -> bottom right
        first_line_idxs = CartesianIndex.([i-1, i, i+1], [j-1, j, j+1])
        l1 = String(data[first_line_idxs])
        # Bottom left -> top right
        second_line_idxs = CartesianIndex.([i+1, i, i-1], [j-1, j, j+1])
        l2 = String(data[second_line_idxs])
        
        # Match forwards or backwards
        is_match(line) = isequal(line, "MAS") | isequal(reverse(line), "MAS")
        
        return is_match(l1) & is_match(l2)
    end
    
    # Now just search each square
    height, width = size(data)
    count = 0
    for i = 1 : height
        for j = 1 : width
            if check_square(data, i, j)
                count += 1
            end
        end
    end
    return count
end

function testGetData()
    data = getData()
end

function test1()
    data = getTestData()
    ans = solve_part1(data)
    soln = 18
    println("Answer: $ans, Solution: $soln")
end

function test2()
    data = getTestData()
    ans = solve_part2(data)
    soln = 9
    println("Answer: $ans, Solution: $soln")
end

function solve1()
    data = getData()
    ans = solve_part1(data)
    println("The result is $ans")
end

function solve2()
    data = getData()
    ans = solve_part2(data)
    println("The result is $ans")
end

testGetData()
test1()
solve1()
test2()
solve2()

end
