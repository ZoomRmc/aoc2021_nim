import zero_functional, std/strutils

func lower(a, b: (int, int)):(int, int) = (min(a[0], b[0]), min(a[1], b[1]))

func `+`(a, b: (int, int)):(int, int) = (a[0]+b[0], a[1]+b[1])

func triangle(n: int): int = n*(n+1) div 2

when isMainModule:
  let
    (input, minI, maxI) = (readFile("input/aoc07.txt").strip()).split(',') -->
      map(parseInt).fold( (newSeq[int](), high(int), 0), block:
        a[0].add(it)
        (a[0], min(it, a[1]), max(it, a[2]))
      )
    (p1, p2) = (minI..maxI) --> map(( let pos = it;
      input --> map( abs(pos - it) ).map( (it, triangle(it)) ).sum()
    )).reduce(lower(it.accu, it.elem))
  echo p1 #348996
  echo p2 #98231647
