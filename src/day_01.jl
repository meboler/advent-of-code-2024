module AoC_Day_01
    
import AdventOfCode
using DelimitedFiles

function getData()
    filepath = pkgdir(AdventOfCode, "data", "01", "input.txt")
    data =  readdlm(filepath, Int64)
end

function solve1()
    data = getData()

    # Sort to get matched pairs
    sort!(data, dims=1)

    # Find absolute differences
    diffs = abs.(diff(data, dims=2))

    # Sum to get total difference
    total_difference = sum(diffs)
    println("The total difference is $total_difference")
end

function solve2()
    data = getData()
    
    # Split lists
    list1 = data[:, 1]
    list2 = data[:, 2]

    # Build countmaps
    d1 = Dict([element => count(==(element), list1) for element in unique(list1)])
    d2 = Dict([element => count(==(element), list2) for element in unique(list2)])

    # Find shared elements
    matches = intersect(keys(d1), keys(d2))

    # Compute per-match scores
    scores = [key * d1[key] * d2[key] for key in matches]
    similarity = sum(scores)

    println("The list similarity is $similarity")
end

solve1()
solve2()

end
