import sets, sequtils, strutils, tables

let input = readFile("day2.txt").splitLines

var counts = {2: 0, 3: 0}.toTable

for line in input:
  var (twos, threes) = (0, 0)
  for c in line.toSet:
    let cnt = line.count(c)
    if cnt == 2:
      twos = 1
    elif cnt == 3:
      threes = 1
  counts[2] += twos
  counts[3] += threes

# part 1
echo counts[2] * counts[3]

block outer:
  for i in 0 .. input.len - 2:
    for j in i + 1 .. input.len - 1:
      var
        mismatches = 0

      for x in zip(input[i], input[j]):
        let (a, b) = (x[0], x[1])
        if a != b:
          mismatches += 1

      if mismatches == 1:
        # check manually
        echo input[i]
        echo input[j]
        break outer
