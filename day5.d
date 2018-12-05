import std.stdio : writeln;
import std.file : readText;
import std.algorithm.mutation : remove;
import std.conv : to;
import std.algorithm.iteration : map, filter;
import std.string : strip;
import std.array : array;
import std.range.primitives : back, popBack, empty;
import std.range : iota;
import std.algorithm.searching : minElement;

ulong react(int[] data) {
  int[] stack;
  foreach (i; data) {
    if (!stack.empty && (i ^ 32) == stack.back) {
      stack.popBack();
    } else {
      stack ~= i;
    }
  }
  return stack.length;
}

void main() {
  int[] data = readText("day5.txt").strip.map!(to!int).array;
  writeln(data.react);

  ulong[] sizes;
  foreach (i; 26.iota) {
    sizes ~= data.filter!(x => x != 65 + i && x != 97 + i)
                 .array.react;
  }
  writeln(sizes.minElement);
}
