import std.algorithm.iteration : map, sum;
import std.container.rbtree : redBlackTree;
import std.conv : to;
import std.file : readText;
import std.range : cycle;
import std.stdio : writeln;
import std.string : splitLines;

void main() {
  auto data = readText("day1.txt").splitLines
                                  .map!(to!int);
  // part 1
  writeln(data.sum);

  // part 2
  auto seen = redBlackTree(0);
  int total = 0;
  foreach (i; data.cycle) {
    total += i;
    if (total in seen) {
      writeln(total);
      break;
    }
    seen.insert(total);
  }
}
