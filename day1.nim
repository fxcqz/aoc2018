import math
import sequtils
import strutils

proc second(data: seq[int]): int =
  var
    sum: int = 0
    seen: seq[int] = @[0]
    running: bool = true

  while running:
    for item in data:
      sum += item
      if sum in seen:
        running = false
        result = sum
        break
      seen.add(sum)

proc main =
  let
    input = open("day1.txt")
    data: seq[int] = toSeq(input.lines).map(parseInt)
    firstResult = data.sum
    secondResult = second(data)
  echo firstResult
  echo secondResult

when isMainModule:
  main()
