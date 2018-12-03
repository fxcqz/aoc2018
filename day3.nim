import re, strutils, tables

type Line = array[5, string]
var grid = initTable[tuple[x, y: int], tuple[ids: seq[int]; count: int]]()

proc extract(matches: Line) =
  let
    id = matches[0].parseInt
    x = matches[1].parseInt
    y = matches[2].parseInt
    w = matches[3].parseInt
    h = matches[4].parseInt

  for row in y ..< y + h:
    for col in x ..< x + w:
      let key = (col, row)
      if key notin grid:
        grid[key] = (@[id], 1)
      else:
        grid[key].ids.add(id)
        grid[key].count += 1

proc solve =
  let pattern = re"#(\d+) @ (\d+),(\d+): (\d+)x(\d+)"
  var matches: Line
  for line in lines "day3.txt":
    if match(line, pattern, matches):
      extract(matches)

  var
    sum: int = 0
    noOverlap = initTable[int, int]()

  for x in grid.values:
    if x.count > 1:
      sum += 1

    for id in x.ids:
      if id notin noOverlap:
        noOverlap[id] = 1
      else:
        noOverlap[id] = max(x.count, noOverlap[id])

  # part 1
  echo sum

  # part 2
  for k, v in noOverlap.pairs:
    if v == 1:
      echo k
      break

when isMainModule:
  solve()
