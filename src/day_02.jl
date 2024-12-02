module AoC_Day_01
    
import AdventOfCode
using DelimitedFiles

function getData()
    filepath = pkgdir(AdventOfCode, "data", "02", "input.txt")
    # can't do this, rows have different lengths!
    # data =  readdlm(filepath, Int64)
    data = []
    for ln in eachline(filepath)
        arr = [parse(Int, c) for c in split(ln)]
        push!(data, arr)
    end
    return data
end

function is_simply_safe(arr)
    # Check for monotonicity
    diffs = diff(arr)
    is_monotonic = all(diffs .> 0 ) | all(diffs .< 0)
    # Check for gradualityu
    step_sizes = abs.(diffs)
    is_gradual = all(step_sizes .>= 1) & all(step_sizes .<= 3)

    return is_monotonic & is_gradual
end

function is_complex_safe(arr)
    # Find all subarrays of length n-1
    subreports = []
    for i in eachindex(arr)
        # Get the ith subarray by excluding index i
        subreport_i = arr[1:end .!= i]
        push!(subreports, subreport_i)
    end
    # Check each of the subreports
    results = is_simply_safe.(subreports)
    return any(results)
end

function solve1()
    data = getData()
    # Broadcast safety check to each report
    safe_reports = is_simply_safe.(data)
    # Count total valid reports
    num_safe_reports = sum(safe_reports)
    println("There are $num_safe_reports safe reports")
end

function solve2()
    data = getData()
    # Broadcast safety check to each report
    safe_reports = is_simply_safe.(data) .| is_complex_safe.(data)
    # Count total valid reports
    num_safe_reports = sum(safe_reports)
    println("There are $num_safe_reports safe reports")
end

solve1()
solve2()

end
