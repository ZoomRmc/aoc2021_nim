import zero_functional, std/[strutils, sets, tables]

proc visit(cave: string; visited: var HashSet[string];
          paths: TableRef[string, HashSet[string]]; canTwice: bool): int =
  if cave == "end": return 1
  elif cave[0].isLowerAscii(): visited.incl(cave)
  for next in paths[cave]:
    if next notin visited:
      result += next.visit(visited, paths, canTwice)
      visited.excl(next)
    elif canTwice and next[0].isLowerAscii and next != "start":
      result += next.visit(visited, paths, false)

when isMainModule:
  let input = lines("input/aoc12.txt") --> map(it.split('-'))
  var paths = newTable[string, HashSet[string]]()
  for p in input:
    paths.mgetOrPut(p[0], toHashSet([p[1]])).incl(p[1])
    paths.mgetOrPut(p[1], toHashSet([p[0]])).incl(p[0])
  var visited: HashSet[string]
  let p1 = "start".visit(visited, paths, false)
  echo p1 #3738
  let p2 = "start".visit(visited, paths, true)
  echo p2 #120506
