import deques
import sequtils
import strutils

let input = toSeq(readFile("day5.txt").strip.items)
              .map(proc (c: char): int = int(c))

proc react(data: seq[int]): int =
  var got = initDeque[int]()
  for c in data:
    if got.len > 0 and ((c xor 32) == got.peekLast):
      got.popLast
    else:
      got.addLast(c)
  return got.len

# part 1

echo react(input)

# part 2

var sizes: seq[int]

for i in 0 .. 26:
  let shorter = input
    .filter(proc (x: int): bool = x != 97 + i)
    .filter(proc (x: int): bool = x != 65 + i)
  sizes.add(react(shorter))

echo min(sizes)
