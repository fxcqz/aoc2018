from collections import defaultdict
import re

with open('day6.txt', 'r') as f:
    data = [tuple(map(int, re.findall('\d+', line)))
            for line in f.readlines()]

W = max(data, key=lambda x: x[0])[0]
H = max(data, key=lambda x: x[1])[1]

grid = [[-1 for _ in range(W + 1)] for _ in range(H + 1)]

for y in range(H + 1):
    for x in range(W + 1):
        ids = [(i, abs(x - cx) + abs(y - cy))
               for i, (cx, cy) in enumerate(data)]
        id, val = min(ids, key=lambda x: x[1])
        if [x for _, x in ids].count(val) == 1:
            grid[y][x] = id

ignore = set()
ignore.update(set(grid[0]))
ignore.update(set(grid[-1]))
for i in range(1, len(grid) - 1):
    ignore.add(grid[i][0])
    ignore.add(grid[i][-1])

counts = defaultdict(int)
for y in grid:
    for x in y:
        if x not in ignore:
            counts[x] += 1

# part 1

print(max(counts.values()))

# part 2

area = 0
for y in range(H + 1):
    for x in range(W + 1):
        s = sum(abs(x - cx) + abs(y - cy) for cx, cy in data)
        if s < 10000:
            area += 1

print(area)
