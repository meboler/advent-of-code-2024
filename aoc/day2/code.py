'''Solution to Day 2'''
import numpy as np
from numpy.lib.stride_tricks import sliding_window_view

def get_data():
    '''Get data from input file'''
    fname = 'input.txt'
    reports = []
    with open(fname, 'r') as f:
        for line in f:
            report = np.array([int(i) for i in line.split()])
            reports.append(report)
    return reports

def is_safe(report):
    diffs = np.diff(report)
    is_monotonic = np.all(diffs >= 0) | np.all(diffs <= 0)
    step_sizes = np.abs(diffs)
    is_gradual = np.all(step_sizes >= 1) & np.all(step_sizes <= 3)
    return is_monotonic and is_gradual

def has_safe_subreport(report):
    # Find all reports of length n-1
    n = len(report)
    subreports = [np.delete(report, idx) for idx in range(n)]
    safeties = [is_safe(subreport) for subreport in subreports]
    return any(safeties)

def part1() -> None:
    data = get_data()
    safety = [is_safe(report) for report in data]
    num_safe = sum(safety)
    print(f"There are {num_safe} safe reports")

def part2() -> None:
    data = get_data()
    safety = [is_safe(report) or has_safe_subreport(report) for report in data]
    num_safe = sum(safety)
    print(f"There are {num_safe} safe reports")

if __name__ == '__main__':
    part1()
    part2()
