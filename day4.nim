import algorithm, tables, re, sequtils, strutils

let
  pattern = re".*#(\d+).*"
  minutePattern = re".*:(\d+).*"
  input = sorted(readFile("day4.txt").strip.splitLines, cmp[string])

var
  matched: array[1, string]
  guard, start, stop: int
  guards = initTable[int, seq[tuple[start, stop: int]]]()
  times = initTable[int, int]()

for line in input:
  if match(line, pattern, matched):
    guard = matched[0].parseInt
  else:
    if match(line, minutePattern, matched):
      if "asleep" in line:
        start = matched[0].parseInt
      else:
        stop = matched[0].parseInt
        if guard notin times:
          times[guard] = 0
        else:
          times[guard] += stop - start
        if guard notin guards:
          guards[guard] = @[(start, stop)]
        else:
          guards[guard].add((start, stop))

# part 1
var id, time: int
for k, v in times.pairs:
  if v > time:
    time = v
    id = k

var asleep: array[60, int]
for time in guards[id]:
  for i in time.start ..< time.stop:
    asleep[i] += 1

echo id * find(asleep, max(asleep))

# part 2

var
  gid, minute, total: int

for id, times in guards.pairs:
  var asleep: array[60, int]
  for time in times:
    for i in time.start ..< time.stop:
      asleep[i] += 1
  if max(asleep) > total:
    total = max(asleep)
    gid = id
    minute = find(asleep, max(asleep))

echo gid * minute
