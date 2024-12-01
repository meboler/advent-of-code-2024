'''Solution to Day 1'''
import numpy as np

def part1() -> None:
    '''Find the difference between the two lists'''
    # 1. Load the data
    data = np.loadtxt('input.txt', dtype=int)

    # 2. Sort columns to get indexed pairts
    sorted_data = np.sort(data, axis=0)

    # 3. Find per-item absolute differences
    diffs = np.abs(np.diff(sorted_data)).flatten()

    # 4. Get sum
    ans = np.sum(diffs)
    print(f"The difference is: {ans}")

def part2() -> None:
    '''Find the similarity between the two lists'''
    # 1. Load the data
    data = np.loadtxt('input.txt', dtype=int)
    
    # 2. Convert lists to dictionaries
    def list_to_occurrence_dict(x):
        '''Take a list and return a dictionary where the keys are the unique elements of the list and the values are the number of times the element appears'''
        vals, counts = np.unique(x, return_counts=True)
        return dict(zip(vals, counts))
    d1 = list_to_occurrence_dict(data[:, 0])
    d2 = list_to_occurrence_dict(data[:, 1])

    # 3. Find common keys
    matches = d1.keys() & d2.keys()
    
    # 4. Calculate scores
    scores = [key * d1[key] * d2[key] for key in matches]
    ans = np.sum(scores)
    print(f"The similarity is: {ans}")

if __name__ == '__main__':
    part1()
    part2()
