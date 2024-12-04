module AoC_Day_03
    
import AdventOfCode
using DelimitedFiles

function getData()
    filepath = pkgdir(AdventOfCode, "data", "03", "input.txt")
    data = []
    for ln in eachline(filepath)
        push!(data, ln)
    end
    return string(data...)
end


function solve_part1(data)
    # Find matches
    r = r"mul\((\d+),(\d+)\)"
    matches = collect(eachmatch(r, data))

    # Compute answer for each match
    ans = [parse(Int64, m[1]) * parse(Int64, m[2]) for m in matches]
    res = sum(ans)
end

function solve_part2(data)
    # Find computations and state transition
    r = r"mul\((\d+),(\d+)\)|do\(\)|don't\(\)"
    matches = collect(eachmatch(r, data))
    
    # Compute answers while keeping track of state
    ans = 0
    state = true
    for m in matches
        if isequal(m.match, "do()")
            state = true
        elseif isequal(m.match, "don't()")
            state = false
        else
            if state == true
                ans += parse(Int64, m[1]) * parse(Int64, m[2])
            end
        end
    end
    return ans
end

function test1()
    data = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
    ans = solve_part1(data)
    soln = 161
    println("Answer: $ans, Solution: $soln")
end

function test2()
    data = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
    ans = solve_part2(data)
    soln = 48
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

test1()
solve1()
test2()
solve2()

end
