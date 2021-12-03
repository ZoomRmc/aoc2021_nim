import zero_functional, pegs
from std/strutils import parseInt, parseEnum

type Dir = enum
  F = "forward",
  D = "down",
  U = "up",

when isMainModule:
  let input: seq[(Dir, int)] = lines("input/aoc02.txt") --> map(
    if it =~ """Dir <- {\w+} \s {\d+}""".peg:
      ( parseEnum[Dir](matches[0]) , parseInt(matches[1]) )
    else: (F,0)
  )

  block Part1:
    let p = input --> fold( (0, 0),
      case it[0]
      of F: (a[0] + it[1], a[1])
      of D: (a[0], a[1] + it[1])
      of U: (a[0], a[1] - it[1])
    )
    let p1 = p[0]*p[1]
    echo p1
    # 1604850

  block Part2:
    let p = input --> fold( (0, 0, 0), (
      let n = it[1]
      case it[0]
      of F: (a[0] + n, a[1] + (a[2] * n), a[2])
      of D: (a[0], a[1], a[2]+n)
      of U: (a[0], a[1], a[2]-n)
    ) )
    let p2 = p[0]*p[1]
    echo p2
    #1685186100
